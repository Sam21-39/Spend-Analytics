import 'package:flutter/material.dart';
import 'package:spend_analytics/Model/item_model.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/Screens/note.dart';
import 'package:spend_analytics/Views/UI/ui_color.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';

List<Items> spendingItems = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: UiColor.light,
      body: ListView(
        children: [
          spendingItems.isEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: setSize(50.0),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(
                          setSize(30.0),
                        ),
                        child: Text(
                          'Nothing is here. To add some data press the "+" button',
                          style: UiText.normalText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  padding: EdgeInsets.all(
                    setSize(20.0),
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: spendingItems.length,
                  itemBuilder: (context, items) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(spendingItems[items].amount.toString()),
                        Text(spendingItems[items].type),
                        Text(spendingItems[items].category),
                        Text(spendingItems[items].date.toString()),
                        Divider(),
                        SizedBox(
                          height: setHeight(20.0),
                        ),
                      ],
                    );
                  }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Note(),
          ),
        ),
        child: Icon(
          Icons.add,
          color: UiColor.dark,
          size: setSize(35.0),
        ),
      ),
    );
  }
}
