import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseWidgets {
  // textFields
  static customTextField(
    TextEditingController controller,
    String hint, {
    Widget? icon,
    Widget? suffixIcon,
    bool? readOnly,
    bool? passWord,
    onTap,
  }) {
    return TextField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      obscureText: passWord ?? false,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
        prefix: SizedBox.square(
          dimension: 24.sp,
          child: icon,
        ),
        suffix: SizedBox.square(
          dimension: 24.sp,
          child: suffixIcon,
        ),
      ),
    );
  }

  // Buttons
  static customElevatedButton({
    required BuildContext context,
    double? width = 150,
    required String text,
    required Color btnColor,
    required Function() onClick,
  }) =>
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(btnColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          minimumSize: MaterialStatePropertyAll(
            Size(width!, 50.h),
          ),
        ),
        onPressed: onClick,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24.sp,
            // color: Colors.white,
          ),
        ),
      );

  // Button with Icons
  static customElevatedIconButton({
    required BuildContext context,
    double? width = 150,
    required Widget icon,
    required String text,
    required Color btnColor,
    required Function() onClick,
  }) =>
      ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(btnColor),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          minimumSize: MaterialStatePropertyAll(
            Size(width!, 50.h),
          ),
        ),
        onPressed: onClick,
        icon: SizedBox.square(
          dimension: 30.sp,
          child: icon,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 24.sp,
            // color: Colors.white,
          ),
        ),
      );
}
