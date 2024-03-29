import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Future<void> completeBottomSheet({required BuildContext context,required String description,required VoidCallback onTap}) async {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 58.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [

                    Positioned(
                      left: 15.w,
                      top: 0,
                      bottom: 0,
                      child:  GestureDetector(
                          onTap: onTap,
                          child: SvgPicture.asset(IconPath.close)),),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Text(
                          'Comm_Gene_0028'.tr(),
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
              hSize(19),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  description.tr(),
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.dark,height: 1.4),
                ),
              ),
              hSize(30),
              CustomButton(
                horizontalPadding: 44.w,
                title: 'Comm_Gene_0034',
                onTap: onTap,
                bgColor: CustomColor.primary,
                borderColor: CustomColor.primary,
                textColor: CustomColor.white,
              ),
              hSize(28)
            ],
          ),
        );
      });
}