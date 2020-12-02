import 'package:flutter/material.dart';
import 'package:spend_analytics/Screens/MainDashboard/main_dashboard.dart';
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
          elevation: 0.0,
          shadowColor: null,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          padding: EdgeInsets.all(
            setScreenUtill(30.0),
          ),
          children: [
            Column(
              children: [
                Text(
                  'Your Monthly Income (Only Amount)',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: setScreenUtill(36.0),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100.h,
                ),
                TextField(
                  controller: amountController,
                  cursorRadius: Radius.circular(20.0),
                  cursorWidth: 5.w,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: setScreenUtill(18.0),
                      ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).focusColor,
                        width: 1.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: setScreenUtill(15.0),
                    ),
                    hintText: 'Amount',
                    hintStyle: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: setScreenUtill(18.0),
                        ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainDashboard(),
            ),
            (_) => false,
          ),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).iconTheme.color,
            size: setScreenUtill(30.0),
          ),
        ),
      ),
    );
  }
}
