import 'package:flutter/material.dart';

class CategoryVisuals {
  static const Color _fallbackColor = Color(0xFF9DA8B8);

  static const Map<String, ({IconData icon, Color color})>
  _exact = <String, ({IconData icon, Color color})>{
    // Expense
    'food': (icon: Icons.coffee_rounded, color: Color(0xFFFF9F40)),
    'groceries': (
      icon: Icons.local_grocery_store_rounded,
      color: Color(0xFF3FDDA0),
    ),
    'rent': (icon: Icons.home_rounded, color: Color(0xFF7AC7FF)),
    'transport': (icon: Icons.directions_car_rounded, color: Color(0xFF5B9FFF)),
    'shopping': (icon: Icons.shopping_bag_rounded, color: Color(0xFFB0A0FF)),
    'bills': (icon: Icons.bolt_rounded, color: Color(0xFFFFB860)),
    'health': (icon: Icons.favorite_rounded, color: Color(0xFFFF6B6B)),
    'education': (icon: Icons.school_rounded, color: Color(0xFF8B8EFF)),
    'entertainment': (icon: Icons.movie_rounded, color: Color(0xFFFF9F40)),
    'travel': (icon: Icons.flight_takeoff_rounded, color: Color(0xFF5B9FFF)),
    'insurance': (icon: Icons.shield_rounded, color: Color(0xFF3FDDA0)),
    // Income
    'salary': (
      icon: Icons.account_balance_wallet_rounded,
      color: Color(0xFF3FDDA0),
    ),
    'freelance': (icon: Icons.laptop_mac_rounded, color: Color(0xFF5B9FFF)),
    'business': (icon: Icons.storefront_rounded, color: Color(0xFFB0A0FF)),
    'interest': (icon: Icons.savings_rounded, color: Color(0xFFFFB860)),
    'dividends': (icon: Icons.trending_up_rounded, color: Color(0xFF3FDDA0)),
    'bonus': (icon: Icons.workspace_premium_rounded, color: Color(0xFFFF9F40)),
    'rental income': (icon: Icons.apartment_rounded, color: Color(0xFF7AC7FF)),
    'refund': (icon: Icons.replay_rounded, color: Color(0xFF5B9FFF)),
    'gift received': (
      icon: Icons.card_giftcard_rounded,
      color: Color(0xFFB0A0FF),
    ),
    // Transfer
    'bank transfer': (
      icon: Icons.account_balance_rounded,
      color: Color(0xFF5B9FFF),
    ),
    'upi transfer': (icon: Icons.qr_code_rounded, color: Color(0xFF3FDDA0)),
    'wallet transfer': (icon: Icons.wallet_rounded, color: Color(0xFFB0A0FF)),
    'cash withdrawal': (
      icon: Icons.money_off_csred_rounded,
      color: Color(0xFFFF9F40),
    ),
    'cash deposit': (icon: Icons.payments_rounded, color: Color(0xFF3FDDA0)),
    'card payment': (icon: Icons.credit_card_rounded, color: Color(0xFF7AC7FF)),
    'credit card bill': (
      icon: Icons.receipt_long_rounded,
      color: Color(0xFFFF6B6B),
    ),
    'internal transfer': (
      icon: Icons.sync_alt_rounded,
      color: Color(0xFF9DA8B8),
    ),
    // Generic
    'income': (icon: Icons.arrow_downward_rounded, color: Color(0xFF3FDDA0)),
    'expense': (icon: Icons.paid_rounded, color: Color(0xFF5B9FFF)),
    'transfer': (icon: Icons.sync_alt_rounded, color: Color(0xFF7AC7FF)),
    'others': (icon: Icons.sell_rounded, color: Color(0xFF9DA8B8)),
  };

