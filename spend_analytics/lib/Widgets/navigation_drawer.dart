import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Model/spending_model.dart';
import 'package:spend_analytics/Screens/DrawerMenu/about.dart';
import 'package:spend_analytics/Screens/DrawerMenu/settings.dart';
import 'package:spend_analytics/Screens/Onboarding/amount.dart';
import 'package:spend_analytics/Screens/Onboarding/name.dart';
import 'package:spend_analytics/Services/db_helper.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:spend_analytics/Utils/sp_constants.dart';
import 'package:spend_analytics/main.dart';
import 'package:toast/toast.dart';

class NavigationDrawer extends StatefulWidget {
  final tabChangeCallback;
  final bool isAnalysis;
  final bool isEstimate;
  final bool isSpendingsAdded;
  const NavigationDrawer({
    Key key,
    this.tabChangeCallback,
    this.isEstimate = false,
    this.isAnalysis = false,
    this.isSpendingsAdded = false,
  }) : super(key: key);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool isDarkTheme = true;

  String versionInfo = "";

  double expense = 0.0, expenseNow = 0.0;
  double savings = 0.0, savingsNow = 0.0;
  List<SpendingModel> spm = [], spm2 = [];
  DbHelper _dbHelper = DbHelper.dbInstance;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      if (sp.getBool(THEME) != null)
        setState(() {
          isDarkTheme = sp.getBool(THEME);
        });
    });
    version();
    getDbValues();
    getDbValuesNow();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(
                setScreenUtill(10.0),
              ),
              width: 60.w,
              child: SvgPicture.asset("assets/images/sp_logo.svg"),
            ),
          ),
          ListTile(
            selected: !widget.isAnalysis && !widget.isEstimate,
            leading: Icon(
              Icons.home_rounded,
              color: !widget.isAnalysis && !widget.isEstimate
                  ? null
                  : Theme.of(context).iconTheme.color,
            ),
            title: Text("Home"),
            onTap: () {
              widget.tabChangeCallback(false, false);
              Navigator.pop(context);
            },
          ),
          InkWell(
            onTap: widget.isSpendingsAdded
                ? null
                : () => Toast.show(
                      "Add spendings to unlock",
                      context,
                      duration: Toast.LENGTH_LONG,
                    ),
            child: ListTile(
              enabled: widget.isSpendingsAdded ? true : false,
              selected: widget.isAnalysis,
              leading: Icon(
                Icons.pie_chart_rounded,
                color: widget.isAnalysis || !widget.isSpendingsAdded
                    ? null
                    : Theme.of(context).iconTheme.color,
              ),
              title: Text("Spending Anlysis"),
              onTap: widget.isSpendingsAdded
                  ? () {
                      widget.tabChangeCallback(true, false);
                      Navigator.pop(context);
                    }
                  : null,
              trailing: widget.isSpendingsAdded
                  ? null
                  : Icon(
                      Icons.lock,
                    ),
            ),
          ),
          InkWell(
            onTap: widget.isSpendingsAdded
                ? null
                : () => Toast.show(
                      "Add spendings to unlock",
                      context,
                      duration: Toast.LENGTH_LONG,
                    ),
            child: ListTile(
              enabled: widget.isSpendingsAdded ? true : false,
              selected: widget.isEstimate,
              leading: Icon(
                Icons.bar_chart_rounded,
                color: widget.isEstimate || !widget.isSpendingsAdded
                    ? null
                    : Theme.of(context).iconTheme.color,
              ),
              title: Text("Spending Estimate"),
              onTap: widget.isSpendingsAdded
                  ? () {
                      widget.tabChangeCallback(false, true);
                      Navigator.pop(context);
                    }
                  : null,
              trailing: widget.isSpendingsAdded
                  ? null
                  : Icon(
                      Icons.lock,
                    ),
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Theme.of(context).dividerColor,
          ),
          ListTile(
            leading: isDarkTheme
                ? Icon(
                    Icons.brightness_3_rounded,
                  )
                : Icon(
                    Icons.lightbulb,
                  ),
            title: Text(
              "Change Theme",
            ),
            selected: true,
            trailing: Text(
              isDarkTheme ? "Dark Mode" : "Light Mode",
              style: textTheme.caption,
            ),
            onTap: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();

              setState(() {
                isDarkTheme = !isDarkTheme;
                sp.setBool(THEME, isDarkTheme);
                appKey.currentState.setState(() {
                  isDarkMode = isDarkTheme;
                });
              });
            },
          ),
          // ListTile(
          //   selected: true,
          //   leading: Icon(Icons.perm_device_info_rounded),
          //   title: Text("Version: $versionInfo"),
          //   // trailing: Icon(
          //   //   Icons.arrow_forward_ios_rounded,
          //   // ),
          // ),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                )
                .then(
                  (value) => Navigator.pop(context),
                ),
            selected: true,
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
          // ListTile(
          //   onTap: () => Navigator.of(context)
          //       .push(
          //         MaterialPageRoute(
          //           builder: (context) => Name(
          //             isChanging: true,
          //           ),
          //         ),
          //       )
          //       .then(
          //         (value) => Navigator.pop(context),
          //       ),
          //   selected: true,
          //   leading: Icon(
          //     Icons.edit,
          //   ),
          //   title: Text(
          //     "Change Name",
          //   ),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios_rounded,
          //   ),
          // ),
          // ListTile(
          //   onTap: () => Navigator.of(context)
          //       .push(
          //         MaterialPageRoute(
          //           builder: (context) => Amount(
          //             isChanging: true,
          //           ),
          //         ),
          //       )
          //       .then(
          //         (value) => Navigator.pop(context),
          //       ),
          //   selected: true,
          //   leading: Icon(
          //     Icons.monetization_on_outlined,
          //   ),
          //   title: Text(
          //     "Change Amount",
          //   ),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios_rounded,
          //   ),
          // ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    height: setScreenUtill(200.0),
                    width: setScreenUtill(200.0),
                    child: Text(
                      "Total Expanse on current Month:\n ${spm2.isEmpty ? 'No Data' : expenseNow.floor()}",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: setScreenUtill(24.0),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ).then(
                (value) => Navigator.pop(context),
              );
            },
            selected: true,
            leading: Icon(
              Icons.monetization_on,
            ),
            title: Text(
              "Current Expense",
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    height: setScreenUtill(200.0),
                    width: setScreenUtill(200.0),
                    child: Text(
                      "Total ${savingsNow >= 0 ? 'savings' : 'overdraft'} on previous Month:\n ${spm2.isEmpty ? 'No Data' : savingsNow.abs().floor()}",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: setScreenUtill(24.0),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ).then(
                (value) => Navigator.pop(context),
              );
            },
            selected: true,
            leading: Icon(
              Icons.monetization_on,
            ),
            title: Text(
              "Current Savings",
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    height: setScreenUtill(200.0),
                    width: setScreenUtill(200.0),
                    child: Text(
                      "Total Expanse on previous Month:\n ${spm.isEmpty ? 'No Data' : expense.floor()}",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: setScreenUtill(24.0),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ).then(
                (value) => Navigator.pop(context),
              );
            },
            selected: true,
            leading: Icon(
              Icons.monetization_on,
            ),
            title: Text(
              "Previous Expense",
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    alignment: Alignment.center,
                    height: setScreenUtill(200.0),
                    width: setScreenUtill(200.0),
                    child: Text(
                      "Total ${savings >= 0 ? 'savings' : 'overdraft'} on current Month:\n ${spm.isEmpty ? 'No Data' : savings.abs().floor()}",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: setScreenUtill(24.0),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ).then(
                (value) => Navigator.pop(context),
              );
            },
            selected: true,
            leading: Icon(
              Icons.monetization_on,
            ),
            title: Text(
              "Previous Savings",
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }

  void version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionInfo = packageInfo.version;
    setState(() {});
  }

  void getDbValues() async {
    spm.clear();
    num amount = 0;
    SharedPreferences.getInstance().then((sp) {
      amount = sp.getInt(AMOUNT) == null ? "" : sp.getInt(AMOUNT);
      setState(() {});
    });
    var data = await _dbHelper.querySelected(
      (DateTime.now().month - 1).toString(),
      year: (DateTime.now().year).toString(),
    );

    if (data.isNotEmpty) {
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    }
    spm.forEach((element) {
      expense += element.amount.toDouble();
    });
    savings = amount - expense;
    setState(() {});
  }

  void getDbValuesNow() async {
    spm2.clear();
    num amount = 0;
    SharedPreferences.getInstance().then((sp) {
      amount = sp.getInt(AMOUNT) == null ? "" : sp.getInt(AMOUNT);
      setState(() {});
    });
    var data = await _dbHelper.querySelected(
      (DateTime.now().month).toString(),
      year: (DateTime.now().year).toString(),
    );

    if (data.isNotEmpty) {
      data.forEach(
        (e) => spm2.add(
          SpendingModel.fromJson(e),
        ),
      );
    }
    spm2.forEach((element) {
      expenseNow += element.amount.toDouble();
    });
    savingsNow = amount - expenseNow;
    setState(() {});
  }
}
