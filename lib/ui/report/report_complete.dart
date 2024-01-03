import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Future<void> showReportComplete(context) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  hSize(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.pop();
                            context.pop();
                          },
                          child: SvgPicture.asset(IconPath.close)),
                      Text(
                        'Comm_Gene_0041'.tr(),
                        style: CustomTextStyle.headerL,
                      ),
                      wSize(24),
                    ],
                  ),
                  hSize(20),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: const Color(0xffebeae9),
                  ),
                  hSize(12)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Text(
                'Talk_Repo_0014'.tr(),
                style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
                textAlign: TextAlign.center,
              ),
            ),
            hSize(
              30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                    context.pop();
                  },
                  child: CustomContainer(
                    width: 320.w,
                    height: 46.h,
                    radius: 13,
                    containerColor: CustomColor.primary,
                    child: Center(
                      child: Text(
                        'Comm_Gene_0034'.tr(),
                        style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            hSize(
              30,
            ),
          ],
        );
      });
}
