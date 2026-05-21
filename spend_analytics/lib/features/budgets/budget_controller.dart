import 'package:get/get.dart';

class BudgetController extends GetxController {
  final categoryBudgets = <String, double>{
    'Food': 4000,
    'Transport': 2500,
    'Shopping': 3000,
  }.obs;
}
