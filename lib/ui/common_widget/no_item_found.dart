import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({Key? key, required this.title, required this.icon, this.iconSize, this.padding}) : super(key: key);
  final String title;
  final String icon;
  final double? iconSize;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 32.h),
          margin: EdgeInsets.symmetric(vertical: 14.h, horizontal: padding ?? 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: iconSize ?? 55.h,
                height: iconSize ?? 55.h,
              ),
              hSize(15),
              Text(
                title.tr(),
                style: CustomTextStyle.textStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CustomColor.lightDark),
              )
            ],
          ),
        ),
      ],
    );
  }
}
