import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/modules/home/nuuz_care_screen.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Widget defaultItem(){
  return Column(
    children: [
      Container(
          width: double.infinity,
          // height: 138.h,
          color: Colors.white ,
          child: DottedBorder(
              color: CustomColor.gray,
              radius: const Radius.circular(12),
              strokeWidth: 3.w,
              strokeCap: StrokeCap.round,
              dashPattern: [10.w, 10.w],
              borderType: BorderType.RRect,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconPath.plus),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 270,
                        child: Text(
                          'Mynu_Cale_0000'.tr(),
                          style: CustomTextStyle.descriptionL.copyWith(color: CustomColor.gray),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
      hSize(12),
    ],
  );
}

// Widget reservationItem(BuildContext context){
//   return renderNoCareProgramWidget(context, false);
// }