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
        SvgPicture.asset("assets/images/under_construction.svg"),
        SizedBox(
          height: setScreenUtill(50.0),
        ),
        Text(
          "Coming Soon! \n...Stay Tuned...",
          style: textTheme.headline4.copyWith(
            fontSize: setScreenUtill(32.0),
            color: UiColors.lightBlue,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
