import 'package:flutter/material.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currency;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: Text(
              'Nothing is here. To add some data press the "+" button',
              style: UiText.normalText,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
