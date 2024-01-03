import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/main.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/nuuz_talk/user_profile/user_profile_screen.dart';
import 'package:nuuz/modules/sign/terms_conditions/terms_conditions_screen.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/app_setting_controller.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'my_drawer_controller.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(myDrawerProvider.notifier).getUserData();
      final userData = ref.watch(myDrawerProvider);
      safePrint(userData?.profile_image);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ref.invalidate(myDrawerProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final userData = ref.watch(myDrawerProvider);
      //  final appVersion = ref.watch(deviceInfoProvider);
        return SizedBox(
          width: 338.w,
          child: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    hSize(50),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            CustomContainer(
                              width: 298.w,
                              height: 210.h,
                              containerColor: CustomColor.lightWhite,
                              borderColor: CustomColor.gray,
                              radius: 12,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 25.h),
                                    child: Row(
                                      children: [
                                        userData?.profile_image == null || userData == null || (userData.profile_image ?? '').isEmpty
                                            ? Image.asset(
                                                IconPath.noProfile,
                                                height: 48.w,
                                                width: 48.w,
                                              )
                                            : Container(
                                                width: 48.w,
                                                height: 48.w,
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  image: DecorationImage(image: AssetImage(IconPath.noProfile)),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(100.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: userData?.profile_image ?? '',
                                                    imageBuilder: (context, imageProvider) => Container(
                                                        padding: EdgeInsets.all(50.h),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover))),
                                                    placeholder: (context, url) => Center(
                                                        child: CircularProgressIndicator(
                                                      color: CustomColor.primary,
                                                    )),
                                                    errorWidget: (context, url, error) => Center(
                                                      child: Image.asset(
                                                        IconPath.noProfile,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        wSize(15),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 1.w),
                                              child: Text(
                                                userData?.nick_name ?? '',
                                                style: CustomTextStyle.headerS,
                                              ),
                                            ),
                                            hSize(2),
                                            Row(
                                              children: [
                                                CustomContainer(
                                                  width: 24.w,
                                                  height: 24.h,
                                                  radius: 100,
                                                  containerColor: const Color(0xffd9d9d9),
                                                  child: Center(child: SvgPicture.asset(IconPath.mail)),
                                                ),
                                                wSize(8),
                                                SizedBox(width: 150.w,
                                                  child: Text(
                                                    userData?.email ?? '',
                                                    style: CustomTextStyle.descriptionM,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            final url = Uri.parse(
                                              'https://nuuz.cafe24.com/',
                                            );
                                            if (await canLaunchUrl(url)) {
                                              launchUrl(url, mode: LaunchMode.externalApplication);
                                            } else {
                                              // ignore: avoid_print
                                            }
                                          },
                                          child: profileItem(IconPath.mall)),
                                      InkWell(
                                          onTap: () {
                                            context.goNamed('/FavoriteProgramScreenHome');
                                          },
                                          child: profileItem(IconPath.favorites)),
                                      GestureDetector(
                                          onTap: () {
                                            context.goNamed('/DeviceScreenHome');
                                          },
                                          child: profileItem(IconPath.device)),
                                      GestureDetector(
                                          onTap: () {
                                            // context.goNamed('/profile');
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => UserProfileScreen(
                                                  userId: userData?.user_id ?? '',
                                                  //isCurrentUser: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: profileItem(IconPath.myPage)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            hSize(22),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                            context.goNamed('/edit-profile');
                          },
                          child: CustomContainer(
                            width: 250.w,
                            height: 44.h,
                            containerColor: CustomColor.primary,
                            radius: 13,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  IconPath.post,
                                  color: Colors.white,
                                ),
                                wSize(8),
                                Text(
                                  'Talk_Prof_0010'.tr(),
                                  style: CustomTextStyle.headerS.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    hSize(14),
                    GestureDetector(
                        onTap: () {
                          context.goNamed('/my-info');
                        },
                        child: settingItem(IconPath.myinfo)),
                    GestureDetector(
                        onTap: () {
                          context.goNamed('/coupon');
                        },
                        child: settingItem(IconPath.coupon)),
                    GestureDetector(
                        onTap: () {
                          context.goNamed('/app-setting');
                        },
                        child: Container(child: settingItem(IconPath.setting))),
                    GestureDetector(
                        onTap: () {
                          context.goNamed('/event');
                        },
                        child: settingItem(IconPath.event)),
                    GestureDetector(
                        onTap: () {
                          context.goNamed('/notice');
                        },
                        child: settingItem(IconPath.notice)),
                    GestureDetector(
                        onTap: () {
                          context.goNamed('/customer');
                        },
                        child: settingItem(IconPath.customer)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 40.w, 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsConditionsDrawerScreen(),
                              ));
                        },
                        child: Text(
                          '${'Side_Main_0006'.tr()} | ${'Side_Main_0007'.tr()}',
                          style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.dark),
                        ),
                      ),
                      Text(
                        'v.$appVersion',
                        style: CustomTextStyle.headerXS,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget profileItem(String icon) {
  String menu = '';
  switch (icon) {
    case IconPath.mall:
      menu = 'Sign_Inup_0035'.tr();
      break;
    case IconPath.favorites:
      menu = 'Side_Main_0000'.tr();
      break;
    case IconPath.device:
      menu = 'Side_Main_0001'.tr();
      break;
    case IconPath.myPage:
      menu = 'Side_Main_0002'.tr();
      break;
  }

  return SizedBox(
    width: 70.w,
    height: 70.h,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        CustomContainer(
          width: 48.w,
          height: 48.h,
          radius: 12,
          child: Center(child: SvgPicture.asset(icon)),
        ),
        Positioned(
            bottom: 0,
            child: Text(
              menu,
              style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
            ))
      ],
    ),
  );
}

Widget settingItem(String icon) {
  String menu = '';
  switch (icon) {
    case IconPath.myinfo:
      menu = 'Side_Main_0003';
      break;
    case IconPath.coupon:
      menu = 'Side_Main_0008';
      break;
    case IconPath.setting:
      menu = 'Side_Main_0004';
      break;
    case IconPath.event:
      menu = 'Side_Even_0000';
      break;
    case IconPath.notice:
      menu = 'Comm_Gene_0052';
      break;
    case IconPath.customer:
      menu = 'Side_Main_0005';
      break;
  }
  return Padding(
    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
    child: CustomContainer(
      height: 48.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomContainer(
                width: 48.w,
                height: 48.h,
                containerColor: CustomColor.cultured,
                child: Center(child: SvgPicture.asset(icon)),
              ),
              wSize(12),
              Text(
                menu.tr(),
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
  );
}
