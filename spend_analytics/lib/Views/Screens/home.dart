import 'package:flutter/material.dart';
import 'package:spend_analytics/Model/item_model.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';
import 'package:spend_analytics/Views/Widgets/item_container.dart';

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
                          setSize(20.0),
                        ),
                        child: Text(
                          'Nothing is here. To add some data press the "+" button',
                          style: UiText.normalText,
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
        onPressed: () => showDialog(
          context: context,
          builder: (context) => Dialog(
            child: ListView(
              padding: EdgeInsets.all(
                setSize(15.0),
              ),
              shrinkWrap: true,
              children: [
                ItemContainer(
                  callback: setStateCallback,
                ),
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

  void setStateCallback() {
    setState(() {});
  }
}
