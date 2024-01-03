import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      this.height,
      required this.title,
      required this.onTap,
      this.textColor,
      this.bgColor,
      this.borderColor,
      this.horizontalPadding,
      this.isIcon,
      this.textStyle,
      this.iconPath,
      this.borderRadius})
      : super(key: key);
  final double? height;
  final double? horizontalPadding;
  final double? borderRadius;
  final String title;
  final String? iconPath;
  final Color? textColor;
  final Color? borderColor;
  final Color? bgColor;
  final VoidCallback onTap;
  final bool? isIcon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 22.w),
        height: height ?? 46.h,
        decoration: BoxDecoration(
            color: bgColor ?? CustomColor.white,
            border: Border.all(width: 0.8, color: borderColor ?? CustomColor.dark),
            borderRadius: BorderRadius.circular(borderRadius ?? 10.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (isIcon ?? false)
                ? Row(
                    children: [
                      Image.asset(
                        iconPath ?? '',
                        width: 19.w,
                      ),
                      wSize(10),
                    ],
                  )
                : const SizedBox(),
            Text(
              title.tr(),
              style: textStyle ?? CustomTextStyle.textStyle(color: textColor ?? CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
