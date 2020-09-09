import 'package:flutter/material.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final onPressed;
  final double width;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.width = 250.0,
  }) : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: setHeight(60.0),
      child: MaterialButton(
        elevation: 12,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        animationDuration: Duration(milliseconds: 500),
        padding: EdgeInsets.all(
          setSize(10.0),
        ),
        child: Text(
          widget.text,
          style: UiText.buttonText,
        ),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: Colors.black26,
            width: 1.0,
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
