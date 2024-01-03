import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:permission_handler/permission_handler.dart';

import 'access_controller.dart';

class AccessScreen extends ConsumerWidget {
  const AccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 108.h),
          Container(width: 139.w, height: 32.h, decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(IconPath.logo)))),
          SizedBox(height: 48.h),
          Text('Sign_Inup_0000'.tr(), style: CustomTextStyle.headerM),
          Text('Sign_Inup_00011'.tr(), style: CustomTextStyle.descriptionM),
          const AccessList()
        ],
      ),
    );
  }
}

class AccessList extends ConsumerWidget {
  const AccessList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indicatorController = ref.watch(accessProvider.notifier);
    final iconPath = ref.listen(accessProvider, (previous, next) async {
      if (next == true) {
        context.go('/signScreen');
      } else {
        safePrint('여기가 문제야?');
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => CommonMessageBottomSheet(
            headerText: "Sign_Inup_0010".tr(),
            descriptionText: "Noti_Main_0002".tr(),
            primaryButtonText: "Comm_Gene_0006".tr(),
            secondaryButtonText: "Sign_Inup_0011".tr(),
            onPrimaryButtonPressed: () {
              context.go('/signScreen');
            },
            onSecondaryButtonPressed: () async {
              bool settingsOpened = await openAppSettings();
              if (settingsOpened) {
                BasicMessageChannel<String?> lifecycleChannel = SystemChannels.lifecycle;
                lifecycleChannel.setMessageHandler((String? msg) async {
                  // When the app is resumed, we'll stop listening to lifecycle changes
                  if (msg!.contains("resumed")) {
                    ///? 시스템 알림설정 종료했을때(< 뒤로가기 시)
                    PermissionStatus changedStatus = await Permission.notification.status;
                    print('changedStatus:$changedStatus');
                    if (changedStatus == PermissionStatus.granted) {
                      ///!notification on - 알림설정함
                    } else {
                      /// notification off -알림설정 안함
                    }
                  }
                  return await '';
                });
                context.go('/signScreen');
              }
            },
          ),
        );
      }
    });
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 22.h),
          child: Column(
            children: [
              accessItem(context, 'Sign_Inup_0002'.tr(), 'Sign_Inup_0003'.tr(), IconPath.mobile),
              accessItem(context, 'Blue_Tooth_0000'.tr(), 'Sign_Inup_0004'.tr(), IconPath.bluetooth),
              accessItem(context, 'Sign_Inup_0005'.tr(), 'Sign_Inup_0006'.tr(), IconPath.folder),
              accessItem(context, 'Sign_Inup_0007'.tr(), 'Sign_Inup_0008'.tr(), IconPath.camera),
              accessItem(context, 'Comm_Gene_0002'.tr(), 'Sign_Inup_0010'.tr(), IconPath.notification),
              SizedBox(height: 8.h),
              InkWell(
                  onTap: () async {
                    safePrint('call permission');
                    await indicatorController.permissionHandle();
                  },
                  child: commonButton(context, '계속'.tr(), true)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget accessItem(BuildContext context, String head, String description, String iconPath) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Container(
      decoration: const BoxDecoration(color: Color(0xfff7f7f7), borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 10.h, 13.w, 0),
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(color: CustomColor.white, borderRadius: const BorderRadius.all(Radius.circular(100))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.h),
                child: SvgPicture.asset(iconPath),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h),
              Row(
                children: [
                  Text(
                    head, //style: CustomTextStyle.headerSM
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(width: 5.w),
                  if (head == 'Comm_Gene_0002'.tr())
                    Text(
                      'Sign_Inup_0009'.tr(),
                      //style: CustomTextStyle.descriptionSM.copyWith(color: CustomColor.lightDark)
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColor.lightDark),
                    )
                ],
              ),
              SizedBox(
                width: 230.w,
                child: RichText(
                    maxLines: 2,
                    text: TextSpan(text: description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColor.lightDark))),
              ),
              SizedBox(height: 15.h)
            ],
          )
        ],
      ),
    ),
  );
}
