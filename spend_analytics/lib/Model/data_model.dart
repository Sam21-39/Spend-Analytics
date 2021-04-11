import 'package:flutter/material.dart';
import 'package:spend_analytics/UI/uicolors.dart';

class DataModel {
  final int id;
  final String name;
  final double y;
  final Color color;

  DataModel({
    @required this.id,
    @required this.name,
    @required this.y,
    @required this.color,
  });
}

class BarData {
  static List<DataModel> barData(income, outcome) {
    List<DataModel> bardata = [
      DataModel(
        id: 0,
        name: "Income",
        y: income,
        color: UiColors.orange,
      ),
      DataModel(
        id: 1,
        name: "Expense",
        y: outcome,
        color: UiColors.red,
      ),
      DataModel(
        id: 2,
        name: income > outcome ? "Savings" : "Overdraft",
        y: (income - outcome).abs(),
        color: UiColors.primary,
      ),
    ];
    return bardata;
  }
}
