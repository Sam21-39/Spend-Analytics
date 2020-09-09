import 'package:flutter/material.dart';
import 'package:spend_analytics/Model/item_model.dart';
import 'package:spend_analytics/Utils/common.dart';
import 'package:spend_analytics/Views/Screens/home.dart';
import 'package:spend_analytics/Views/UI/ui_text.dart';
import 'package:spend_analytics/Views/Widgets/custom_button.dart';

class ItemContainer extends StatefulWidget {
  final callback;

  const ItemContainer({Key key, this.callback}) : super(key: key);
  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  String typeValue = "--Type--", categoryValue = "--Category--";
  String amount = '', category = '';
  bool isNotValid = false;
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
          onChanged: (val) {
            setState(() {
              amount = val;
            });
          },
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
                  category = val;
                });
              },
            ),
          ),
        SizedBox(
          height: setHeight(20.0),
        ),
        isNotValid
            ? Column(
                children: [
                  Text(
                    'All fields must be filled',
                    style: UiText.normalText.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    height: setHeight(20.0),
                  ),
                ],
              )
            : Container(),
        CustomButton(
          text: "Add",
          onPressed: () {
            isFormValid();
            if (!isNotValid) {
              spendingItems.add(
                Items(
                  amount: int.parse(amount),
                  category: categoryValue,
                  type: typeValue,
                  date: DateTime.now(),
                ),
              );
              widget.callback();
              Navigator.pop(context);
            }
          },
        ),
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

  void isFormValid() {
    setState(() {
      if (amount.isEmpty || typeValue == '--Type--' || category.isEmpty)
        isNotValid = true;
      else
        isNotValid = false;
    });
  }
}
