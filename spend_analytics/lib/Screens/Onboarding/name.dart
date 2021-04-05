import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Screens/Onboarding/amount.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Utils/sp_constants.dart';

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  var nameController = TextEditingController();

  var _nameKey = GlobalKey<FormState>();

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
        body: Form(
          key: _nameKey,
          child: ListView(
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
                  TextFormField(
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
                      hintText: 'Your Name (max. 6 character)',
                      hintStyle: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: setScreenUtill(18.0),
                          ),
                    ),
                    onEditingComplete: () => TextInputAction.done,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    validator: (val) => val.isEmpty
                        ? "Required"
                        : val.length > 6
                            ? "Name should contain maximum 6 characters"
                            : null,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SharedPreferences sp = await SharedPreferences.getInstance();
            if (_nameKey.currentState.validate()) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Amount(),
                ),
              );
              sp.setString(
                NAME,
                nameController.text.trim(),
              );
            }
          },
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
