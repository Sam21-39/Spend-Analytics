import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class ExportCsvUseCase {
  const ExportCsvUseCase(this._expenseRepo);
  final IExpenseRepository _expenseRepo;

  /// Returns CSV content as a [String] for [userId] in the given month/year.
  Future<Either<Failure, String>> call({
    required String userId,
    required int month,
    required int year,
  }) async {
    final result = await _expenseRepo.getExpensesForMonth(
      userId: userId,
      month: month,
      year: year,
    );
    return result.map(_buildCsv);
  }

  String _buildCsv(List<ExpenseEntity> expenses) {
    final buf = StringBuffer();
    buf.writeln(
      ['Date', 'Amount', 'Type', 'Category', 'Payment', 'Note', 'Tags']
          .map(_escape)
          .join(','),
    );
    for (final e in expenses) {
      buf.writeln(
        [
          e.transactionDate.toIso8601String(),
          e.amount.toStringAsFixed(2),
          e.expenseType.value,
          e.category,
          e.paymentType.value,
          e.note ?? '',
          e.tags.join(';'),
        ].map(_escape).join(','),
      );
    }
    return buf.toString();
  }

  static String _escape(String v) {
    if (v.contains(',') || v.contains('"') || v.contains('\n')) {
      return '"${v.replaceAll('"', '""')}"';
    }
    return v;
  }
}
