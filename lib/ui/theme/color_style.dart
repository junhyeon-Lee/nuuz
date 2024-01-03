import 'package:flutter/material.dart';

class CustomColor {
  static Color dark = const Color(0xff2d2a26);
  static Color lightDark = const Color(0xff2d2a26).withOpacity(0.7);
  static Color lightWhite = const Color(0xfff7f7f7);
  static Color white = const Color(0xffffffff);
  static Color black = const Color(0xff000000);
  static Color primary = const Color(0xffC68590);
  static Color gray = const Color(0xffD6D1CA);
  static Color blue = const Color(0xff26C1C2);
  static Color red = const Color(0xffEF3453);
  static Color green = const Color(0xff28BF0A);

  static Color yellow = const Color(0xffFF9900);
  static Color red_50 = const Color(0xffff4e4e).withOpacity(0.5);
  static Color yellow_50 = const Color(0xffffbe18).withOpacity(0.5);
  static Color purple_50 = const Color(0xffa965ff).withOpacity(0.5);
  static Color purple = const Color(0xffa965ff);
  static Color blue_50 = const Color(0xff40baff).withOpacity(0.5);

  ///not yet
  static Color background = const Color(0xfff5f5f5);
  static Color lightGray = const Color(0xfff9f9f9);
  static Color darkGray = const Color(0xfff4f4f4);
  static Color cultured = const Color(0xfff8f8f8);
  static Color darkRed = const Color(0xffff4949);
  static Color lightPink = const Color(0xfffff9f9);
  static Color darkRed_10 = const Color(0xffff4949).withOpacity(0.1);
  static Color grayLine = const Color(0xffebeae9);
  static Color darkWhite = const Color(0xfffafafa);
  static Color whiteVariant1 = const Color(0xfffdfdfd);
  static Color greenVariant1 = const Color(0xff2ea23e).withOpacity(0.1);
  static Color greenVariant2 = const Color(0xff2ea33e);
  static Color greyContainer = const Color(0xfff3f3f3);
  static Color naverColor = const Color(0xff03c75a);
  static Color grayVariant1 = const Color(0xffdfdfdf);
  static Color guideWhite = const Color(0xffECECEC);


  static const MaterialColor progress = MaterialColor(
    0xff2d2a26,
    <int, Color>{
      50: Color(0xff2d2a26),
      100: Color(0xff2d2a26),
      200: Color(0xff2d2a26),
      300: Color(0xff2d2a26),
      400: Color(0xff2d2a26),
      500: Color(0xff2d2a26),
      600: Color(0xff2d2a26),
      700: Color(0xff2d2a26),
      800: Color(0xff2d2a26),
      900: Color(0xff2d2a26),
    },
  );
}
