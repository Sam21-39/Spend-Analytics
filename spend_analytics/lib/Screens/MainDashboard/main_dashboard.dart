import 'package:flutter/material.dart';
import 'package:spend_analytics/Model/spending_model.dart';
import 'package:spend_analytics/Screens/MainDashboard/itempage.dart';
import 'package:spend_analytics/Services/db_helper.dart';
import 'package:spend_analytics/UI/loading.dart';

import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:spend_analytics/Widgets/navigation_drawer.dart';

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

  DbHelper _dbHelper = DbHelper.dbInstance;

  List<SpendingModel> spm = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDbValues();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Material(
      type: MaterialType.canvas,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Hi Sam!',
              style: textTheme.headline4.copyWith(
                fontSize: setScreenUtill(32.0),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(
                  setScreenUtill(20.0),
                ),
                child: Text(
                  '$today',
                  style: textTheme.bodyText1.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          drawer: NavigationDrawer(),
          backgroundColor: Theme.of(context).backgroundColor,
          body: isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Loading(),
                )
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            setScreenUtill(40.0),
                          ),
                          child: Text(
                            'Nothing here yet. Let’s add some Spendings by pressing the “+” button....',
                            style: textTheme.subtitle1.copyWith(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.7),
                              fontSize: setScreenUtill(28.0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => ItemPage(
                    onSaveCallback: getDbValues,
                  ),
                ),
              )
                  .then(
                (value) {
                  setState(
                    () {
                      isLoading = value;
                    },
                  );
                },
              );
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).iconTheme.color,
              size: setScreenUtill(30.0),
            ),
          ),
        ),
      ),
    );
  }

  void getDbValues() async {
    var data = await _dbHelper.queryAll();
    data.map(
      (e) => spm.add(
        SpendingModel.fromJson(e),
      ),
    );
    if (data != null) {
      setState(() {
        isLoading = false;
      });
    }
    print(spm);
    print(data);
  }
}
