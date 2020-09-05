import 'package:flutter_screenutil/screenutil.dart';

num setFontSize(size) {
  return ScreenUtil().setSp(size, allowFontScalingSelf: true);
}

num setSize(size) {
  return ScreenUtil().setSp(size);
}

num setWidth(size) {
  return ScreenUtil().setWidth(size);
}

num setHeight(size) {
  return ScreenUtil().setHeight(size);
}
