import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spend_analytics/Model/spending_model.dart';
import 'package:spend_analytics/Services/db_helper.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Widgets/button.dart';

class ItemPage extends StatefulWidget {
  final onSaveCallback;

  const ItemPage({
    Key key,
    this.onSaveCallback,
  }) : super(key: key);
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  var amountController = TextEditingController();
  var descriptionController = TextEditingController(text: "");
  int choiceIndex;

  DbHelper _dbHelper = DbHelper.dbInstance;

  GlobalKey<FormState> _amountKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
          body: Form(
            key: _amountKey,
            child: ListView(
              padding: EdgeInsets.all(
                setScreenUtill(30.0),
              ),
              children: [
                Column(
                  children: [
                    Text(
                      "Enter Amount you've spent",
                      style: textTheme.headline4.copyWith(
                        fontSize: setScreenUtill(36.0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      controller: amountController,
                      validator: (val) =>
                          int.tryParse(val) != null ? null : "Incorrect input",
                      cursorRadius: Radius.circular(20.0),
                      cursorWidth: 5.w,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () => TextInputAction.done,
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                      style: textTheme.bodyText1.copyWith(
                        fontSize: setScreenUtill(18.0),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).focusColor,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: setScreenUtill(15.0),
                        ),
                        hintText: 'Amount',
                        hintStyle: textTheme.caption.copyWith(
                          fontSize: setScreenUtill(18.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Choose type of spending",
                      style: textTheme.headline4.copyWith(
                        fontSize: setScreenUtill(36.0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 100.h,
                      child: spendTypeChoice(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Selected: ${choiceIndex != null ? choiceType[choiceIndex] : ''}",
                      style: textTheme.caption.copyWith(
                        fontSize: setScreenUtill(20.0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      cursorRadius: Radius.circular(20.0),
                      cursorWidth: 5.w,
                      keyboardType: TextInputType.text,
                      onEditingComplete: () => TextInputAction.done,
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                      style: textTheme.bodyText1.copyWith(
                        fontSize: setScreenUtill(18.0),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).focusColor,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(
                          left: setScreenUtill(15.0),
                        ),
                        hintText: 'Short Description(Optional)',
                        hintStyle: textTheme.caption.copyWith(
                          fontSize: setScreenUtill(18.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Button(
                      onPressed: choiceIndex != null &&
                              amountController.text.length > 0
                          ? () async {
                              if (_amountKey.currentState.validate()) {
                                SpendingModel spm = SpendingModel(
                                  type: choiceType[choiceIndex],
                                  amount: int.parse(
                                    amountController.text.trim(),
                                  ),
                                  datetime: DateTime.now().day.toString() +
                                      "/" +
                                      DateTime.now().month.toString() +
                                      "/" +
                                      DateTime.now().year.toString(),
                                  description: descriptionController.text,
                                );
                                var dbH = await _dbHelper.insert(spm.toJson());
                                print(dbH);
                                widget.onSaveCallback();
                                Navigator.pop(context, true);
                              }
                            }
                          : null,
                      text: "Save",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget spendTypeChoice() {
    var chipsTheme = Theme.of(context).chipTheme;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: choiceType.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(
              setScreenUtill(6.0),
            ),
            child: ChoiceChip(
              avatar: CircleAvatar(
                backgroundColor: chipsTheme.disabledColor.withOpacity(0.2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: SvgPicture.asset(choiceTypeAvatar[index]),
                ),
                radius: setScreenUtill(40.0),
              ),
              label: Text(
                "${choiceType[index]}",
                style: chipsTheme.labelStyle,
              ),
              selected: choiceIndex == index,
              onSelected: (selected) {
                setState(() {
                  choiceIndex = selected ? index : null;
                });
              },
            ),
          );
        });
  }
}