  static ({IconData icon, Color color}) resolve(String name, {String? type}) {
    final normalized = name.trim().toLowerCase();
    if (normalized.isEmpty) {
      return _fallbackForType(type);
    }

    final exact = _exact[normalized];
    if (exact != null) {
      return exact;
    }

    if (_containsAny(normalized, <String>['food', 'meal', 'dining'])) {
      return _exact['food']!;
    }
    if (_containsAny(normalized, <String>['grocery'])) {
      return _exact['groceries']!;
    }
    if (_containsAny(normalized, <String>['rent', 'home', 'house'])) {
      return _exact['rent']!;
    }
    if (_containsAny(normalized, <String>[
      'transport',
      'taxi',
      'fuel',
      'car',
    ])) {
      return _exact['transport']!;
    }
    if (_containsAny(normalized, <String>['shop', 'cloth'])) {
      return _exact['shopping']!;
    }
    if (_containsAny(normalized, <String>[
      'bill',
      'electric',
      'water',
      'gas',
    ])) {
      return _exact['bills']!;
    }
    if (_containsAny(normalized, <String>['health', 'medical', 'doctor'])) {
      return _exact['health']!;
    }
    if (_containsAny(normalized, <String>['education', 'course', 'study'])) {
      return _exact['education']!;
    }
    if (_containsAny(normalized, <String>['movie', 'entertain', 'game'])) {
      return _exact['entertainment']!;
    }
    if (_containsAny(normalized, <String>['travel', 'flight', 'trip'])) {
      return _exact['travel']!;
    }
    if (_containsAny(normalized, <String>['insurance'])) {
      return _exact['insurance']!;
    }

    if (_containsAny(normalized, <String>['salary', 'payroll'])) {
      return _exact['salary']!;
    }
    if (_containsAny(normalized, <String>['freelance'])) {
      return _exact['freelance']!;
    }
    if (_containsAny(normalized, <String>['business'])) {
      return _exact['business']!;
    }
    if (_containsAny(normalized, <String>['interest'])) {
      return _exact['interest']!;
    }
    if (_containsAny(normalized, <String>['dividend'])) {
      return _exact['dividends']!;
    }
    if (_containsAny(normalized, <String>['bonus'])) {
      return _exact['bonus']!;
    }
    if (_containsAny(normalized, <String>['rental'])) {
      return _exact['rental income']!;
    }
    if (_containsAny(normalized, <String>['refund'])) {
      return _exact['refund']!;
    }
    if (_containsAny(normalized, <String>['gift'])) {
      return _exact['gift received']!;
    }

    if (_containsAny(normalized, <String>['upi'])) {
      return _exact['upi transfer']!;
    }
    if (_containsAny(normalized, <String>['wallet'])) {
      return _exact['wallet transfer']!;
    }
    if (_containsAny(normalized, <String>['withdraw'])) {
      return _exact['cash withdrawal']!;
    }
    if (_containsAny(normalized, <String>['deposit'])) {
      return _exact['cash deposit']!;
    }
    if (_containsAny(normalized, <String>['card'])) {
      return _exact['card payment']!;
    }
    if (_containsAny(normalized, <String>['bank', 'transfer'])) {
      return _exact['bank transfer']!;
    }

    return _fallbackForType(type);
  }

  static IconData iconFor(String name, {String? type}) =>
      resolve(name, type: type).icon;

  static Color colorFor(String name, {String? type}) =>
      resolve(name, type: type).color;

  static bool _containsAny(String value, List<String> parts) =>
      parts.any(value.contains);

  static ({IconData icon, Color color}) _fallbackForType(String? type) {
    switch ((type ?? '').toLowerCase()) {
      case 'income':
        return (
          icon: Icons.arrow_downward_rounded,
          color: const Color(0xFF3FDDA0),
        );
      case 'transfer':
        return (icon: Icons.sync_alt_rounded, color: const Color(0xFF7AC7FF));
      case 'expense':
      default:
        return (icon: Icons.sell_rounded, color: _fallbackColor);
    }
  }
}
