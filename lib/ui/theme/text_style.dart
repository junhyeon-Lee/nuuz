import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_style.dart';

class CustomTextStyle {
  static TextStyle headerXL = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 30.sp,
    height: 40 / 30,
    color: CustomColor.dark,
  );
  static TextStyle headerL = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 22.sp,
    height: 1,
    color: CustomColor.dark,
  );
  static TextStyle headerM = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 20.sp,
    letterSpacing: 0.1.w,
    height: 28 / 20.h,
    color: CustomColor.dark,
  );
  static TextStyle headerS = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 18.sp,
    letterSpacing: 0.1,
    height: 22 / 18,
    color: CustomColor.dark,
  );
  static TextStyle headerXS = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 15.sp,
    letterSpacing: 0.3,
    height: 18 / 15,
    color: CustomColor.dark,
  );
  static TextStyle descriptionXL = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 16.sp,
    letterSpacing: 0,
    height: 18 / 16,
    color: CustomColor.lightDark,
  );
  static TextStyle descriptionL = TextStyle(
    fontFamily: "Spoqa-Regular",
    fontSize: 16.sp,
    letterSpacing: 0,
    height: 22 / 16,
    color: CustomColor.lightDark,
  );

  static TextStyle descriptionM = TextStyle(
    fontFamily: "Spoqa-Regular",
    fontSize: 14.sp,
    letterSpacing: 0,
    height: 16 / 12,
    color: CustomColor.lightDark,
  );

  static TextStyle descriptionS = TextStyle(
    fontFamily: "Spoqa-Regular",
    fontSize: 12.sp,
    letterSpacing: 0,
    height: 16 / 12,
    color: CustomColor.lightDark,
  );

  static TextStyle buttonM = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 16.sp,
    height: 16 / 14,
    color: CustomColor.dark,
  );
  static TextStyle iconS = TextStyle(
    fontFamily: "Spoqa-Regular",
    fontSize: 10.sp,
    height: 12 / 10,
    color: CustomColor.dark,
  );
  static TextStyle nicknameM = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 12.sp,
    height: 16 / 12,
    color: CustomColor.dark,
  );
  static TextStyle nicknameS = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 8.sp,
    height: 10 / 8,
    color: CustomColor.dark,
  );
  static TextStyle categoryS = TextStyle(
    fontFamily: "Spoqa-Bold",
    fontSize: 6.sp,
    letterSpacing: 1.2,
    height: 6 / 6,
    color: CustomColor.dark,
  );

  static TextStyle boldTextStyle({double? fontSize, Color? color, double? height}) {
    return TextStyle(
      fontFamily: "Spoqa-Bold",
      fontSize: (fontSize ?? 12).sp,
      letterSpacing: 1.2,
      height: height ?? 0,
      color: color ?? CustomColor.dark,
    );
  }

  static TextStyle regularTextStyle({double? fontSize, Color? color}) {
    return TextStyle(
      fontFamily: "Spoqa-Regular",
      fontSize: (fontSize ?? 12).sp,
      letterSpacing: 1.2,
      color: color ?? CustomColor.dark,
    );
  }

  static TextStyle textStyle({double? fontSize, Color? color, FontWeight? fontWeight, double? height}) {
    return TextStyle(
      fontFamily: "Spoqa",
      fontSize: (fontSize ?? 12).sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color ?? CustomColor.dark,
      height: height ?? 1.6,
    );
  }
}
