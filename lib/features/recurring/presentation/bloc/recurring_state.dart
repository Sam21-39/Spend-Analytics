import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';

part 'recurring_state.freezed.dart';

@freezed
sealed class RecurringState with _$RecurringState {
  const factory RecurringState.initial() = RecurringInitial;
  const factory RecurringState.loading() = RecurringLoading;
  const factory RecurringState.loaded({required List<RecurringEntity> items}) =
      RecurringLoaded;
  const factory RecurringState.saving() = RecurringSaving;
  const factory RecurringState.failure({required Failure failure}) =
      RecurringFailure;
}
