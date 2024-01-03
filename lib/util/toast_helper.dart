import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class AppToast {
  static void showSnackBar({required message, required BuildContext context}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      messageText: Text(
        message,
        style: CustomTextStyle.textStyle(fontSize: 14.5, color: CustomColor.red),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: CustomColor.background,
    ).show(context);
  }

  static void toastMessage({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        textColor: CustomColor.red,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: CustomColor.background,
        fontSize: 14.5.sp);
  }
}
