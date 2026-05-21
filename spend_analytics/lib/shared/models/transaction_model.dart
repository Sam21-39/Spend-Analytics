import 'package:meta/meta.dart';

@immutable
class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.category,
    required this.paymentMode,
    required this.transactionDate,
    required this.updatedAt,
    this.note,
    this.tags = const <String>[],
  });

  final String id;
  final String userId;
  final double amount;
  final String type;
  final String category;
  final String paymentMode;
  final DateTime transactionDate;
  final DateTime updatedAt;
  final String? note;
  final List<String> tags;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'amount': amount,
      'type': type,
      'category': category,
      'paymentMode': paymentMode,
      'transactionDate': transactionDate.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'note': note,
      'tags': tags,
    };
  }

  static TransactionModel fromJson(Map<String, dynamic> json) {
    final transactionDate = DateTime.parse('${json['transactionDate']}');
    final updatedAtRaw = json['updatedAt'];
    return TransactionModel(
      id: '${json['id']}',
      userId: '${json['userId']}',
      amount: (json['amount'] as num).toDouble(),
      type: '${json['type']}',
      category: '${json['category']}',
      paymentMode: '${json['paymentMode']}',
      transactionDate: transactionDate,
      updatedAt: updatedAtRaw == null
          ? transactionDate
          : DateTime.parse('$updatedAtRaw'),
      note: json['note'] as String?,
      tags: (json['tags'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => '$e')
          .toList(growable: false),
    );
  }
}
