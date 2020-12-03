import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spend_analytics/Utils/display_utils.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SpinKitChasingDots(
        color: Theme.of(context).primaryColor,
        size: setScreenUtill(30.0),
      ),
    );
  }
}
