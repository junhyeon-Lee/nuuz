import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_service.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/model/selfdiagnosislist.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/skin_self_diagnosis_screen.dart';
import 'package:nuuz/modules/self_diagnosis/self_diagnosis_home.dart';
import 'package:nuuz/modules/self_diagnosis/self_diagnosis_result.dart';
import 'package:nuuz/modules/sign/auth/sign_screen.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import '../../../../ui/theme/color_style.dart';

class MyInfo extends ConsumerWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background,
          statusBarColor: CustomColor.background,
          statusBarIconBrightness: Brightness.dark),
      child: Stack(
        children: [
          Scaffold(
            body: Column(
              children: [
                hSize(MediaQuery.of(context).viewPadding.top),
                appBar(context),
                hSize(16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomContainer(
                    width: double.infinity,
                    radius: 12,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 48.h,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.goNamed('/info-edit-profile');
                              },
                              child: CustomContainer(
                                height: 88.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          width: 48.w,
                                          height: 48.h,
                                          containerColor: CustomColor.cultured,
                                          child: Center(child: SvgPicture.asset(IconPath.post)),
                                        ),
                                        wSize(12),
                                        Text(
                                          'Talk_Prof_0010'.tr(),
                                          style: CustomTextStyle.headerS,
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(IconPath.next)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hSize(16),
                          SizedBox(
                            height: 48.h,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.goNamed('/privacy-setting');
                              },
                              child: CustomContainer(
                                height: 88.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          width: 48.w,
                                          height: 48.h,
                                          containerColor: CustomColor.cultured,
                                          child: Center(child: SvgPicture.asset(IconPath.myinfoPrivacy)),
                                        ),
                                        wSize(12),
                                        Text(
                                          'Myin_Priv_0000'.tr(),
                                          style: CustomTextStyle.headerS,
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(IconPath.next)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hSize(16),
                          SizedBox(
                            height: 48.h,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.goNamed('/DeviceScreen');
                              },
                              child: CustomContainer(
                                height: 88.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          width: 48.w,
                                          height: 48.h,
                                          containerColor: CustomColor.cultured,
                                          child: Center(child: SvgPicture.asset(IconPath.myinfoDevice)),
                                        ),
                                        wSize(12),
                                        Text(
                                          'Side_Main_0001'.tr(),
                                          style: CustomTextStyle.headerS,
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(IconPath.next)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hSize(16),
                          SizedBox(
                            height: 48.h,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                ref.watch(loadingProvider.notifier).isLoadingTrue();
                                LocalDB localDB = LocalDB();
                                LoginResponse? loginResponse = await localDB.findAuthInfo();
                                MyDrawerRepository repository = MyDrawerRepository();

                                SelfDiagnosisList? selfDiagnosisList =
                                    await repository.getSelfDiagnosis(loginResponse!.accessToken ?? "");
                                if (selfDiagnosisList != null) {
                                  if (selfDiagnosisList.selfDiagnosis.isNotEmpty) {
                                    safePrint("selfDiagnosisList.selfDiagnosis=====>${selfDiagnosisList.selfDiagnosis.first}");
                                    var data = selfDiagnosisList.selfDiagnosis.first;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SkinSelfDiagnosis(response: selfDiagnosisList.selfDiagnosis.first),
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const SelfDiagnosisHome(),
                                      ),
                                    );
                                  }
                                }
                                ref.watch(loadingProvider.notifier).isLoadingFalse();
                              },
                              child: CustomContainer(
                                height: 88.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          width: 48.w,
                                          height: 48.h,
                                          containerColor: CustomColor.cultured,
                                          child: Center(child: SvgPicture.asset(IconPath.myinfoDiagnosis)),
                                        ),
                                        wSize(12),
                                        Text(
                                          'Self_Diag_0000'.tr(),
                                          style: CustomTextStyle.headerS,
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(IconPath.next)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hSize(16),
                          SizedBox(
                            height: 48.h,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.goNamed('/FavoriteProgramScreen');
                              },
                              child: CustomContainer(
                                height: 88.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomContainer(
                                          width: 48.w,
                                          height: 48.h,
                                          containerColor: CustomColor.cultured,
                                          child: Center(child: SvgPicture.asset(IconPath.myinfoFavorite)),
                                        ),
                                        wSize(12),
                                        Text(
                                          'MyIn_Favo_0000'.tr(),
                                          style: CustomTextStyle.headerS,
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(IconPath.next)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          loadingScreen(),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    LocalDB localDB = LocalDB();
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: 20.w,
            top: 0,
            bottom: 0,
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: SizedBox(
                width: 25.w,
                child: Image.asset(IconPath.leftBackIcon),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Center(
              child: Text(
                'Side_Main_0003'.tr(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.textStyle(color: CustomColor.dark, fontSize: 22.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            right: 20.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: InkWell(
                onTap: () async {
               ///여기 로그아웃
                 await localDB.logout();
                   context.go('/signScreen');
                 //SystemNavigator.pop();
                },
                child: Container(
                  height: 28.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: CustomColor.dark,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Center(
                    child: Text(
                      'Comm_Gene_0056'.tr(),
                      style: CustomTextStyle.textStyle(color: CustomColor.lightWhite, fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
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
