import 'package:flutter_screenutil/flutter_screenutil.dart';

num setScreenUtill(num size) {
  return ScreenUtil().setSp(size, allowFontScalingSelf: true);
}

const choiceType = [
  "Entertainment",
  "Food",
  "Rent",
  "Grocery",
  "Medicine",
  "Bills",
  "Education",
  "Loan",
  "Gaming",
  "Travel",
  "Investment",
  "Others"
];

const choiceTypeAvatar = [
  "assets/images/entertainment.svg",
  "assets/images/food.svg",
  "assets/images/rent.svg",
  "assets/images/grocery.svg",
  "assets/images/medicine.svg",
  "assets/images/bills.svg",
  "assets/images/education.svg",
  "assets/images/loan.svg",
  "assets/images/gaming.svg",
  "assets/images/travel.svg",
  "assets/images/investment.svg",
  "assets/images/others.svg",
];

const modeType = [
  "Cash",
  "Card",
  "Online",
  "Others",
];

const modeTypeAvatar = [
  "assets/images/cash.svg",
  "assets/images/card.svg",
  "assets/images/online.svg",
  "assets/images/others.svg",
];
