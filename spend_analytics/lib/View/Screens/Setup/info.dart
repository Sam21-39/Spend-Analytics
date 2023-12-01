import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_analytics/Core/UI/uicolors.dart';
import 'package:spend_analytics/Core/Widget/base_scaffold.dart';
import 'package:spend_analytics/Core/Widget/base_widgets.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  bool isValid(context) {
    if (nameCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Name can not be empty')));
      return false;
    }
    if (amountCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Amount can not be empty')));
      return false;
    }
    if (nameCtrl.text.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Name should atleast contain 3 characters; current:${nameCtrl.text.length}')));
      return false;
    }
    if (nameCtrl.text.length > 12) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Name can only contain 12 characters; current:${nameCtrl.text.length}')));
      return false;
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(nameCtrl.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Name can only contain alphabets and numbers')));
      return false;
    }
    if (amountCtrl.text.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Amount should atleast contain 3 characters; current:${amountCtrl.text.length}')));
      return false;
    }
    if (amountCtrl.text.length > 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Name can only contain 6 characters; current:${amountCtrl.text.length}')));
      return false;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(amountCtrl.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Amounht can only contain numbers')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseScaffold(
      title: 'Information Fill Up',
      appBarColor: theme.colorScheme.background,
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'What should we call you?',
              // textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            BaseWidgets.customTextField(nameCtrl, 'Name'),
            SizedBox(
              height: 36.sp,
            ),
            Text(
              'What is your monthly budget?',
              // textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            BaseWidgets.customTextField(amountCtrl, 'Amount'),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: BaseWidgets.customElevatedButton(
                context: context,
                text: 'Let\s Start',
                // width: MediaQuery.of(context).size.width * 0.8,
                btnColor: UiColors.primary,
                onClick: () {
                  isValid(context);
                },
              ),
            ),
            SizedBox(
              height: 36.sp,
            ),
          ],
        ),
      ),
    );
  }
}
