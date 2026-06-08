extension DateTimeX on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Returns a DateTime at midnight (start of day).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns the first moment of the month.
  DateTime get startOfMonth => DateTime(year, month);

  /// Returns the last moment of the month (just before midnight of next month).
  DateTime get endOfMonth => DateTime(year, month + 1).subtract(const Duration(milliseconds: 1));

  /// Returns (year, month) as a string key, e.g. "2026-06".
  String get monthKey => '$year-${month.toString().padLeft(2, '0')}';

  /// Whether this date falls within [start] and [end] (inclusive).
  bool isBetween(DateTime start, DateTime end) =>
      !isBefore(start) && !isAfter(end);
}

extension NullableDateTimeX on DateTime? {
  bool get isNullOrPast {
    if (this == null) return true;
    return this!.isBefore(DateTime.now());
  }
}
