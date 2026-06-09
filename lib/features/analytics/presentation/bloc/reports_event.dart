import 'package:freezed_annotation/freezed_annotation.dart';

part 'reports_event.freezed.dart';

@freezed
sealed class ReportsEvent with _$ReportsEvent {
  const factory ReportsEvent.load({
    required String userId,
    @Default('Month') String range,
  }) = ReportsLoad;
  const factory ReportsEvent.changeRange({required String range}) =
      ReportsChangeRange;
  const factory ReportsEvent.export({
    required String format,
    required String userId,
  }) = ReportsExport;
}
