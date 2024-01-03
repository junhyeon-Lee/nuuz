import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_check_box.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CustomTileView extends StatefulWidget {
  CustomTileView({Key? key, required this.title, required this.description, required this.context, this.isSelected = false}) : super(key: key);

  final String title;
  bool isSelected;
  final String description;
  final BuildContext context;

  @override
  State<CustomTileView> createState() => _CustomTileViewState();
}

class _CustomTileViewState extends State<CustomTileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: CustomColor.dark,
          title: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomCheckbox(
                      isSelect: widget.isSelected,
                      onTap: () {
                        setState(() {
                          widget.isSelected = !widget.isSelected;
                        });
                      },
                    ),
                    wSize(13),
                    Text(
                      widget.title.tr(),
                      style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: <Widget>[
            ListTile(
              title: Text(
                widget.description.tr(),
                style: CustomTextStyle.textStyle(color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 14.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
