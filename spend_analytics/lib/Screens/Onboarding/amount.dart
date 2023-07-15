import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/Screens/MainDashboard/main_dashboard.dart';
import 'package:spend_analytics/Utils/display_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Utils/sp_constants.dart';
import 'package:spend_analytics/Widgets/button.dart';

class Amount extends StatefulWidget {
  final isChanging;

  const Amount({
    Key? key,
    this.isChanging = false,
  }) : super(key: key);

  @override
  _AmountState createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  var amountController = TextEditingController();
  var _amountKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      amountController.text =
          sp.getDouble(AMOUNT) == null ? "" : sp.getDouble(AMOUNT).toString();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          shadowColor: null,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
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
                    'Your Monthly Budget (Only Amount)',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: setScreenUtill(36.0),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  TextFormField(
                    controller: amountController,
                    cursorRadius: Radius.circular(20.0),
                    cursorWidth: 5.w,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                      hintText: 'Amount (Max. 8 Character)',
                      hintStyle:
                          Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: setScreenUtill(18.0),
                              ),
                    ),
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    onEditingComplete: () => TextInputAction.done,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    validator: (String? val) => val!.isEmpty
                        ? "Required"
                        : double.tryParse(val) == null
                            ? "Invalid Charecters"
                            : double.parse(val) < 1000
                                ? "Amount should be alteast 1000"
                                : null,
                  ),
                ],
              ),
              SizedBox(
                height: width * 0.8,
              ),
              widget.isChanging
                  ? Button(
                      onPressed: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        if (_amountKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MainDashboard(),
                            ),
                            (route) => false,
                          );
                          sp.setDouble(
                            AMOUNT,
                            double.parse(
                              amountController.text.trim(),
                            ),
                          );
                        }
                      },
                      text: "Save",
                    )
                  : Container(),
            ],
          ),
        ),
        floatingActionButton: widget.isChanging
            ? null
            : FloatingActionButton(
                onPressed: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  if (_amountKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MainDashboard(),
                      ),
                      (_) => false,
                    );
                    sp.setDouble(
                      AMOUNT,
                      double.parse(
                        amountController.text.trim(),
                      ),
                    );
                  }
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).iconTheme.color,
                  size: setScreenUtill(30.0),
                ),
              ),
      ),
    );
  }
}
