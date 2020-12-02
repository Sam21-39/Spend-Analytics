import 'package:flutter_screenutil/flutter_screenutil.dart';

num setScreenUtill(num size) {
  return ScreenUtil().setSp(size, allowFontScalingSelf: true);
}

const choiceType = [
  "Entertainment",
  "Food",
  "Rent",
  "Bills",
  "Education",
  "Loan",
  "Gaming",
  "Travel",
  "Others"
];
