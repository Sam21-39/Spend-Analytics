import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';

String getCurrencySymbol() {
  if (Get.isRegistered<SettingsController>()) {
    final currency = Get.find<SettingsController>().selectedCurrency.value;
    switch (currency) {
      case 'USD': return '\$';
      case 'EUR': return '€';
      case 'GBP': return '£';
      case 'INR':
      default: return '₹';
    }
  }
  return '₹';
}

String formatInr(double amount) {
  String symbol = getCurrencySymbol();
  String locale = 'en_IN';
  
  if (Get.isRegistered<SettingsController>()) {
    final currency = Get.find<SettingsController>().selectedCurrency.value;
    switch (currency) {
      case 'USD':
        symbol = '\$';
        locale = 'en_US';
        break;
      case 'EUR':
        symbol = '€';
        locale = 'en_IE'; // For EUR formatting
        break;
      case 'GBP':
        symbol = '£';
        locale = 'en_GB';
        break;
      case 'INR':
      default:
        symbol = '₹';
        locale = 'en_IN';
        break;
    }
  }

  final formatter = NumberFormat.currency(locale: locale, symbol: symbol);
  return formatter.format(amount);
}
