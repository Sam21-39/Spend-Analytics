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

const choiceTypeAvatar = [
  "assets/images/entertainment.svg",
  "assets/images/food.svg",
  "assets/images/rent.svg",
  "assets/images/bills.svg",
  "assets/images/education.svg",
  "assets/images/loan.svg",
  "assets/images/gaming.svg",
  "assets/images/travel.svg",
  "assets/images/others.svg",
];
