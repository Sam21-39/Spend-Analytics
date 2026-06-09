import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_analytics/features/settings/domain/entities/settings_entity.dart';
import 'package:spend_analytics/features/settings/domain/models/permission_statuses.dart';
import 'package:spend_analytics/features/settings/domain/usecases/clear_data_use_case.dart';
import 'package:spend_analytics/features/settings/domain/usecases/export_csv_use_case.dart';
import 'package:spend_analytics/features/settings/domain/usecases/export_pdf_use_case.dart';
import 'package:spend_analytics/features/settings/domain/usecases/get_settings_use_case.dart';
import 'package:spend_analytics/features/settings/domain/usecases/update_settings_use_case.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

import 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._getSettings,
    this._updateSettings,
    this._exportCsv,
    this._exportPdf,
    this._clearData,
    this._expenseRepo,
    this._localAuth,
    this._speechToText,
  ) : super(SettingsState(
          settings: const SettingsEntity(),
          isLoading: true,
        ));

  final GetSettingsUseCase _getSettings;
  final UpdateSettingsUseCase _updateSettings;
  final ExportCsvUseCase _exportCsv;
  final ExportPdfUseCase _exportPdf;
  final ClearDataUseCase _clearData;
  final IExpenseRepository _expenseRepo;
  final LocalAuthentication _localAuth;
  final SpeechToText _speechToText;

  StreamSubscription<dynamic>? _expenseSub;

  Future<void> load(String userId) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getSettings(userId);
    result.fold(
      (_) => emit(state.copyWith(isLoading: false)),
      (settings) {
        emit(state.copyWith(settings: settings, isLoading: false));
        _watchExpenseCount(userId);
        _refreshPermissions();
      },
    );
  }

  void _watchExpenseCount(String userId) {
    _expenseSub?.cancel();
    _expenseSub = _expenseRepo.watchExpenses(userId).listen((result) {
      if (isClosed) return;
      result.fold(
        (_) {},
        (expenses) => emit(state.copyWith(transactionCount: expenses.length)),
      );
    });
  }

  Future<void> updateCurrency(String userId, String currency) async {
    final updated = state.settings.copyWith(currency: currency);
    emit(state.copyWith(settings: updated));
    await _updateSettings(userId: userId, settings: updated);
  }

  Future<void> setNotificationsEnabled(String userId, bool value) async {
    if (value) {
      final status = await ph.Permission.notification.request();
      final granted = status.isGranted || status.isProvisional;
      final updated = state.settings.copyWith(notificationsEnabled: granted);
      emit(state.copyWith(
        settings: updated,
        permissions: state.permissions.copyWith(
          notifications: granted ? PermissionStatus.granted : PermissionStatus.denied,
        ),
      ));
      await _updateSettings(userId: userId, settings: updated);
      return;
    }
    final updated = state.settings.copyWith(notificationsEnabled: false);
    emit(state.copyWith(settings: updated));
    await _updateSettings(userId: userId, settings: updated);
  }

  Future<void> setBiometricLockEnabled(String userId, bool value) async {
    if (value) {
      final supported = await _localAuth.isDeviceSupported();
      final canCheck = await _localAuth.canCheckBiometrics;
      if (!supported || !canCheck) {
        emit(state.copyWith(
          permissions: state.permissions.copyWith(biometric: PermissionStatus.unavailable),
        ));
        return;
      }
      final authed = await _localAuth.authenticate(
        localizedReason: 'Enable biometric lock for Spend Analytics',
        biometricOnly: true,
      );
      final updated = state.settings.copyWith(biometricLockEnabled: authed);
      emit(state.copyWith(
        settings: updated,
        permissions: state.permissions.copyWith(
          biometric: authed ? PermissionStatus.granted : PermissionStatus.denied,
        ),
      ));
      await _updateSettings(userId: userId, settings: updated);
      return;
    }
    final updated = state.settings.copyWith(biometricLockEnabled: false);
    emit(state.copyWith(settings: updated));
    await _updateSettings(userId: userId, settings: updated);
  }

  Future<void> setVoiceEntryEnabled(String userId, bool value) async {
    final updated = state.settings.copyWith(voiceEntryEnabled: value);
    emit(state.copyWith(settings: updated));
    await _updateSettings(userId: userId, settings: updated);
  }

  Future<void> _refreshPermissions() async {
    final notifStatus = await ph.Permission.notification.status;
    final notif = notifStatus.isGranted || notifStatus.isProvisional
        ? PermissionStatus.granted
        : notifStatus.isDenied || notifStatus.isPermanentlyDenied
            ? PermissionStatus.denied
            : PermissionStatus.unknown;

    final hasMic = _speechToText.hasPermission == true;
    final mic = hasMic ? PermissionStatus.granted : PermissionStatus.unknown;

    final supported = await _localAuth.isDeviceSupported();
    final canCheck = await _localAuth.canCheckBiometrics;
    final biometric = !supported || !canCheck
        ? PermissionStatus.unavailable
        : PermissionStatus.unknown;

    if (!isClosed) {
      emit(state.copyWith(
        permissions: PermissionStatuses(
          notifications: notif,
          microphone: mic,
          biometric: biometric,
        ),
      ));
    }
  }

  Future<void> exportCsv(String userId) async {
    emit(state.copyWith(isExporting: true));
    final now = DateTime.now();
    final result = await _exportCsv(
      userId: userId,
      month: now.month,
      year: now.year,
    );
    result.fold(
      (_) => emit(state.copyWith(isExporting: false)),
      (csvString) async {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/spend_analytics_${now.millisecondsSinceEpoch}.csv',
        );
        await file.writeAsString(csvString);
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path, mimeType: 'text/csv')],
            subject: 'Spend Analytics Export',
          ),
        );
        if (!isClosed) emit(state.copyWith(isExporting: false));
      },
    );
  }

  Future<void> exportPdf(String userId) async {
    emit(state.copyWith(isExporting: true));
    final now = DateTime.now();
    final result = await _exportPdf(
      userId: userId,
      month: now.month,
      year: now.year,
    );
    result.fold(
      (_) => emit(state.copyWith(isExporting: false)),
      (bytes) async {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/spend_analytics_${now.millisecondsSinceEpoch}.pdf',
        );
        await file.writeAsBytes(bytes);
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path, mimeType: 'application/pdf')],
            subject: 'Spend Analytics Export',
          ),
        );
        if (!isClosed) emit(state.copyWith(isExporting: false));
      },
    );
  }

  Future<void> clearData(String userId) async {
    await _clearData(userId);
  }

  @override
  Future<void> close() {
    _expenseSub?.cancel();
    return super.close();
  }
}
