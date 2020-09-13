import 'package:flutter/material.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/Utils/display_utils.dart';

class CircularButton extends StatefulWidget {
  final onPressed;
  final double width;
  const CircularButton({
    Key key,
    @required this.onPressed,
    this.width = 70.0,
  }) : super(key: key);
  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.width,
      child: MaterialButton(
        onPressed: widget.onPressed,
        child: Icon(
          Icons.arrow_forward_ios,
          color: UiColors.black,
          size: setScreenUtill(36.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        elevation: 8.0,
        color: UiColors.primary,
        textColor: UiColors.black,
      ),
    );
  }
}
