import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spend_analytics/core/error/failures.dart';

import 'biometric_state.dart';

@lazySingleton
class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit(this._localAuth) : super(const BiometricState.locked());

  final LocalAuthentication _localAuth;

  static const _gracePeriod = Duration(minutes: 15);
  DateTime? _lastAuthTime;

  bool get isWithinGrace {
    if (_lastAuthTime == null) return false;
    return DateTime.now().difference(_lastAuthTime!) < _gracePeriod;
  }

  /// Call on app resume. Emits locked if biometric is enabled and grace expired.
  void checkLockState({required bool biometricEnabled}) {
    if (!biometricEnabled) {
      emit(const BiometricState.unlocked());
      return;
    }
    if (isWithinGrace) {
      emit(const BiometricState.unlocked());
    } else {
      emit(const BiometricState.locked());
    }
  }

  Future<void> authenticate() async {
    if (isClosed) return;
    emit(const BiometricState.unlocking());
    try {
      final result = await _localAuth.authenticate(
        localizedReason: 'Unlock Spend Analytics',
        persistAcrossBackgrounding: true,
      );
      if (result) {
        _lastAuthTime = DateTime.now();
        emit(const BiometricState.unlocked());
      } else {
        emit(const BiometricState.locked());
      }
    } catch (e) {
      emit(BiometricState.error(failure: Failure.unknown(e.toString(), cause: e)));
    }
  }

  void forceUnlock() {
    _lastAuthTime = DateTime.now();
    emit(const BiometricState.unlocked());
  }
}
