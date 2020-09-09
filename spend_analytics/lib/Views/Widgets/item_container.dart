import 'package:flutter/material.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';
import 'package:spend_analytics/Views/Widgets/custom_button.dart';

class ItemContainer extends StatefulWidget {
  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  String typeValue = "--Type--", categoryValue = "--Category--";
  List<String> incomeCategory = [
        "--Category--",
        "Work",
        "Internship",
        "Buiseness",
      ],
      expensesCategory = [
        "--Category--",
        "Entertainment",
        "Food",
        "Medical",
        "Gym",
        "Rent",
        "Travel",
        "Clothing",
        "Bills",
      ];
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: setSize(10.0),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Colors.blue, width: 1.0)),
          child: DropdownButton<String>(
            underline: Container(),
            elevation: 12,
            value: typeValue,
            items:
                <String>["--Type--", "Expense", "Income"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.all(
                    setSize(10.0),
                  ),
                  child: Text(
                    value,
                    style: UiText.normalText,
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                typeValue = val;
              });
            },
          ),
        ),
        SizedBox(
          height: setHeight(20.0),
        ),
        if (typeValue != "--Type--")
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: setSize(10.0),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.blue, width: 1.0)),
            child: DropdownButton<String>(
              underline: Container(),
              elevation: 12,
              value: categoryValue,
              items: setCategoryList(typeValue).map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.all(
                      setSize(10.0),
                    ),
                    child: Text(
                      value,
                      style: UiText.normalText,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  categoryValue = val;
                });
              },
            ),
          ),
        SizedBox(
          height: setHeight(20.0),
        ),
        CustomButton(text: "Add", onPressed: () {}),
        SizedBox(
          height: setHeight(10.0),
        ),
      ],
    );
  }

  List<String> setCategoryList(String type) {
    setState(() {
      categoryValue = "--Category--";
    });
    switch (type) {
      case "Income":
        return incomeCategory;
      case "Expense":
        return expensesCategory;
    }
    return [];
  }
}
