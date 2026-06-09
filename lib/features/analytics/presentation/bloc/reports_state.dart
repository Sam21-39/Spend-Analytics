import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/analytics/domain/models/reports_data.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';

part 'reports_state.freezed.dart';

@freezed
sealed class ReportsState with _$ReportsState {
  const factory ReportsState.initial() = ReportsInitial;
  const factory ReportsState.loading() = ReportsLoading;
  const factory ReportsState.loaded({
    required List<ExpenseEntity> allExpenses,
    required String selectedRange,
    required ReportsData data,
  }) = ReportsLoaded;
  const factory ReportsState.exporting() = ReportsExporting;
  const factory ReportsState.exported() = ReportsExported;
  const factory ReportsState.failure({required Failure failure}) = ReportsFailure;
}
