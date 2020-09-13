import 'package:flutter_screenutil/flutter_screenutil.dart';

num setScreenUtill(num size) {
  return ScreenUtil().setSp(size, allowFontScalingSelf: true);
}
