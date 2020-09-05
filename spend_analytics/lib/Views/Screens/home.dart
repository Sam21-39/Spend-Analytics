import 'package:flutter/material.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';
import 'package:spend_analytics/Views/Widgets/item_container.dart';

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
            height: setSize(50.0),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(
                setSize(20.0),
              ),
              child: Text(
                'Nothing is here. To add some data press the "+" button',
                style: UiText.normalText,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Dialog(
            child: ListView(
              padding: EdgeInsets.all(
                setSize(15.0),
              ),
              shrinkWrap: true,
              children: [
                ItemContainer(),
              ],
            ),
          ),
        ),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
