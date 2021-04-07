import 'package:flutter/material.dart';
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
      children: [],
    );
  }
}
