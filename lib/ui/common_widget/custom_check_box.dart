import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class CustomCheckbox extends StatelessWidget {
  final bool? isSelect;
  final double? width;
  final VoidCallback? onTap;

  const CustomCheckbox({super.key, this.isSelect, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        (isSelect ?? false) ? IconPath.checkBoxSelect : IconPath.checkBoxUnselect,
        width: width ?? 20.w,
        height: width ?? 20.w,
      ),
    );
  }
}
