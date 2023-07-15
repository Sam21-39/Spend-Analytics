import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Model/data_model.dart';
import 'package:spend_analytics/Model/spending_model.dart';
import 'package:spend_analytics/Services/db_helper.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/UI/uitext.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:spend_analytics/Utils/sp_constants.dart';

class Estimate extends StatefulWidget {
  @override
  _EstimateState createState() => _EstimateState();
}

class _EstimateState extends State<Estimate> {
  double income = 0.0, expense = 0.0;
  List<SpendingModel> spm = [];
  DbHelper _dbHelper = DbHelper.dbInstance;

  @override
  void initState() {
    super.initState();
    getDbValues();
    SharedPreferences.getInstance().then(
      (sp) {
        income = (sp.getDouble(AMOUNT) ?? 0).toDouble();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: EdgeInsets.all(
        setScreenUtill(20.0),
      ),
      children: [
        Text(
          "*This Chart shows the estimation of total Monthly Spendings, Monthly Income And Savings/Overdraft",
          style: textTheme.headlineMedium?.copyWith(
            fontSize: setScreenUtill(18.0),
            color: UiColors.red,
          ),
        ),
        SizedBox(
          height: setScreenUtill(20.0),
        ),
        Text(
          "Monthly Estimations: (in the scale of 1000 )",
          style: textTheme.headlineMedium?.copyWith(
            fontSize: setScreenUtill(26.0),
          ),
        ),
        SizedBox(
          height: setScreenUtill(20.0),
        ),
        Card(
          color: Colors.transparent,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            alignment: Alignment.center,
            height: setScreenUtill(600.0),
            padding: EdgeInsets.all(
              setScreenUtill(30.0),
            ),
            decoration: BoxDecoration(
              color: UiColors.darkGrey.withOpacity(0.75),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: BarChart(
                BarChartData(
                  groupsSpace: setScreenUtill(80.0),
                  maxY:
                      (income + min((income - expense).abs(), expense) + 1000) /
                          1000,
                  alignment: BarChartAlignment.center,
                  borderData: FlBorderData(show: false),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: UiColors.lightRed.withOpacity(0.75),
                      tooltipRoundedRadius: 12.0,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        // print(rod.y * 1000);
                        BarTooltipItem bti = BarTooltipItem(
                          (rod.fromY * 1000).floor().toString(),
                          UiText.normalText.copyWith(
                            fontSize: setScreenUtill(15.0),
                          ),
                        );
                        return bti;
                      },
                    ),
                  ),
                  barGroups: BarData.barData(income, expense)
                      .map(
                        (e) => BarChartGroupData(
                          barsSpace: setScreenUtill(100.0),
                          showingTooltipIndicators: [
                            income.floor(),
                            expense.floor(),
                          ],
                          x: e.id,
                          barRods: [
                            BarChartRodData(
                              toY: e.y / 1000,
                              color: e.color,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  gridData: FlGridData(
                    verticalInterval: 5,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      reservedSize: setScreenUtill(10.0),
                      getTitlesWidget: (double? value, TitleMeta? titleMeta) =>
                          Text(
                        BarData.barData(income, expense)
                            .firstWhere((element) => element.id == value)
                            .name,
                        style: UiText.normalText.copyWith(
                          fontSize: setScreenUtill(15.0),
                        ),
                      ),
                      showTitles: true,
                    )),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void getDbValues() async {
    spm.clear();

    var data = await _dbHelper.querySelected(
      DateTime.now().month.toString(),
      year: DateTime.now().year.toString(),
    );

    if (data != null && data.isNotEmpty) {
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    }
    spm.forEach((element) {
      expense += element.amount!.toDouble();
    });
    setState(() {});
  }
}
