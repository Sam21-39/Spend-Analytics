import 'package:get/get.dart';
import 'package:spend_analytics/core/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class CloudBudget {
  const CloudBudget({
    required this.category,
    required this.month,
    required this.year,
    required this.limitAmount,
    this.updatedAt,
  });

  final String category;
  final int month;
  final int year;
  final double limitAmount;
  final DateTime? updatedAt;
}

class CloudRule {
  const CloudRule({
    required this.id,
    required this.ruleType,
    required this.parameters,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String ruleType;
  final Map<String, dynamic> parameters;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class SupabaseService extends GetxService {
  SupabaseClient? _client;

  bool get isEnabled => _client != null;
  String? get currentUserId => _client?.auth.currentUser?.id;
  bool get isAuthenticated => currentUserId != null;

  SupabaseClient get client {
    final instance = _client;
    if (instance == null) {
      throw StateError(
        'Supabase is not initialized. Set SUPABASE_URL and SUPABASE_ANON_KEY in assets/env/.env.',
      );
    }
    return instance;
  }

  Future<SupabaseService> init() async {
    final url = AppConfig.supabaseUrl;
    final anonKey = AppConfig.supabaseAnonKey;

    if (url.isEmpty || anonKey.isEmpty) {
      return this;
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
    _client = Supabase.instance.client;
    return this;
  }

  Future<void> upsertBudget({
    required String category,
    required int month,
    required int year,
    required double limitAmount,
  }) async {
    if (!isEnabled || !isAuthenticated) {
      return;
    }

    final userId = currentUserId!;
    final normalizedCategory = category.trim();

    final existing = await client
        .from('budgets')
        .select('id')
        .eq('user_id', userId)
        .eq('category_name', normalizedCategory)
        .eq('month', month)
        .eq('year', year)
        .limit(1);

    final existingRows =
        (existing as List<dynamic>).whereType<Map<String, dynamic>>().toList();

    if (existingRows.isEmpty) {
      await client.from('budgets').insert(<String, dynamic>{
        'user_id': userId,
        'category_id': null,
        'category_name': normalizedCategory,
        'month': month,
        'year': year,
        'limit_amount': limitAmount,
      });
      return;
    }

    final id = existingRows.first['id'];
    await client
        .from('budgets')
        .update(<String, dynamic>{
          'limit_amount': limitAmount,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', '$id')
        .eq('user_id', userId);
  }

  Future<List<CloudBudget>> fetchBudgetsForMonth({
    required int month,
    required int year,
  }) async {
    if (!isEnabled || !isAuthenticated) {
      return const <CloudBudget>[];
    }
    final userId = currentUserId!;

    final result = await client
        .from('budgets')
        .select('category_name,month,year,limit_amount,updated_at')
        .eq('user_id', userId)
        .eq('month', month)
        .eq('year', year);

    final rows = (result as List<dynamic>).whereType<Map<String, dynamic>>();
    return rows
        .map(
          (row) => CloudBudget(
            category: '${row['category_name'] ?? 'Others'}',
            month: (row['month'] as num?)?.toInt() ?? month,
            year: (row['year'] as num?)?.toInt() ?? year,
            limitAmount: (row['limit_amount'] as num?)?.toDouble() ?? 0,
            updatedAt: _parseDateTime(row['updated_at']),
          ),
        )
        .toList(growable: false);
  }

  Future<void> upsertRule({
    required String id,
    required String ruleType,
    required Map<String, dynamic> parameters,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) async {
    if (!isEnabled || !isAuthenticated) {
      return;
    }

    if (!Uuid.isValidUUID(fromString: id)) {
      return;
    }

    await client.from('user_rules').upsert(<String, dynamic>{
      'id': id,
      'user_id': currentUserId,
      'rule_type': ruleType,
      'parameters': parameters,
      'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt.toUtc().toIso8601String(),
      'updated_at': (updatedAt ?? DateTime.now()).toUtc().toIso8601String(),
    }, onConflict: 'id');
  }

  Future<List<CloudRule>> fetchRules() async {
    if (!isEnabled || !isAuthenticated) {
      return const <CloudRule>[];
    }
    final userId = currentUserId!;

    final result = await client
        .from('user_rules')
        .select('id,rule_type,parameters,is_active,created_at,updated_at')
        .eq('user_id', userId);

    final rows = (result as List<dynamic>).whereType<Map<String, dynamic>>();
    return rows
        .map(
          (row) => CloudRule(
            id: '${row['id']}',
            ruleType: '${row['rule_type'] ?? 'daily_limit'}',
            parameters: _mapOf(row['parameters']),
            isActive: row['is_active'] == true,
            createdAt: _parseDateTime(row['created_at']),
            updatedAt: _parseDateTime(row['updated_at']),
          ),
        )
        .toList(growable: false);
  }

  Future<void> deleteRule(String id) async {
    if (!isEnabled || !isAuthenticated) {
      return;
    }
    if (!Uuid.isValidUUID(fromString: id)) {
      return;
    }

    await client
        .from('user_rules')
        .delete()
        .eq('id', id)
        .eq('user_id', currentUserId!);
  }

  /// Fetches every transaction for [userId] from Supabase.
  /// Used on first login / reinstall to hydrate the local DB.
  Future<List<Map<String, dynamic>>> fetchAllTransactions({
    required String userId,
  }) async {
    if (!isEnabled || !isAuthenticated) {
      return const <Map<String, dynamic>>[];
    }
    final result = await client
        .from('transactions')
        .select(
          'id,user_id,amount,type,category_name,payment_mode,note,tags,transaction_date,updated_at',
        )
        .eq('user_id', userId)
        .order('transaction_date', ascending: false);

    final rows = (result as List<dynamic>).whereType<Map<String, dynamic>>();
    return rows.toList(growable: false);
  }

  Map<String, dynamic> _mapOf(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, next) => MapEntry('$key', next));
    }
    return const <String, dynamic>{};
  }

  DateTime? _parseDateTime(Object? value) {
    if (value == null) {
      return null;
    }
    return DateTime.tryParse('$value');
  }
}
