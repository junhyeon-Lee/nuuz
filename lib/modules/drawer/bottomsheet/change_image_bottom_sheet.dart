import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

changeImageBottomSheet({
  required BuildContext context,
  required VoidCallback onCameraTap,
  required VoidCallback onGalleryTap,
  required VoidCallback onDeleteProfilePicTap,
  required bool deleteShow,
}) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Myin_Edit_0000'.tr(),
                style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 20.sp),
              ),
              hSize(14),
              Text(
                'Myin_Edit_0003'.tr(),
                textAlign: TextAlign.center,
                style:
                    CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w400, fontSize: 14.sp, height: 1.3),
              ),
              hSize(20),
              CustomButton(
                title: 'Care_Resu_0006',
                onTap: onCameraTap,
                isIcon: true,
                iconPath: IconPath.cameraIcon,
                horizontalPadding: 18.w,
                height: 41.h,
              ),
              hSize(22),
              CustomButton(
                title: 'Care_Resu_0007',
                onTap: onGalleryTap,
                isIcon: true,
                iconPath: IconPath.galleryIcon,
                horizontalPadding: 18.w,
                height: 41.h,
              ),
              hSize(22),
              if(deleteShow)
              CustomButton(
                title: 'Myin_Edit_0004',
                onTap: onDeleteProfilePicTap,
                isIcon: true,
                iconPath: IconPath.deleteIcon,
                horizontalPadding: 18.w,
                height: 41.h,
              ),
              hSize(23),
              Container(
                height: 1,
                color: CustomColor.grayLine,
                width: double.infinity,
              ),
              hSize(23),
              CustomButton(
                title: 'Comm_Gene_0006',
                onTap: () {
                  context.pop();
                },
                horizontalPadding: 20.w,
                bgColor: CustomColor.primary,
                borderColor: CustomColor.primary,
                textColor: CustomColor.white,
              ),
            ],
          ),
        );
      });
}
