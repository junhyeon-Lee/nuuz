import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CustomRadioButton extends StatelessWidget {
  CustomRadioButton({Key? key, this.buttonWidth, required this.title, this.isSelect, this.textStyle}) : super(key: key);

  final double? buttonWidth;
  final String title;
  final bool? isSelect;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          (isSelect ?? false) ? IconPath.selectRadioButton : IconPath.unSelectRadioButton,
          width: buttonWidth ?? 22.w,
        ),
        wSize(10),
        Text(
          title.tr(),
          style: textStyle ??
              CustomTextStyle.textStyle(
                  color: (isSelect ?? false) ? CustomColor.primary : CustomColor.lightDark, fontWeight: FontWeight.w700, fontSize: 15.sp),
        ),
      ],
    );
  }
}
