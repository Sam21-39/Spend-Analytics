import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:spend_analytics/core/error/failures.dart';
import 'package:spend_analytics/features/expense/domain/entities/expense_entity.dart';
import 'package:spend_analytics/features/expense/domain/repositories/i_expense_repository.dart';

@injectable
class ExportPdfUseCase {
  const ExportPdfUseCase(this._expenseRepo);
  final IExpenseRepository _expenseRepo;

  /// Returns PDF bytes for [userId] in the given month/year.
  Future<Either<Failure, Uint8List>> call({
    required String userId,
    required int month,
    required int year,
  }) async {
    final result = await _expenseRepo.getExpensesForMonth(
      userId: userId,
      month: month,
      year: year,
    );
    if (result.isLeft()) return result.map((_) => Uint8List(0));

    try {
      final bytes = await _buildPdf(result.getOrElse(() => []), month, year);
      return Right(bytes);
    } catch (e) {
      return Left(Failure.unknown('PDF generation failed', cause: e));
    }
  }

  Future<Uint8List> _buildPdf(
    List<ExpenseEntity> expenses,
    int month,
    int year,
  ) async {
    final doc = pw.Document();
    final total = expenses.fold<double>(0, (s, e) => s + e.amount);

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Expense Report — ${_monthName(month)} $year',
              style: pw.TextStyle(fontSize: 18),
            ),
          ),
          pw.Text('Total: ₹${total.toStringAsFixed(2)}'),
          pw.SizedBox(height: 12),
          pw.TableHelper.fromTextArray(
            headers: ['Date', 'Amount', 'Category', 'Type', 'Payment'],
            data: expenses
                .map(
                  (e) => [
                    '${e.transactionDate.day}/${e.transactionDate.month}/${e.transactionDate.year}',
                    '₹${e.amount.toStringAsFixed(2)}',
                    e.category,
                    e.expenseType.value,
                    e.paymentType.value,
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );
    return doc.save();
  }

  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  String _monthName(int month) =>
      month >= 1 && month <= 12 ? _months[month - 1] : '$month';
}
