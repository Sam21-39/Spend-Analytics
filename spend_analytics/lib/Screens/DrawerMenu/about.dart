import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Utils/display_utils.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: null,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: EdgeInsets.all(
          setScreenUtill(20.0),
        ),
        children: [
          Column(
            children: [
              SvgPicture.asset(
                "assets/images/sp_logo.svg",
                width: setScreenUtill(150.0),
              ),
              SizedBox(
                height: setScreenUtill(20.0),
              ),
              Text(
                "About The App",
                style: textTheme.headline4.copyWith(
                  fontSize: setScreenUtill(30.0),
                ),
              ),
              SizedBox(
                height: setScreenUtill(40.0),
              ),
              Text(
                "\"Spend Analytics\" is an app to help visualize your day-to-day spending.\n\n It keeps track of your overall and monthly expenditure and gives it a chart form to visualize. It neither affiliated with any website nor any organization. \n\nThe app does not require any special permissions to run. The app does not save your data to any server or website. It stores the data in its in-built database. Once, uninstalled the data will be lost. \n\n*(Now the data can be stored in CSV files, But it requires Storage access)",
                style: textTheme.bodyText1.copyWith(
                  fontSize: setScreenUtill(24.0),
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: setScreenUtill(80.0),
              ),
              Text(
                "© Appamania",
                style: textTheme.bodyText1.copyWith(
                  fontSize: setScreenUtill(15.0),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
