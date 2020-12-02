import 'package:flutter/material.dart';
import 'package:spend_analytics/Screens/Onboarding/amount.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  var nameController = TextEditingController();

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
                  'What Should I Call You?',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: setScreenUtill(36.0),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100.h,
                ),
                TextField(
                  controller: nameController,
                  cursorRadius: Radius.circular(20.0),
                  cursorWidth: 5.w,
                  textCapitalization: TextCapitalization.words,
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
                    hintText: 'Your Name',
                    hintStyle: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: setScreenUtill(18.0),
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Amount(),
            ),
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
