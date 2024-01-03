import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Future<void> withdrawalCompleteBottomSheet({required BuildContext context}) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 56.h,
              child: Stack(
                children: [

                  Positioned(
                      left: 20.w,
                      top: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: (){
                          context.pop();
                        },
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(IconPath.closeIcon,width: 27.w,)),
                      ),),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        'Comm_Gene_0052'.tr(),
                        style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CustomColor.dark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              width: double.infinity,
              height: 1,
              color: const Color(0xffebeae9),
            ),
            hSize(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                'Side_With_0012'.tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.lightDark,height: 1.3),
              ),
            ),
            hSize(30),
            CustomButton(
              horizontalPadding: 40.w,
              title: 'Comm_Gene_0034',
              onTap: () {

                context.pop();
                context.go('/signScreen');
              },
              bgColor: CustomColor.primary,
              borderColor: CustomColor.primary,
              textColor: CustomColor.white,
            ),
            hSize(26)
          ],
        );
      });
}