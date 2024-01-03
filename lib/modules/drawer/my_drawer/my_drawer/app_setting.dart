import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/privacy_notification.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/faq_screen.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:permission_handler/permission_handler.dart';

class AppSetting extends StatelessWidget {
  const AppSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppbar(
        context: context,
        title: 'Side_Main_0004'.tr(),
      ),
      body: Column(
        children: [
          hSize(16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomContainer(
              width: double.infinity,
              height: 80,
              radius: 12,
              child: GestureDetector(
                onTap: () {
                  context.goNamed('/notification');
                },
                child: CustomContainer(
                  height: 80.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          wSize(20),
                          CustomContainer(
                            width: 48.w,
                            height: 48.h,
                            containerColor: CustomColor.cultured,
                            child: const Center(
                              child: Icon(
                                Icons.notifications_outlined,
                              ),
                            ),
                          ),
                          wSize(12),
                          Text(
                            'Comm_Gene_0002'.tr(),
                            style: CustomTextStyle.headerS,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SvgPicture.asset(IconPath.next),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Notification extends ConsumerStatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  ConsumerState<Notification> createState() => _NotificationState();
}

class _NotificationState extends ConsumerState<Notification> {
  bool isEnableEvent = false;
  bool isEnableResNotice = false;
  bool isEnableCheerNotice = false;
  var userData;
  bool isLoading = false;
  bool isSelected1 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
      });
      userData = await ref.watch(userDataProvider.notifier).getUserProfileData();

      setState(() {
        isEnableEvent = userData?.notification_settings?.events == "enabled" ? true : false;
        isEnableResNotice = userData?.notification_settings?.reservationNotice == "enabled" ? true : false;
        isEnableCheerNotice = userData?.notification_settings?.cheeringNotice == "enabled" ? true : false;
        isLoading = false;
        safePrint("PrivacySetting====>$userData");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalDB localDB = LocalDB();
    return Scaffold(
      appBar: SimpleAppbar(
        context: context,
        title: 'Comm_Gene_0002'.tr(),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                child: CustomContainer(
                  width: double.infinity,
                  radius: 12,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 0, 33.w, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Side_Even_0000'.tr(),
                                    style: CustomTextStyle.headerS,
                                  ),
                                  FlutterSwitch(
                                    width: 45.w,
                                    height: 25.w,
                                    toggleSize: 25.w,
                                    value: isEnableEvent,
                                    borderRadius: 30.0,
                                    padding: 2.w,
                                    activeToggleColor: CustomColor.white,
                                    activeColor: CustomColor.primary,
                                    inactiveColor: CustomColor.lightWhite,
                                    toggleColor: CustomColor.dark,
                                    onToggle: (val) async {
                                      setState(() {
                                        isLoading = true;
                                        isEnableEvent = val;
                                      });

                                      var data = {
                                        "name": userData?.name ?? "",
                                        "birthday": userData?.birth_date ?? "",
                                        "gender": userData?.gender ?? "",
                                        "email": userData?.email ?? "",
                                        "profileImage": userData?.profile_image!,
                                        "nickName": userData?.nick_name,
                                        "introduction": userData?.introduction,
                                        "privacy_settings": userData?.privacy_settings==null ? null : userData.privacy_settings.toJson(),
                                        "notification_settings": NotificationSettingsModel(
                                                cheeringNotice: isEnableCheerNotice ? "enabled" : "disable",
                                                events: isEnableEvent ? "enabled" : "disable",
                                                reservationNotice: isEnableResNotice ? "enabled" : "disable")
                                            .toJson()
                                      };
                                      await callNotificationSetting(data);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 252.w,
                                height: 32.h,
                                child: RichText(
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: 'Side_Apps_0000'.tr(),
                                      style: CustomTextStyle.descriptionS,
                                    ),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 33.w, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Side_Apps_0001'.tr(),
                                    style: CustomTextStyle.headerS,
                                  ),
                                  FlutterSwitch(
                                    width: 45.w,
                                    height: 25.w,
                                    toggleSize: 25.w,
                                    value: isEnableResNotice,
                                    borderRadius: 30.0,
                                    padding: 2.w,
                                    activeToggleColor: CustomColor.white,
                                    activeColor: CustomColor.primary,
                                    inactiveColor: CustomColor.lightWhite,
                                    toggleColor: CustomColor.dark,
                                    onToggle: (val) async {
                                      setState(() {
                                        isLoading = true;
                                        isEnableResNotice = val;
                                      });
                                      var data = {
                                        "name": userData?.name ?? "",
                                        "birthday": userData?.birth_date ?? "",
                                        "gender": userData?.gender ?? "",
                                        "email": userData?.email ?? "",
                                        "profileImage": userData?.profile_image!,
                                        "nickName": userData?.nick_name,
                                        "introduction": userData?.introduction,
                                        "privacy_settings": userData?.privacy_settings==null ? null : userData?.privacy_settings.toJson(),
                                        "notification_settings": NotificationSettingsModel(
                                                cheeringNotice: isEnableCheerNotice ? "enabled" : "disable",
                                                events: isEnableEvent ? "enabled" : "disable",
                                                reservationNotice: isEnableResNotice ? "enabled" : "disable")
                                            .toJson()
                                      };
                                      await callNotificationSetting(data);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 260.w,
                                height: 32.h,
                                child: RichText(
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: 'Devi_Mana_0004'.tr(),
                                      style: CustomTextStyle.descriptionS,
                                    ),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 20.h, 33.w, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Side_Apps_0002'.tr(),
                                    style: CustomTextStyle.headerS,
                                  ),
                                  FlutterSwitch(
                                    width: 45.w,
                                    height: 25.w,
                                    toggleSize: 25.w,
                                    value: isEnableCheerNotice,
                                    borderRadius: 30.0,
                                    padding: 2.w,
                                    activeToggleColor: CustomColor.white,
                                    activeColor: CustomColor.primary,
                                    inactiveColor: CustomColor.lightWhite,
                                    toggleColor: CustomColor.dark,
                                    onToggle: (val) async {
                                      setState(() {
                                        isLoading = true;
                                        isEnableCheerNotice = val;
                                      });
                                      var data = {
                                        "name": userData?.name ?? "",
                                        "birthday": userData?.birth_date ?? "",
                                        "gender": userData?.gender ?? "",
                                        "email": userData?.email ?? "",
                                        "profileImage": userData?.profile_image!,
                                        "nickName": userData?.nick_name,
                                        "introduction": userData?.introduction,
                                        "privacy_settings": userData?.privacy_settings==null ? null : userData?.privacy_settings.toJson(),
                                        "notification_settings": NotificationSettingsModel(
                                                cheeringNotice: isEnableCheerNotice ? "enabled" : "disable",
                                                events: isEnableEvent ? "enabled" : "disable",
                                                reservationNotice: isEnableResNotice ? "enabled" : "disable")
                                            .toJson()
                                      };
                                      await callNotificationSetting(data);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 260.w,
                                child: RichText(
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: 'Prog_Rese_0025'.tr(),
                                      style: CustomTextStyle.descriptionS,
                                    ),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(14)), color: Colors.white),
                child: Column(
                  children: [
                    hSize(24),
                    RichText(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Side_Apps_0004".tr(),
                          style: CustomTextStyle.textStyle(fontSize: 20, fontWeight: FontWeight.w700, color: CustomColor.dark, height: 1.4),
                        ),
                        overflow: TextOverflow.ellipsis),
                    hSize(16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Container(
                        width: double.infinity,
                        height: 1.h,
                        color: CustomColor.grayLine,
                      ),
                    ),
                    hSize(12),
                    SizedBox(
                      width: 300.w,
                      child: RichText(
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Side_Apps_0005".tr(),
                            style: CustomTextStyle.textStyle(fontSize: 14, fontWeight: FontWeight.w400, color: CustomColor.lightDark, height: 1.3),
                          ),
                          overflow: TextOverflow.ellipsis),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FaqScreen(),
                                ),
                              );
                            },
                            child: CustomContainer(
                              width: 120.w,
                              height: 46.h,
                              containerColor: Colors.transparent,
                              radius: 13,
                              child: Center(
                                  child: Text(
                                'Side_Cust_0000'.tr(),
                                style: CustomTextStyle.textStyle(fontSize: 16, fontWeight: FontWeight.w700, color: CustomColor.dark, height: 1.3),
                              )),
                            ),
                          ),
                          wSize(12),
                          GestureDetector(
                            onTap: () async {
                              await openAppSettings();
                            },
                            child: CustomContainer(
                              width: 120.w,
                              height: 44.h,
                              containerColor: CustomColor.primary,
                              radius: 12,
                              child: Center(
                                child: Text(
                                  'Blue_Tooth_0013'.tr(),
                                  style: CustomTextStyle.textStyle(fontSize: 16, fontWeight: FontWeight.w700, color: CustomColor.white, height: 1.3),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          isLoading
              ? Container(color: CustomColor.gray.withOpacity(0.2), alignment: Alignment.center, child: CustomIndicator('Comm_Gene_0001'.tr()))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  callNotificationSetting(data) async {
    safePrint("privacy setting update===>$data");
    await ref.watch(editProfileNotifier.notifier).getEditProfile(updateProfileData: data);
  }
// Future<void> requestPermission(context)async{
//   const Permission locationPermission=Permission.location;
//   bool locationStatus=false;
//   bool ispermanetelydenied= await locationPermission.;
//   if(ispermanetelydenied) {
//     print("denied");
//     await  openAppSettings();
//   }else{
//     var locationStatu = await locationPermission.request();
//     locationStatus=locationStatu.isGranted;
//     print(locationStatus);
//   }
//
// }
}
