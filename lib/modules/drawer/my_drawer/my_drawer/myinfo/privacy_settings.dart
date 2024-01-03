import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/privacy_notification.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class PrivacySetting extends ConsumerStatefulWidget {
  const PrivacySetting({Key? key}) : super(key: key);

  @override
  ConsumerState<PrivacySetting> createState() => _PrivacySettingState();
}

class _PrivacySettingState extends ConsumerState<PrivacySetting> {
  bool isPrivatePostSelected = false;
  bool isPrivateCommentsSelected = false;
  var userData;
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading=true;
      });
      userData = await ref.watch(userDataProvider.notifier).getUserProfileData();

      setState(() {
        isPrivatePostSelected =userData?.privacy_settings?.posts=="private"?true:false;
        isPrivateCommentsSelected =userData?.privacy_settings?.comments=="private"?true:false;
        isLoading=false;
        safePrint("PrivacySetting====>$userData");
      });
    });
  }
  bool isSelected = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background,
          statusBarColor: CustomColor.background,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                hSize(MediaQuery.of(context).viewPadding.top),
                CustomAppBar(
                  title: 'Myin_Priv_0000',
                  onTap: () {
                    context.pop();
                  },
                  iconPath: IconPath.leftBackIcon,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                  child: CustomContainer(
                    width: double.infinity,
                    radius: 12,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 23.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Myin_Priv_0002'.tr(),
                                      style: CustomTextStyle.headerS,
                                    ),
                                    FlutterSwitch(
                                      width: 45.w,
                                      height: 25.w,
                                      toggleSize: 25.w,
                                      value: isPrivatePostSelected,
                                      borderRadius: 30.0,
                                      padding: 2.w,
                                      activeToggleColor: CustomColor.white,
                                      activeColor: CustomColor.primary,
                                      inactiveColor: CustomColor.lightWhite,
                                      toggleColor: CustomColor.dark,
                                      onToggle: (val) async {
                                        setState(() {
                                          isLoading=true;
                                          isPrivatePostSelected = val;
                                        });
                                        safePrint("onTap ==userData==>${userData?.name}");
                                        var data = {
                                          "name": userData?.name ?? "",
                                          "birthday": userData?.birth_date ?? "",
                                          "gender": userData?.gender ?? "",
                                          "email": userData?.email ?? "",
                                          "profileImage": userData?.profile_image!,
                                          "nickName": userData?.nick_name,
                                          "introduction": userData?.introduction,
                                          "privacy_settings": PrivacySettingsModel(
                                                  posts: isPrivatePostSelected == true ? "private" : "public",
                                                  comments: isPrivateCommentsSelected == true ? "private" : "public")
                                              .toJson(),
                                          "notification_settings": userData?.notification_settings==null ? null : userData?.notification_settings.toJson()
                                        };

                                        safePrint("privacy setting update===>$data");
                                        await ref.watch(editProfileNotifier.notifier).getEditProfile(updateProfileData: data);
                                        setState(() {
                                          isLoading=false;

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
                                        text: 'Myin_Priv_0003'.tr(),
                                        style: CustomTextStyle.descriptionS,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          hSize(18),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Myin_Priv_0004'.tr(),
                                      style: CustomTextStyle.headerS,
                                    ),
                                    FlutterSwitch(
                                      width: 45.w,
                                      height: 25.w,
                                      toggleSize: 25.w,
                                      value: isPrivateCommentsSelected,
                                      borderRadius: 30.0,
                                      padding: 2.w,
                                      activeToggleColor: CustomColor.white,
                                      activeColor: CustomColor.primary,
                                      inactiveColor: CustomColor.lightWhite,
                                      toggleColor: CustomColor.dark,
                                      onToggle: (val) async{
                                        setState(()  {
                                          isLoading=true;
                                          isPrivateCommentsSelected = val;
                                        });
                                          var data = {
                                            "name": userData?.name ?? "",
                                            "birthday": userData?.birth_date ?? "",
                                            "gender": userData?.gender ?? "",
                                            "email": userData?.email ?? "",
                                            "profileImage": userData?.profile_image!,
                                            "nickName": userData?.nick_name,
                                            "introduction": userData?.introduction,
                                            "privacy_settings": PrivacySettingsModel(
                                              comments: isPrivateCommentsSelected == true ? "private" : "public",
                                              posts: isPrivatePostSelected == true ? "private" : "public",
                                            ).toJson(),
                                            "notification_settings": userData?.notification_settings==null ? null : userData?.notification_settings.toJson()
                                          };
                                          safePrint("privacy setting update= comment==>$data");
                                          await ref.watch(editProfileNotifier.notifier).getEditProfile(updateProfileData: data);
                                        setState(() {
                                          isLoading=false;

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
                                        text: 'Myin_Priv_0005'.tr(),
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
                hSize(17),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  child: Text(
                    'Myin_Priv_0006'.tr(),
                    style: CustomTextStyle.descriptionS,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    context.goNamed('/WithdrawalScreen');
                  },
                  child: Text(
                    'Comm_Gene_0047'.tr(),
                    style: CustomTextStyle.descriptionM.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                hSize(10),
              ],
            ),
            isLoading
                ? Container(
                color: CustomColor.gray.withOpacity(0.2),

                alignment: Alignment.center,
                child: CustomIndicator('Comm_Gene_0001'.tr()))
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
