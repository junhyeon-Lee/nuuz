import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class PriceButton extends StatelessWidget {
  PriceButton({Key? key, this.alignment, this.price, this.bgColor, this.txtColor, this.verticalPadding, this.iconSize}) : super(key: key);

  final Alignment? alignment;
  String? price;
  Color? bgColor;
  Color? txtColor;
  double? verticalPadding;
  double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor ?? CustomColor.purple_50,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: verticalPadding ?? 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              IconPath.mIcon,
              width: iconSize ?? 24.w,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              price ?? '9,999',
              maxLines: 1,
              style: CustomTextStyle.textStyle(color: txtColor ?? CustomColor.white, fontWeight: FontWeight.w400, fontSize: 15.sp),
            ),
            SizedBox(
              width: 8.w,
            ),
          ],
        ),
      ),
    );
  }
}
