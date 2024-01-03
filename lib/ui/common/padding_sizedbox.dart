import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget wSize(double width) {
  return SizedBox(
    width: width.w,
  );
}

Widget hSize(double height) {
  return SizedBox(
    height: height.h,
  );
}
