import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:lottie/lottie.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CustomIndicator extends ConsumerStatefulWidget {
  const CustomIndicator(this.text, {Key? key, this.textStyle}) : super(key: key);
  final String text;
  final TextStyle? textStyle;

  @override
  ConsumerState<CustomIndicator> createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends ConsumerState<CustomIndicator> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return SizedBox(
          height: 84.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 36.w, height: 36.h, child: Lottie.asset(IconPath.indicator)),
              Text(
                widget.text,
                style: widget.textStyle ?? CustomTextStyle.headerS,
              )
            ],
          ),
        );
      },
    );
  }
}
