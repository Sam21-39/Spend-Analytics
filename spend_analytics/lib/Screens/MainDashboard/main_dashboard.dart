import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/UI/uitext.dart';
import 'package:spend_analytics/Utils/display_utils.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String today = DateTime.now().day.toString() +
      "." +
      DateTime.now().month.toString() +
      "." +
      DateTime.now().year.toString();

  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Hi Sam!',
              style: UiText.headerText,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(
                  setScreenUtill(20.0),
                ),
                child: Text(
                  '$today',
                  style: UiText.normalText.copyWith(
                    color: UiColors.primary,
                  ),
                ),
              ),
            ],
            shape: Border(
              bottom: BorderSide(
                color: UiColors.darkGrey,
              ),
            ),
          ),
          drawer: Drawer(
            elevation: 10.0,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: UiColors.darkGrey,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(
                      setScreenUtill(10.0),
                    ),
                    child: SvgPicture.asset("assets/images/sp_logo.svg"),
                  ),
                )
              ],
            ),
          ),
          backgroundColor: UiColors.background,
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      setScreenUtill(60.0),
                    ),
                    child: Text(
                      'Nothing here yet. Let’s add some Spendings by pressing the “+” button....',
                      style: UiText.subtitleText.copyWith(
                        color: UiColors.darkGrey.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            elevation: 8.0,
            child: Icon(
              Icons.add,
              color: UiColors.black,
              size: setScreenUtill(30.0),
            ),
            backgroundColor: UiColors.primary,
          ),
        ),
      ),
    );
  }
}
