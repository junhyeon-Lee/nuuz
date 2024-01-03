import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/getuserdata.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/sign/fill_profile/fill_profile_controller.dart';
import 'package:nuuz/modules/sign/sign_service.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class FillProfileScreen extends ConsumerStatefulWidget {
  const FillProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends ConsumerState<FillProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userData = await localDB.findUserInfo();
      safePrint(userData);
      safePrint(userData!.email);
      safePrint(userData!.gender);
      if (userData?.gender != null) {
        if (userData?.gender!.substring(0) == 'M') {
          ref.read(genderProvider.notifier).tapMale();
        } else if (userData?.gender == "Gender.male") {
          ref.read(genderProvider.notifier).tapMale();
        } else if (userData?.gender == "Gender.female") {
          ref.read(genderProvider.notifier).tapFemale();
        } else {
          ref.read(genderProvider.notifier).tapFemale();
        }
      }

      if (userData?.nick_name != null) {
        ref.watch(nickNameProvider.notifier).nicknameSetLength(userData!.nick_name!.length);
        ref.watch(nickNameProvider.notifier).nickNameController.text = userData!.nick_name!;
        if (userData?.nick_name == 'nullnull') {
          ref.watch(nickNameProvider.notifier).nicknameSetLength(0);
          ref.watch(nickNameProvider.notifier).nickNameController.text = '';
        }
      }
      if (userData?.email != null) {
        ref.watch(emailProvider.notifier).emailController.text = userData!.email!;
      }
      if (userData?.birth_date != null) {
        ref.watch(birthDayProvider.notifier).setBirthDay(userData!.birth_date!);
      }
    });
    super.initState();
  }

  LocalDB localDB = LocalDB();
  UserData? userData;
  SignRepository signRepository = SignRepository();

  @override
  Widget build(
    BuildContext context,
  ) {
    final isGender = ref.watch(genderProvider);
    var nicknameLength = ref.watch(nickNameProvider);
    var birthLength = ref.watch(birthDayProvider);
    final emailAvailable = ref.watch(emailProvider);
    final getStarted = ref.listen(getStartProvider, (previous, next) {
      if (next) {
        context.go('/serviceguide');
      }
    });
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                hSize(71),
                Text(
                  'Sign_Inup_0025'.tr(),
                  style: CustomTextStyle.headerL,
                ),
                hSize(34),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: CustomColor.white, borderRadius: const BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      children: [
                        hSize(32.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              Text('Sign_Inup_0026'.tr(), style: CustomTextStyle.headerS),
                            ],
                          ),
                        ),
                        hSize(6.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            height: 48.h,
                            decoration: BoxDecoration(color: CustomColor.darkWhite, borderRadius: const BorderRadius.all(Radius.circular(13))),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              readOnly: true,
                              controller: ref.watch(emailProvider.notifier).emailController,
                              decoration: InputDecoration(
                                hintText: ('Sign_Inup_0027'.tr()),
                                hintStyle: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
                                border: InputBorder.none,
                              ),
                              style: CustomTextStyle.descriptionM,
                            ),
                          ),
                        ),
                        hSize(32.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign_Inup_0028'.tr(), style: CustomTextStyle.headerS),
                              Row(
                                children: [
                                  Text(
                                    '$nicknameLength/12',
                                    style: CustomTextStyle.descriptionS,
                                  ),
                                  wSize(7)
                                ],
                              )
                            ],
                          ),
                        ),
                        hSize(6.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            height: 48.h,
                            decoration: BoxDecoration(color: CustomColor.darkWhite, borderRadius: const BorderRadius.all(Radius.circular(13))),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                ref.watch(nickNameProvider.notifier).nicknameLength();
                              },
                              maxLength: 12,
                              controller: ref.watch(nickNameProvider.notifier).nickNameController,
                              decoration: InputDecoration(
                                hintText: ('Sign_Inup_0029'.tr()),
                                hintStyle: CustomTextStyle.descriptionM,
                                border: InputBorder.none,
                                counterText: "",
                              ),
                              style: CustomTextStyle.descriptionM,
                            ),
                          ),
                        ),
                        hSize(32.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              Text('Sign_Inup_0030'.tr(), style: CustomTextStyle.headerS),
                            ],
                          ),
                        ),
                        hSize(6.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          child: SizedBox(
                            width: double.infinity,
                            height: 48.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                  width: 130.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(color: CustomColor.darkWhite, borderRadius: const BorderRadius.all(Radius.circular(13))),
                                  child: TextField(
                                      onChanged: (text) {
                                        ref.watch(birthDayProvider.notifier).countBirthLength();
                                      },
                                      textInputAction: TextInputAction.next,
                                      controller: ref.watch(birthDayProvider.notifier).yearController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                        hintText: '----',
                                        hintStyle: CustomTextStyle.descriptionM,
                                      ),
                                      style: CustomTextStyle.descriptionM?.copyWith(color: CustomColor.dark),
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      textAlign: TextAlign.center),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                  width: 80.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(color: CustomColor.darkWhite, borderRadius: const BorderRadius.all(Radius.circular(13))),
                                  child: TextField(
                                      onChanged: (text) {
                                        ref.watch(birthDayProvider.notifier).countBirthLength();
                                      },
                                      textInputAction: TextInputAction.next,
                                      controller: ref.watch(birthDayProvider.notifier).monthController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                        hintText: '--',
                                        hintStyle: CustomTextStyle.descriptionM,
                                      ),
                                      style: CustomTextStyle.descriptionM?.copyWith(color: CustomColor.dark),
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      textAlign: TextAlign.center),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                  width: 80.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(color: CustomColor.darkWhite, borderRadius: const BorderRadius.all(Radius.circular(13))),
                                  child: TextField(
                                      onChanged: (text) {
                                        ref.watch(birthDayProvider.notifier).countBirthLength();
                                      },
                                      textInputAction: TextInputAction.next,
                                      controller: ref.watch(birthDayProvider.notifier).dayController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                        hintText: '--',
                                        hintStyle: CustomTextStyle.descriptionM,
                                      ),
                                      style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                          ),
                        ),
                        hSize(32.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            children: [
                              Text('Sign_Inup_0032'.tr(), style: CustomTextStyle.headerS),
                            ],
                          ),
                        ),
                        hSize(6.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        ref.watch(genderProvider.notifier).tapFemale();
                                      },
                                      icon: Container(
                                        width: 24.w,
                                        height: 24.h,
                                        decoration: BoxDecoration(
                                            color: CustomColor.white,
                                            borderRadius: const BorderRadius.all(Radius.circular(24)),
                                            border: Border.all(color: CustomColor.dark, width: 1.w)),
                                        child: Center(
                                          child: isGender == 0
                                              ? Container(
                                                  width: 16.w,
                                                  height: 16.h,
                                                  decoration: BoxDecoration(
                                                      color: CustomColor.primary, borderRadius: const BorderRadius.all(Radius.circular(24))),
                                                )
                                              : Container(),
                                        ),
                                      )),
                                  wSize(4),
                                  Text('Sign_Inup_0033'.tr(),
                                      style: CustomTextStyle.headerS.copyWith(color: isGender == 0 ? CustomColor.primary : CustomColor.lightDark)),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        ref.watch(genderProvider.notifier).tapMale();
                                      },
                                      icon: Container(
                                        width: 24.w,
                                        height: 24.h,
                                        decoration: BoxDecoration(
                                            color: CustomColor.white,
                                            borderRadius: const BorderRadius.all(Radius.circular(24)),
                                            border: Border.all(color: CustomColor.dark, width: 1.w)),
                                        child: Center(
                                          child: isGender != 1
                                              ? Container()
                                              : Container(
                                                  width: 16.w,
                                                  height: 16.h,
                                                  decoration: BoxDecoration(
                                                      color: CustomColor.primary, borderRadius: const BorderRadius.all(Radius.circular(24))),
                                                ),
                                        ),
                                      )),
                                  wSize(4),
                                  Text(
                                    'Sign_Inup_0034'.tr(),
                                    style: CustomTextStyle.headerS.copyWith(color: isGender != 1 ? CustomColor.lightDark : CustomColor.primary),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        ref.watch(genderProvider.notifier).tapNull();
                                      },
                                      icon: Container(
                                        width: 24.w,
                                        height: 24.h,
                                        decoration: BoxDecoration(
                                            color: CustomColor.white,
                                            borderRadius: const BorderRadius.all(Radius.circular(24)),
                                            border: Border.all(color: CustomColor.dark, width: 1.w)),
                                        child: Center(
                                          child: isGender != 2
                                              ? Container()
                                              : Container(
                                                  width: 16.w,
                                                  height: 16.h,
                                                  decoration: BoxDecoration(
                                                      color: CustomColor.primary, borderRadius: const BorderRadius.all(Radius.circular(24))),
                                                ),
                                        ),
                                      )),
                                  wSize(4),
                                  Text(
                                    '비공개'.tr(),
                                    style: CustomTextStyle.headerS.copyWith(color: isGender != 2 ? CustomColor.lightDark : CustomColor.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        hSize(10.h),
                        GestureDetector(
                          onTap: nicknameLength == 0
                              ? null
                              : () async {
                                  try {
                                    String birthDay = '';
                                    if (birthLength != 8) {
                                      birthDay = "0001-01-001";
                                    } else {
                                      birthDay = ref.watch(birthDayProvider.notifier).birthDay();
                                    }

                                    safePrint('정보확인');
                                    ref.watch(loadingProvider.notifier).isLoadingTrue();
                                    await ref.watch(getStartProvider.notifier).getStarted(
                                        ref.watch(emailProvider.notifier).emailController.text,
                                        ref.watch(nickNameProvider.notifier).nickNameController.text,
                                        birthDay,
                                        isGender == 0
                                            ? true
                                            : isGender == 1
                                                ? false
                                                : false,
                                        userData);
                                    ref.watch(loadingProvider.notifier).isLoadingFalse();

                                    GetUserData? userDatas = await signRepository.getUserData();
                                    UserData? updateInfoApple = UserData(
                                      user_id: userDatas?.userData?.user_id,
                                      name: userDatas?.userData?.name,
                                      birth_date: userDatas?.userData?.birth_date,
                                      gender: userDatas?.userData?.gender,
                                      email: userDatas?.userData?.email.toString(),
                                      profile_image: userDatas?.userData?.profile_image,
                                      nick_name: userDatas?.userData?.nick_name.toString(),
                                      social_token: userDatas?.userData?.social_token,
                                      created_at: userDatas?.userData?.created_at,
                                      updated_at: userDatas?.userData?.updated_at,
                                      is_deleted: userDatas?.userData?.is_deleted,
                                      login_type: userDatas?.userData?.login_type,
                                      password: userDatas?.userData?.password,
                                      comment: userDatas?.userData?.comment,
                                      introduction: userDatas?.userData?.introduction ?? "pending",
                                      post: userDatas?.userData?.post,
                                      role: userDatas?.userData?.role,
                                      shipping: userDatas?.userData?.shipping,
                                      privacy_settings: userDatas?.userData?.privacy_settings,
                                      notification_settings: userDatas?.userData?.notification_settings,
                                    );
                                    localDB.updateUserInfo(updateInfoApple);
                                  } catch (e) {
                                    Fluttertoast.showToast(
                                        msg: "회원 정보를 모두 입력해주세요.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35.w),
                            child: commonButton(context, 'Comm_Gene_0008'.tr(), nicknameLength == 0 ? false : true),
                          ),
                        ),
                        hSize(24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        loadingScreen(),
      ],
    );
  }
}
