import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/features/recurring/domain/entities/recurring_entity.dart';

part 'recurring_event.freezed.dart';

@freezed
sealed class RecurringEvent with _$RecurringEvent {
  const factory RecurringEvent.load({required String userId}) = RecurringLoad;
  const factory RecurringEvent.create({required RecurringEntity item}) =
      RecurringCreate;
  const factory RecurringEvent.update({required RecurringEntity item}) =
      RecurringUpdate;
  const factory RecurringEvent.delete({
    required String id,
    required String userId,
  }) = RecurringDelete;
  const factory RecurringEvent.advanceDueDate({
    required String id,
    required String userId,
  }) = RecurringAdvanceDueDate;
  const factory RecurringEvent.checkDue({required String userId}) =
      RecurringCheckDue;
}
