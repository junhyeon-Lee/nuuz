import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/custom_text_theme.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CustomColor.lightGray,
      scaffoldBackgroundColor: CustomColor.darkGray,
      fontFamily: 'Spoqa',
      textTheme: CustomTextTheme.getTheme(),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: CustomColor.primary,
        unselectedItemColor: CustomColor.gray,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColor.darkGray,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(13))),
        backgroundColor: CustomColor.primary,
        disabledBackgroundColor: CustomColor.primary.withOpacity(0.3),
        disabledForegroundColor: CustomColor.dark,
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(13))),
        foregroundColor: CustomColor.dark,
        side: BorderSide(color: CustomColor.dark),
      )),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primarySwatch: CustomColor.progress,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: CustomColor.dark,
      primarySwatch: CustomColor.progress,
      fontFamily: 'Spoqa',
    );
  }
}
