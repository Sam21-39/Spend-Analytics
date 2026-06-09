import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/recurring/domain/usecases/advance_recurring_due_date_use_case.dart';
import 'package:spend_analytics/features/recurring/domain/usecases/check_recurring_due_use_case.dart';
import 'package:spend_analytics/features/recurring/domain/usecases/create_recurring_use_case.dart';
import 'package:spend_analytics/features/recurring/domain/usecases/delete_recurring_use_case.dart';
import 'package:spend_analytics/features/recurring/domain/usecases/load_recurring_use_case.dart';
import 'package:spend_analytics/features/recurring/domain/usecases/update_recurring_use_case.dart';

import 'recurring_event.dart';
import 'recurring_state.dart';

@injectable
class RecurringBloc extends Bloc<RecurringEvent, RecurringState> {
  RecurringBloc(
    this._loadRecurring,
    this._createRecurring,
    this._updateRecurring,
    this._deleteRecurring,
    this._advanceDueDate,
    this._checkDue,
  ) : super(const RecurringState.initial()) {
    on<RecurringLoad>(_onLoad);
    on<RecurringCreate>(_onCreate);
    on<RecurringUpdate>(_onUpdate);
    on<RecurringDelete>(_onDelete);
    on<RecurringAdvanceDueDate>(_onAdvanceDueDate);
    on<RecurringCheckDue>(_onCheckDue);
  }

  final LoadRecurringUseCase _loadRecurring;
  final CreateRecurringUseCase _createRecurring;
  final UpdateRecurringUseCase _updateRecurring;
  final DeleteRecurringUseCase _deleteRecurring;
  final AdvanceRecurringDueDateUseCase _advanceDueDate;
  final CheckRecurringDueUseCase _checkDue;

  Future<void> _onLoad(RecurringLoad event, Emitter<RecurringState> emit) async {
    emit(const RecurringState.loading());
    final result = await _loadRecurring(event.userId);
    result.fold(
      (f) => emit(RecurringState.failure(failure: f)),
      (items) => emit(RecurringState.loaded(items: items)),
    );
  }

  Future<void> _onCreate(
      RecurringCreate event, Emitter<RecurringState> emit) async {
    emit(const RecurringState.saving());
    final result = await _createRecurring(event.item);
    result.fold(
      (f) => emit(RecurringState.failure(failure: f)),
      (_) => add(RecurringEvent.load(userId: event.item.userId)),
    );
  }

  Future<void> _onUpdate(
      RecurringUpdate event, Emitter<RecurringState> emit) async {
    emit(const RecurringState.saving());
    final result = await _updateRecurring(event.item);
    result.fold(
      (f) => emit(RecurringState.failure(failure: f)),
      (_) => add(RecurringEvent.load(userId: event.item.userId)),
    );
  }

  Future<void> _onDelete(
      RecurringDelete event, Emitter<RecurringState> emit) async {
    final result =
        await _deleteRecurring(id: event.id, userId: event.userId);
    result.fold(
      (f) => emit(RecurringState.failure(failure: f)),
      (_) => add(RecurringEvent.load(userId: event.userId)),
    );
  }

  Future<void> _onAdvanceDueDate(
      RecurringAdvanceDueDate event, Emitter<RecurringState> emit) async {
    final result =
        await _advanceDueDate(id: event.id, userId: event.userId);
    result.fold(
      (f) => emit(RecurringState.failure(failure: f)),
      (_) => add(RecurringEvent.load(userId: event.userId)),
    );
  }

  Future<void> _onCheckDue(
      RecurringCheckDue event, Emitter<RecurringState> emit) async {
    // Due items are persisted as notifications; reload to reflect any changes
    await _checkDue(event.userId);
    add(RecurringEvent.load(userId: event.userId));
  }
}
