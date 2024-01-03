import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/sign/auth/sign_controller.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class SignScreen extends ConsumerStatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends ConsumerState<SignScreen> {
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(loadingProvider.notifier).isLoadingTrue();
      await ref.watch(signProvider.notifier).initSign();
      ref.watch(loadingProvider.notifier).isLoadingFalse();
    });
    super.initState();
  }

  static const platform = MethodChannel("com.ilooda.nuuz/face");
  LocalDB localDB = LocalDB();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final signController = ref.watch(signProvider.notifier);
        final loginState = ref.listen(signProvider, (previous, next) {
          if (next != null) {
            if (next) {
              context.go('/main');
            } else {
              context.go('/termsConditionsScreen');
            }
          }
        });
        return Stack(
          children: [
            Scaffold(
              body: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 52.h, 16.w, 0),
                child: Column(
                  children: [
                    // ///guest mode button
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     InkWell(
                    //       onTap: ()  async {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(builder: (context) => NativeDemo()),
                    //         );
                    //       },
                    //       child:Container(
                    //
                    //         width: 84.w,
                    //         height: 28.h,
                    //         decoration: BoxDecoration(color: CustomColor.dark, borderRadius: const BorderRadius.all(Radius.circular(18))),
                    //         child: Center(
                    //
                    //           child: Text(
                    //             'Sign_Inup_0012'.tr(),
                    //             style: CustomTextStyle.descriptionS?.copyWith(color: CustomColor.white),
                    //           ),
                    //         ),
                    //       ),
                    //
                    //     )
                    //   ],
                    // ),
                    hSize(120),
                    Container(
                      width: 191.35.w,
                      height: 44.h,
                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(IconPath.logo))),
                    ),
                    hSize(110),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: CustomColor.white, borderRadius: const BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          hSize(28),
                          Text(
                            'Sign_Inup_0013'.tr(),
                            style: CustomTextStyle.headerS,
                            textAlign: TextAlign.center,
                          ),
                          hSize(16),
                          InkWell(
                            onTap: () async {
                              //  context.go('/main');
                              ref.watch(loadingProvider.notifier).isLoadingTrue();
                              await signController.signWithKakao();
                              ref.watch(loadingProvider.notifier).isLoadingFalse();
                            },
                            child: Container(
                              width: 250.w,
                              height: 44.h,
                              decoration: const BoxDecoration(color: Color(0xffffe812), borderRadius: BorderRadius.all(Radius.circular(13))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(IconPath.kakao),
                                    Text(
                                      'Sign_Inup_0014'.tr(),
                                      style: CustomTextStyle.headerXS,
                                    ),
                                    wSize(26),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hSize(16),
                          InkWell(
                            onTap: () async {
                              ref.watch(loadingProvider.notifier).isLoadingTrue();
                              signController.signWithNaver();
                              ref.watch(loadingProvider.notifier).isLoadingFalse();
                            },
                            child: Container(
                              width: 250.w,
                              height: 44.h,
                              decoration: BoxDecoration(color: CustomColor.naverColor, borderRadius: const BorderRadius.all(Radius.circular(13))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(IconPath.naver),
                                    Text(
                                      'Sign_Inup_0015'.tr(),
                                      style: CustomTextStyle.headerXS.copyWith(color: Colors.white),
                                    ),
                                    wSize(26),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hSize(16),

                          ///only ios
                          Visibility(
                            visible: Platform.isIOS,
                            child: InkWell(
                              onTap: () async {
                                ref.watch(loadingProvider.notifier).isLoadingTrue();
                                signController.signWithApple();
                                ref.watch(loadingProvider.notifier).isLoadingFalse();
                              },
                              child: Container(
                                width: 250.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                    color: CustomColor.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                                    border: Border.all(color: CustomColor.dark)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        IconPath.apple,
                                        width: 26.w,
                                      ),
                                      Text(
                                        'Sign_Inup_00142'.tr(),
                                        style: CustomTextStyle.headerXS.copyWith(color: CustomColor.dark),
                                      ),
                                      wSize(26),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(visible: Platform.isIOS, child: hSize(16)),
                          // InkWell(
                          //   onTap: () async {
                          //     ref.watch(loadingProvider.notifier).isLoadingTrue();
                          //     safePrint('구글 로그인');
                          //       signController.signWithGoogle();
                          //     ref.watch(loadingProvider.notifier).isLoadingFalse();
                          //   },
                          //   child: Container(
                          //     width: 250.w,
                          //     height: 44.h,
                          //     decoration: BoxDecoration(color: CustomColor.white,
                          //         borderRadius: const BorderRadius.all(Radius.circular(13)),
                          //         border: Border.all(color: CustomColor.dark)),
                          //     child: Padding(
                          //       padding: EdgeInsets.symmetric(horizontal: 15.w),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Image.asset(IconPath.google,width: 26.w,),
                          //           Text(
                          //             'Sign_Inup_00152'.tr(),
                          //             style: CustomTextStyle.headerXS.copyWith(color: CustomColor.dark),
                          //           ),
                          //           wSize(26),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //
                          // hSize(20),
                          hSize(20),
                          Container(
                            width: double.infinity,
                            height: 1.h,
                            color: CustomColor.grayLine,
                          ),
                          hSize(20),
                          SizedBox(
                            width: 250.w,
                            height: 44.h,
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  final url = Uri.parse(
                                    'http://pf.kakao.com/_xmvePxj',
                                  );
                                  if (await canLaunchUrl(url)) {
                                    launchUrl(url, mode: LaunchMode.externalApplication);
                                  } else {
                                    // ignore: avoid_print
                                    print("Can't launch $url");
                                  }
                                },
                                child: Text(
                                  'Sign_Inup_0017'.tr(),
                                  style: CustomTextStyle.buttonM.copyWith(
                                    fontSize: 14.sp,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hSize(24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            loadingScreen(),
          ],
        );
      },
    );
  }
}
