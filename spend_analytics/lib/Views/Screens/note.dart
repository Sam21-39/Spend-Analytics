import 'package:flutter/material.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/UI/ui_color.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: UiColor.dark,
            size: setSize(35.0),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: UiColor.light,
      body: ListView(
        padding: EdgeInsets.all(
          setSize(20.0),
        ),
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Amount',
                  style: UiText.headerText,
                ),
              ),
              SizedBox(
                height: setHeight(20.0),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: UiColor.primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: setHeight(30.0),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select One',
                  style: UiText.headerText.copyWith(
                    fontSize: setFontSize(26.0),
                  ),
                ),
              ),
              SizedBox(
                height: setHeight(20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionChip(
                    backgroundColor: UiColor.light,
                    elevation: 12,
                    shadowColor: UiColor.dark.withOpacity(0.45),
                    label: Text(
                      'Income',
                      style: UiText.normalText,
                    ),
                    onPressed: () {},
                  ),
                  ActionChip(
                    backgroundColor: UiColor.light,
                    elevation: 12,
                    shadowColor: UiColor.dark.withOpacity(0.45),
                    label: Text(
                      'Expense',
                      style: UiText.normalText,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
