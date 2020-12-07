import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:spend_analytics/Utils/sp_constants.dart';
import 'package:spend_analytics/main.dart';

class NavigationDrawer extends StatefulWidget {
  final tabChangeCallback;
  final bool isAnalysis;

  const NavigationDrawer({
    Key key,
    this.tabChangeCallback,
    this.isAnalysis = false,
  }) : super(key: key);
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      if (sp.getBool(THEME) != null)
        setState(() {
          isDarkTheme = sp.getBool(THEME);
        });
    });
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
              child: SvgPicture.asset("assets/images/sp_logo.svg"),
            ),
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
          ListTile(
            selected: true,
            leading: Icon(
              Icons.info_outline_rounded,
            ),
            title: Text("About App"),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Theme.of(context).dividerColor,
          ),
          ListTile(
            selected: !widget.isAnalysis,
            leading: Icon(
              Icons.home_rounded,
            ),
            title: Text("Home"),
            onTap: () {
              widget.tabChangeCallback(false);
              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: widget.isAnalysis,
            leading: Icon(
              Icons.bar_chart_rounded,
            ),
            title: Text("Spending Anlysis"),
            onTap: () {
              widget.tabChangeCallback(true);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
