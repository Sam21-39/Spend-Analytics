import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Core/Model/spending_model.dart';
import 'package:spend_analytics/Core/Services/db_helper.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
import 'package:spend_analytics/Core/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  Map pieChartData = {}, pieChartDataAll = {};
  List<SpendingModel> spm = [], spm1 = [];
  DbHelper _dbHelper = DbHelper.dbInstance;

  int touchedIndex = -1, touchedIndexAll = -1;

  @override
  void initState() {
    super.initState();
    getDbValues();
    getDbValuesAll();
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
          "*This chart represents what percentage of spending is done and in which category. \n\nIt does not represent the exact amount of spending.",
          style: textTheme.bodyLarge?.copyWith(
            fontSize: setScreenUtill(18.0),
            color: UiColors.red,
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Current Month's Spendings:",
          style: textTheme.headlineMedium?.copyWith(
            fontSize: setScreenUtill(26.0),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        pieChartData.isEmpty
            ? Text(
                "Nothing added",
                style: textTheme.bodyLarge?.copyWith(),
                textAlign: TextAlign.center,
              )
            : Container(
                padding: EdgeInsets.all(
                  setScreenUtill(20.0),
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        enabled: true,
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      centerSpaceColor: UiColors.lightRed,
                      centerSpaceRadius: setScreenUtill(20.0),
                      sections: getChartValues(
                        pieChartData,
                        touchedIndex,
                        spm,
                      ),
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "Overall Spendings:",
          style: textTheme.headlineMedium?.copyWith(
            fontSize: setScreenUtill(26.0),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        pieChartDataAll.isEmpty
            ? Text(
                "Nothing added",
                style: textTheme.bodyLarge?.copyWith(),
                textAlign: TextAlign.center,
              )
            : Container(
                padding: EdgeInsets.all(
                  setScreenUtill(20.0),
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        enabled: true,
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      centerSpaceColor: UiColors.lightRed,
                      centerSpaceRadius: setScreenUtill(20.0),
                      sections: getChartValues(
                        pieChartDataAll,
                        touchedIndexAll,
                        spm1,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  List<PieChartSectionData> getChartValues(Map map, int index, spm) {
    List holder = map.keys.toList();

    //index is there for future use purpose.. can be removed in future...

    return holder
        .map(
          (val) => PieChartSectionData(
            value: (map[val] / (spm.length == 0 ? 1 : spm.length)) * 100,
            title:
                "${((map[val] / (spm.length == 0 ? 1 : spm.length)) * 100).floor()}%",
            radius: setScreenUtill(150.0),
            color: getChartColor(
                ((map[val] / (spm.length == 0 ? 1 : spm.length)) * 100)
                    .floor()),
            badgePositionPercentageOffset: 1,
            badgeWidget: Container(
              width: setScreenUtill(70.0),
              height: setScreenUtill(70.0),
              padding: EdgeInsets.all(
                setScreenUtill(5.0),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.0),
                color: UiColors.lightRed,
              ),
              child: SvgPicture.asset("assets/images/$val.svg"),
            ),
          ),
        )
        .toList();
  }

  Color getChartColor(int percent) {
    if (percent < 25) return UiColors.darkGrey;
    if (percent < 50) return UiColors.primary;
    if (percent < 75) return UiColors.lightBlue;
    return UiColors.orange;
  }

  void getDbValuesAll() async {
    spm1.clear();
    pieChartDataAll.clear();
    var data = await _dbHelper.queryAll();
    if (data != null && data.isNotEmpty) {
      data.forEach(
        (e) => spm1.add(
          SpendingModel.fromJson(e),
        ),
      );

      pieChartDataAll = calculationOfSpendings(spm1);
    }
    setState(() {});
  }

  void getDbValues() async {
    spm.clear();
    pieChartData.clear();
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

      pieChartData = calculationOfSpendings(spm);
    }
    setState(() {});
  }

  Map calculationOfSpendings(spm2) {
    var map = Map();
    spm2.forEach((element) {
      if (!map.containsKey(element.type.toLowerCase())) {
        map[element.type.toLowerCase()] = 1;
      } else {
        map[element.type.toLowerCase()] += 1;
      }
    });

    // print(map);
    return map;
  }
}
