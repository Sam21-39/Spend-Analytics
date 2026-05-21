import 'package:intl/intl.dart';

String formatInr(double amount) {
  final formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  return formatter.format(amount);
}
