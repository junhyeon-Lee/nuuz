import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'dart:math' as math;

import 'package:nuuz/util/%20statistics/view_count_controller.dart';

class ExpandText extends StatefulWidget {
  final String text;
  final String noticeId;
  const ExpandText({super.key, required this.text, required this.noticeId});
  @override
  ExpandTextState createState() => ExpandTextState();
}

class ExpandTextState extends State<ExpandText> {
  bool _isExpanded = false;
  ViewCountRepository viewCountRepository = ViewCountRepository();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final TextSpan span = TextSpan(
                  text: widget.text,

                  style: CustomTextStyle.textStyle(fontSize: 12,fontWeight: FontWeight.w400,
                  )
                );
                final TextPainter textPainter = TextPainter(
                  text: span,
                  maxLines: 1,
                  ellipsis: '...',
                  textDirection: TextDirection.ltr,
                );
                textPainter.layout(maxWidth: constraints.maxWidth);

                if (textPainter.didExceedMaxLines) {
                  print("exceed");
                  return Text(
                    widget.text,

                    style: CustomTextStyle.textStyle(fontSize: 12,fontWeight: FontWeight.w400),
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded ? null : TextOverflow.ellipsis,
                  );
                } else {
                  return Text(
                    widget.text,

                      style: CustomTextStyle.textStyle(fontSize: 12,fontWeight: FontWeight.w400)
                  );
                }
              }),
        ),

        hSize(14),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return InkWell(
              onTap: (){
                if(_isExpanded!=true){
                  viewCountRepository.increaseViewCount(null, null, null, widget.noticeId,null);
                }

                setState(() => _isExpanded = !_isExpanded);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _isExpanded?CustomColor.darkWhite:CustomColor.primary,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.5.h),
                width: double.infinity,
                child: /*_isExpanded ? Transform.rotate(
                angle: -math.pi / 1,
                child: Image.asset(
                  IconPath.downArrow,
                  color: CustomColor.white,
                  height: 8.5.h,
                ),
              ) : */AnimatedRotation(
                  turns: _isExpanded?1.0 / 2.0:0,
                  duration: const Duration(milliseconds: 100),
                  child: Image.asset(
                    IconPath.downArrow,
                    color: CustomColor.white,
                    height: 8.5.h,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}