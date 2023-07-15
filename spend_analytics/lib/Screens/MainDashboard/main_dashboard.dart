import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Model/spending_model.dart';
import 'package:spend_analytics/Screens/Charts/analysis.dart';
import 'package:spend_analytics/Screens/Charts/estimate.dart';
import 'package:spend_analytics/Screens/MainDashboard/itempage.dart';
import 'package:spend_analytics/Services/db_helper.dart';
import 'package:spend_analytics/UI/uicolors.dart';
import 'package:spend_analytics/Utils/common_utils.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:spend_analytics/Widgets/navigation_drawer.dart' as sp;

import '../../Utils/sp_constants.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  String today = DateTime.now().day.toString() +
      "-" +
      monthFormat(DateTime.now().month) +
      "-" +
      DateTime.now().year.toString();

  DbHelper _dbHelper = DbHelper.dbInstance;

  List<SpendingModel> spm = [];

  bool isLoading = false;

  bool isAnalysis = false;

  bool isEstimate = false;
  String selected = "current";
  String name = "";

// BANNER SPECIFICS
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-4026417628443700/1900606500',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      name = value.getString(NAME) ?? "User";
      setState(() {});
    });
    getDbValues();
    myBanner.load();
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
              'Hi $name!',
              style: textTheme.headlineMedium?.copyWith(
                fontSize: setScreenUtill(26.0),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(
                  setScreenUtill(20.0),
                ),
                child: Text(
                  '$today',
                  style: textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          drawer: sp.NavigationDrawer(
            isAnalysis: isAnalysis,
            tabChangeCallback: changeTabCallback,
            isSpendingsAdded: spm.isNotEmpty,
            isEstimate: isEstimate,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: isAnalysis
              ? Analysis()
              : isEstimate
                  ? Estimate()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PopupMenuButton(
                            tooltip: "Date Filter",
                            icon: Icon(
                              Icons.filter_list_rounded,
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: "all",
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('All'),
                                        selected == "all"
                                            ? Icon(
                                                Icons.done,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "previous",
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Previous Month',
                                        ),
                                        selected == "previous"
                                            ? Icon(
                                                Icons.done,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "current",
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Current Month',
                                        ),
                                        selected == "current"
                                            ? Icon(
                                                Icons.done,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                            onSelected: (String? val) {
                              val == "all"
                                  ? getDbValuesAll()
                                  : val == "previous"
                                      ? getDbValuesPrev()
                                      : getDbValues();
                              setState(() {
                                selected = val!;
                              });
                            }),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(
                              setScreenUtill(30.0),
                            ),
                            children: [
                              spm.isEmpty
                                  ? Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                            setScreenUtill(40.0),
                                          ),
                                          child: Text(
                                            'Nothing here yet. Let’s add some Spendings by pressing the “+” button....',
                                            style:
                                                textTheme.titleMedium?.copyWith(
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
                                            builder: (context) =>
                                                showEditDialog(
                                              spm[index],
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
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
                                                  shadowColor:
                                                      cards.shadowColor,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                      setScreenUtill(20.0),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              spm[index]
                                                                  .amount
                                                                  .toString(),
                                                              style: textTheme
                                                                  .headlineMedium
                                                                  ?.copyWith(
                                                                color: UiColors
                                                                    .background,
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  left:
                                                                      setScreenUtill(
                                                                          10)),
                                                              width:
                                                                  setScreenUtill(
                                                                      50.0),
                                                              height:
                                                                  setScreenUtill(
                                                                      50.0),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                setScreenUtill(
                                                                    2.0),
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: UiColors
                                                                    .lightRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0),
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/images/${spm[index].mode?.toLowerCase()}.svg"),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              setScreenUtill(
                                                                  10.0),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                spm[index]
                                                                    .description!,
                                                                style: textTheme
                                                                    .bodySmall
                                                                    ?.copyWith(
                                                                  color: UiColors
                                                                      .background
                                                                      .withOpacity(
                                                                    0.75,
                                                                  ),
                                                                ),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Text(
                                                              spm[index]
                                                                  .datetime!,
                                                              style: textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .focusColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: setScreenUtill(2.0),
                                                child: Container(
                                                  width: setScreenUtill(70.0),
                                                  height: setScreenUtill(70.0),
                                                  padding: EdgeInsets.all(
                                                    setScreenUtill(4.0),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: UiColors.lightRed,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius:
                                                            setScreenUtill(
                                                                20.0),
                                                        color: UiColors.black
                                                            .withOpacity(0.25),
                                                        offset:
                                                            Offset(-10.0, 10.0),
                                                        spreadRadius: 1.0,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22.0),
                                                  ),
                                                  child: SvgPicture.asset(
                                                      "assets/images/${spm[index].type?.toLowerCase()}.svg"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
          bottomNavigationBar: adContainer(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: isAnalysis || isEstimate
              ? null
              : FloatingActionButton(
                  tooltip: "Add Spendings",
                  onPressed: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ItemPage(
                          onSaveCallback: selected == "all"
                              ? getDbValuesAll
                              : selected == "current"
                                  ? getDbValues
                                  : getDbValuesPrev,
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

  void changeTabCallback(bool val, bool val1) {
    setState(() {
      isAnalysis = val;
      isEstimate = val1;
    });
  }

  void getDbValuesAll() async {
    spm.clear();
    var data = await _dbHelper.queryAll();
    if (data != null && data.isNotEmpty)
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    setState(() {
      isLoading = false;
    });
  }

  void getDbValuesPrev() async {
    spm.clear();
    var data = await _dbHelper.querySelected(
      (DateTime.now().month - 1).toString(),
      year: (DateTime.now().month - 1 == 12
              ? DateTime.now().year - 1
              : DateTime.now().year)
          .toString(),
    );
    if (data != null && data.isNotEmpty)
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    setState(() {
      isLoading = false;
    });
  }

  void getDbValues() async {
    spm.clear();
    var data = await _dbHelper.querySelected(
      DateTime.now().month.toString(),
      year: DateTime.now().year.toString(),
    );
    if (data != null && data.isNotEmpty)
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    setState(() {
      isLoading = false;
    });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spm.amount.toString(),
                    style: texts.headlineMedium,
                  ),
                  Column(
                    children: [
                      Container(
                        width: setScreenUtill(45.0),
                        height: setScreenUtill(45.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: SvgPicture.asset(
                            "assets/images/${spm.mode?.toLowerCase()}.svg"),
                      ),
                      SizedBox(
                        height: setScreenUtill(10.0),
                      ),
                      Text(
                        "Payment Type:",
                        style: texts.bodySmall?.copyWith(
                          fontSize: setScreenUtill(14),
                        ),
                      ),
                      Text(
                        spm.mode!,
                        style: texts.bodySmall?.copyWith(
                          fontSize: setScreenUtill(15),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    spm.datetime!,
                    style: texts.bodyLarge?.copyWith(
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
                      spm.description!,
                      style: texts.bodySmall,
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
                            "assets/images/${spm.type?.toLowerCase()}.svg"),
                      ),
                      SizedBox(
                        height: setScreenUtill(10.0),
                      ),
                      Text(
                        "Expense Type:",
                        style: texts.bodySmall,
                      ),
                      Text(
                        spm.type!,
                        style: texts.bodySmall?.copyWith(
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
                      color: Theme.of(context).colorScheme.error,
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

  Widget adContainer() => Container(
        alignment: Alignment.center,
        child: AdWidget(ad: myBanner),
        width: myBanner.size.width.toDouble(),
        height: myBanner.size.height.toDouble(),
      );
}
