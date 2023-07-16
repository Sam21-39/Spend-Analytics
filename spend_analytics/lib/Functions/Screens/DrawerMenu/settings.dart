import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:spend_analytics/Core/Model/spending_model.dart';
import 'package:spend_analytics/Functions/Screens/DrawerMenu/about.dart';
import 'package:spend_analytics/Functions/Screens/Onboarding/amount.dart';
import 'package:spend_analytics/Functions/Screens/Onboarding/name.dart';
import 'package:spend_analytics/Core/Services/db_helper.dart';
import 'package:spend_analytics/Core/Utils/display_utils.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String versionInfo = "";
  List<SpendingModel> spm = [], spm1 = [];
  DbHelper _dbHelper = DbHelper.dbInstance;
  void initState() {
    super.initState();
    // SharedPreferences.getInstance().then((sp) {
    //   if (sp.getBool(THEME) != null)
    //     setState(() {
    //       isDarkTheme = sp.getBool(THEME);
    //     });
    // });
    version();
    getDbValuesAll();
    // getDbValuesNow();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: null,
        title: Text(
          "Settings",
          style: textTheme.headlineMedium?.copyWith(
            fontSize: setScreenUtill(24.0),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
          padding: EdgeInsets.all(
            setScreenUtill(20.0),
          ),
          children: [
            ListTile(
              selected: true,
              leading: Icon(Icons.perm_device_info_rounded),
              title: Text("Version: $versionInfo"),
              // trailing: Icon(
              //   Icons.arrow_forward_ios_rounded,
              // ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              ),
              selected: true,
              leading: Icon(Icons.info_outline_rounded),
              title: Text("About App"),
              // trailing: Icon(
              //   Icons.arrow_forward_ios_rounded,
              // ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Name(
                    isChanging: true,
                  ),
                ),
              ),
              selected: true,
              leading: Icon(
                Icons.edit,
              ),
              title: Text(
                "Change Name",
              ),
              // trailing: Icon(
              //   Icons.arrow_forward_ios_rounded,
              // ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Amount(
                    isChanging: true,
                  ),
                ),
              ),
              selected: true,
              leading: Icon(
                Icons.monetization_on_outlined,
              ),
              title: Text(
                "Change Amount",
              ),
              // trailing: Icon(
              //   Icons.arrow_forward_ios_rounded,
              // ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
            ListTile(
              onTap: () async {
                final permission = await Permission.storage.request();
                if (permission.isDenied || permission.isPermanentlyDenied) {
                  openAppSettings();
                } else {
                  List<List<dynamic>> rows = [];

                  List<dynamic> row = [];
                  row.add("Amount");
                  row.add("Type");
                  row.add("Date");
                  row.add("Mode");
                  row.add("Description");
                  rows.add(row);
                  for (int i = 0; i < spm.length; i++) {
                    List<dynamic> row = [];
                    row.add(spm[i].amount);
                    row.add(spm[i].type);
                    row.add(spm[i].datetime);
                    row.add(spm[i].mode);
                    row.add(spm[i].description);
                    rows.add(row);
                  }
                  final String csv = const ListToCsvConverter().convert(rows);
                  final directory =
                      await Directory('Storage/emulated/0/Download');

                  final String dir = directory.path;

                  File f = File(dir + "/Spendings.csv");

                  f.writeAsString(csv).whenComplete(() {
                    Fluttertoast.showToast(
                      msg: "File saved in $dir",
                      toastLength: Toast.LENGTH_LONG,
                    );
                    // print(dir);
                  });
                }
              },
              selected: true,
              leading: Icon(
                Icons.download_rounded,
              ),
              title: Text(
                "Export to CSV File",
              ),
              // trailing: Icon(
              //   Icons.arrow_forward_ios_rounded,
              // ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
          ]),
    );
  }

  void version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionInfo = packageInfo.version;
    setState(() {});
  }

  void getDbValuesAll() async {
    spm.clear();

    var data = await _dbHelper.queryAll();
    if (data != null && data.isNotEmpty) {
      data.forEach(
        (e) => spm.add(
          SpendingModel.fromJson(e),
        ),
      );
    }
    setState(() {});
  }
}
