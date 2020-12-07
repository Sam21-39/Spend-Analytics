import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Model/spending_model.dart';
import 'package:spend_analytics/Screens/MainDashboard/itempage.dart';
import 'package:spend_analytics/Services/db_helper.dart';

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

  bool isAnalysis = false;
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
          drawer: NavigationDrawer(
            isAnalysis: isAnalysis,
            tabChangeCallback: changeTabCallback,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: isAnalysis
              ? Container()
              : ListView(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: PopupMenuButton(
                        tooltip: "Date Filter",
                        icon: Icon(
                          Icons.filter_list_rounded,
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: "all",
                            child: Text('All'),
                          ),
                          const PopupMenuItem<String>(
                            value: "current",
                            child: Text(
                              'Current Month',
                            ),
                          ),
                        ],
                        onSelected: (val) =>
                            val == "all" ? getDbValuesAll() : getDbValues(),
                      ),
                    ),
                    spm.isEmpty
                        ? Column(
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
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: spm.length,
                            itemBuilder: (context, index) {
                              var cards = Theme.of(context).cardTheme;

                              return InkWell(
                                onTap: () => showDialog(
                                  context: (context),
                                  builder: (context) => showEditDialog(
                                    spm[index],
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(
                                    setScreenUtill(10.0),
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: setScreenUtill(10.0),
                                  ),
                                  child: Card(
                                    borderOnForeground: true,
                                    shape: cards.shape,
                                    elevation: cards.elevation,
                                    color: cards.color,
                                    shadowColor: cards.shadowColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        setScreenUtill(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                spm[index].amount.toString(),
                                                style: textTheme.headline4,
                                              ),
                                              Text(
                                                spm[index].datetime,
                                                style: textTheme.bodyText1
                                                    .copyWith(
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: setScreenUtill(10.0),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  spm[index].description,
                                                  style: textTheme.caption,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                width: setScreenUtill(75.0),
                                                height: setScreenUtill(75.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                child: SvgPicture.asset(
                                                    "assets/images/${spm[index].type.toLowerCase()}.svg"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
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

  void changeTabCallback(bool val) {
    setState(() {
      isAnalysis = val;
    });
  }

  void getDbValuesAll() async {
    spm.clear();
    var data = await _dbHelper.queryAll();
    if (data.isNotEmpty)
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    if (data != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void getDbValues() async {
    spm.clear();
    var data = await _dbHelper.querySelected(
      DateTime.now().month.toString(),
    );
    if (data.isNotEmpty)
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    if (data != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget showEditDialog(SpendingModel spm) {
    var dialog = Theme.of(context).dialogTheme;
    var texts = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: dialog.backgroundColor,
      elevation: dialog.elevation,
      shape: dialog.shape,
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    spm.amount.toString(),
                    style: texts.headline4,
                  ),
                  Text(
                    spm.datetime,
                    style: texts.bodyText1.copyWith(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: setScreenUtill(10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      spm.description,
                      style: texts.caption,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: setScreenUtill(75.0),
                        height: setScreenUtill(75.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: SvgPicture.asset(
                            "assets/images/${spm.type.toLowerCase()}.svg"),
                      ),
                      SizedBox(
                        height: setScreenUtill(10.0),
                      ),
                      Text(
                        "Expense Type:",
                        style: texts.caption,
                      ),
                      Text(
                        spm.type,
                        style: texts.caption.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: setScreenUtill(20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemPage(
                          spendingModel: spm,
                          isUpdating: true,
                          onSaveCallback: getDbValues,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () async {
                      _dbHelper.delete(spm.id);
                      getDbValues();
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
        padding: EdgeInsets.all(
          setScreenUtill(20.0),
        ),
      ),
    );
  }
}
