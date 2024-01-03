import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      this.iconPath,
      required this.title,
      this.onTap,
      this.rightIconOnTap,
      this.rightIconPath,
      this.fontSize,
      this.horizontalPadding,
      this.isWithdrawUser})
      : super(key: key);

  final String? iconPath;
  final String? rightIconPath;
  final String title;
  final double? fontSize;
  final double? horizontalPadding;
  final VoidCallback? onTap;
  final VoidCallback? rightIconOnTap;
  final bool? isWithdrawUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 20.w, vertical: 15.h),
      child: Row(
        children: [
          InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 25.w,
              child: iconPath == null ? const SizedBox() : Image.asset(iconPath ?? ''),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(title.tr(), maxLines: 3, overflow: TextOverflow.ellipsis, style: CustomTextStyle.headerL),
            ),
          ),
          SizedBox(
            width: 25.w,
            child: rightIconPath == null
                ? const SizedBox()
                : InkWell(
                    onTap: rightIconOnTap,
                    child: SvgPicture.asset(
                      rightIconPath ?? '',
                      color: (isWithdrawUser ?? false) ? CustomColor.dark.withOpacity(0.4) : null,
                    )),
          ),
        ],
      ),
    );
  }
}
