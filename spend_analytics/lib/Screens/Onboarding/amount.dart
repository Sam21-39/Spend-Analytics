import 'package:flutter/material.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/UI/uitext.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Amount extends StatefulWidget {
  @override
  _AmountState createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  var amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: UiColors.black,
              size: setScreenUtill(30.0),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Color(0xfff2f2f2),
        body: ListView(
          padding: EdgeInsets.all(
            setScreenUtill(30.0),
          ),
          children: [
            Column(
              children: [
                Text(
                  'Your Monthly Income (Only Amount)',
                  style: UiText.subtitleText.copyWith(
                    fontSize: setScreenUtill(36.0),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100.h,
                ),
                TextField(
                  controller: amountController,
                  cursorColor: UiColors.primary,
                  cursorRadius: Radius.circular(20.0),
                  cursorWidth: 5.w,
                  style: TextStyle(
                    color: UiColors.black,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: UiColors.black,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: UiColors.lightBlue,
                        width: 1.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: setScreenUtill(15.0),
                    ),
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                      color: UiColors.darkGrey,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 8.0,
          child: Icon(
            Icons.arrow_forward_ios,
            color: UiColors.black,
            size: setScreenUtill(30.0),
          ),
          backgroundColor: UiColors.primary,
        ),
      ),
    );
  }
}
