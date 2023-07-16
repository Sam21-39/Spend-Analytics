import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
import 'package:spend_analytics/Core/Utils/display_utils.dart';

class Button extends StatefulWidget {
  final onPressed;
  final String text;

  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 60.h,
      padding: EdgeInsets.all(
        setScreenUtill(4.0),
      ),
      child: MaterialButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 10.0,
        color: Theme.of(context).buttonTheme.colorScheme?.background,
        disabledColor: UiColors.lightRed.withOpacity(0.5),
        disabledTextColor: Theme.of(context).disabledColor,
        textColor: Theme.of(context).textTheme.labelLarge?.color,
      ),
    );
  }
}
