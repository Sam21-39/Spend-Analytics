import 'package:flutter/material.dart';
import 'package:spend_analytics/Utils/common.dart';

class ItemContainer extends StatefulWidget {
  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            alignLabelWithHint: true,
            labelText: "Amount",
            contentPadding: EdgeInsets.only(
              left: setSize(25.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        SizedBox(
          height: setHeight(20.0),
        ),
      ],
    );
  }

  String typeDropDown() {
    String typeValue = "";
    new DropdownButton<String>(
      value: typeValue,
      items: <String>["Income", "Expense"].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          typeValue = val;
        });
      },
    );
    return typeValue;
  }
}
