import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/theme/color_style.dart';

class CustomTextTheme {
  static TextTheme getTheme() {
    return TextTheme(
      // headline4: const TextStyle(
      //   fontStyle: FontStyle.normal,
      //   fontWeight: FontWeight.w700,
      //   fontSize: 30,
      //   height: 1.33,
      // ),
      /// Header_L
      headlineLarge: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
          height: 1.4,
          // letterSpacing: 0.01,
          color: CustomColor.dark),

      /// Header_Med
      headlineMedium: TextStyle(
          fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 16.sp, height: 1.38, letterSpacing: 0.01, color: CustomColor.dark),

      /// Header_sm
      headlineSmall: TextStyle(
          fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 12.sp, height: 1.33, letterSpacing: 0.03, color: CustomColor.dark),
      titleLarge: TextStyle(
          fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 20.sp, height: 1.4, letterSpacing: 0.01, color: CustomColor.dark),
      titleMedium: TextStyle(
          fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 16.sp, height: 1.38, letterSpacing: 0.01, color: CustomColor.dark),
      titleSmall: TextStyle(
          fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 12.sp, height: 1.33, letterSpacing: 0.03, color: CustomColor.dark),

      /// Description_L
      bodyLarge: TextStyle(
          fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 12.sp, height: 1.67, color: CustomColor.dark.withOpacity(0.7)),

      /// Description_sm
      bodyMedium: TextStyle(
          fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, fontSize: 10.sp, height: 1.60, color: CustomColor.dark.withOpacity(0.7)),

      /// Button_tx
      labelLarge: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 16.sp, height: 1, color: CustomColor.dark),

      ///no name textStyle
      displayMedium: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, fontSize: 14.sp, height: 20 / 14, color: CustomColor.white),
    );
  }
}

// extension TextThemeExtension on TextTheme{

// }
