import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/Utils/display_utils.dart';

class Estimate extends StatefulWidget {
  @override
  _EstimateState createState() => _EstimateState();
}

class _EstimateState extends State<Estimate> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: EdgeInsets.all(
        setScreenUtill(20.0),
      ),
      children: [
        Text(
          "*This Chart shows the estimation of monthly total spendings and monthly income",
          style: textTheme.headline4.copyWith(
            fontSize: setScreenUtill(18.0),
            color: UiColors.red,
          ),
        ),
        SizedBox(
          height: setScreenUtill(20.0),
        ),
        SizedBox(
          height: setScreenUtill(500.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              backgroundColor: UiColors.lightBlue,
              gridData: FlGridData(
                drawHorizontalLine: true,
                drawVerticalLine: true,
              ),
            ),
          ),
        )
      ],
    );
  }
}
