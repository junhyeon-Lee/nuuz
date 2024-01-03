import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Future<void> deleteManagementBottomSheet({required BuildContext context, bool? isDeleteButton, Function(bool data)? isDeleted}) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13.5.h),
              child: Text(
                'Comm_Gene_0002'.tr(),
                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CustomColor.dark),
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
                (isDeleteButton ?? false) ? 'Devi_Mana_0003'.tr() : 'Devi_Mana_0005'.tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.dark,height: 1.4),
              ),
            ),
            hSize(58),
            (isDeleteButton ?? false)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 72.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            horizontalPadding: 0,
                            title: 'Comm_Gene_0006',
                            onTap: () {
                              context.pop();
                            },
                          ),
                        ),
                        wSize(17),
                        Expanded(
                            child: CustomButton(
                          title: 'Comm_Gene_0017',
                          onTap: () {
                            context.pop();

                            isDeleted!(true);
                            deleteManagementBottomSheet(context: context,);

                          },
                              horizontalPadding: 0,
                          bgColor: CustomColor.primary,
                          borderColor: CustomColor.primary,
                          textColor: CustomColor.white,
                        ),),
                      ],
                    ),
                  )
                : CustomButton(
                    horizontalPadding: 44.w,
                    title: 'Comm_Gene_0034',
                    onTap: () {
                      context.pop();
                    },
                    bgColor: CustomColor.primary,
                    borderColor: CustomColor.primary,
                    textColor: CustomColor.white,
                  ),
            hSize(28)
          ],
        );
      });
}
