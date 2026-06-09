import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/features/budget/domain/usecases/archive_budget_use_case.dart';
import 'package:spend_analytics/features/budget/domain/usecases/get_budget_progress_use_case.dart';
import 'package:spend_analytics/features/budget/domain/usecases/seed_default_budgets_use_case.dart';
import 'package:spend_analytics/features/budget/domain/usecases/upsert_budget_use_case.dart';

import 'budget_event.dart';
import 'budget_state.dart';

@injectable
class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc(
    this._getBudgetProgress,
    this._upsertBudget,
    this._archiveBudget,
    this._seedDefaults,
  ) : super(const BudgetState.initial()) {
    on<BudgetLoad>(_onLoad, transformer: droppable());
    on<BudgetUpsert>(_onUpsert);
    on<BudgetArchive>(_onArchive);
    on<BudgetSeedDefaults>(_onSeedDefaults);
  }

  final GetBudgetProgressUseCase _getBudgetProgress;
  final UpsertBudgetUseCase _upsertBudget;
  final ArchiveBudgetUseCase _archiveBudget;
  final SeedDefaultBudgetsUseCase _seedDefaults;

  Future<void> _onLoad(BudgetLoad event, Emitter<BudgetState> emit) async {
    emit(const BudgetState.loading());
    // Seed defaults first (idempotent)
    await _seedDefaults(
      userId: event.userId,
      month: event.month,
      year: event.year,
    );
    final result = await _getBudgetProgress(
      userId: event.userId,
      month: event.month,
      year: event.year,
    );
    result.fold(
      (f) => emit(BudgetState.failure(failure: f)),
      (progresses) => emit(BudgetState.loaded(progresses: progresses)),
    );
  }

  Future<void> _onUpsert(BudgetUpsert event, Emitter<BudgetState> emit) async {
    final result = await _upsertBudget(event.budget);
    result.fold(
      (f) => emit(BudgetState.failure(failure: f)),
      (_) => add(BudgetEvent.load(
        userId: event.budget.userId,
        month: event.budget.month,
        year: event.budget.year,
      )),
    );
  }

  Future<void> _onArchive(
      BudgetArchive event, Emitter<BudgetState> emit) async {
    final result =
        await _archiveBudget(id: event.id, userId: event.userId);
    result.fold(
      (f) => emit(BudgetState.failure(failure: f)),
      (_) {},
    );
  }

  Future<void> _onSeedDefaults(
      BudgetSeedDefaults event, Emitter<BudgetState> emit) async {
    await _seedDefaults(
      userId: event.userId,
      month: event.month,
      year: event.year,
    );
    add(BudgetEvent.load(
      userId: event.userId,
      month: event.month,
      year: event.year,
    ));
  }
}
