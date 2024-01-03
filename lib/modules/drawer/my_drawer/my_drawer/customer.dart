import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class Customer extends StatelessWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: CustomColor.background,
        statusBarColor: CustomColor.background,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight +10),
          child: CustomAppBar(
            title: 'Side_Main_0005'.tr(),
            onTap: () {
              context.pop();
            },
            iconPath: IconPath.leftBackIcon,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: CustomContainer(
                width: double.infinity,
                radius: 12,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          context.goNamed('/FaqScreen');
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomContainer(
                                  width: 48.w,
                                  height: 48.h,
                                  radius: 12,
                                  containerColor: CustomColor.cultured,
                                  child: Center(
                                    child: SvgPicture.asset(IconPath.faq),
                                  ),
                                ),
                                wSize(12),
                                Text(
                                  'Side_Cust_0000'.tr(),
                                  style: CustomTextStyle.headerS,
                                ),
                              ],
                            ),
                            SvgPicture.asset(IconPath.next),
                          ],
                        ),
                      ),
                      hSize(16),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
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
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomContainer(
                                  width: 48.w,
                                  height: 48.h,
                                  radius: 12,
                                  containerColor: CustomColor.cultured,
                                  child: Center(
                                    child: SvgPicture.asset(IconPath.contact),
                                  ),
                                ),
                                wSize(12),
                                Text(
                                  'Side_Cust_0001'.tr(),
                                  style: CustomTextStyle.headerS,
                                ),
                              ],
                            ),
                            SvgPicture.asset(IconPath.next),
                          ],
                        ),
                      ),
                      // hSize(16),
                      // // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // //   children: [
                      // //     Row(
                      // //       children: [
                      // //         CustomContainer(
                      // //           width: 48.w,
                      // //           height: 48.h,
                      // //           radius: 12,
                      // //           containerColor: CustomColor.cultured,
                      // //           child: Center(
                      // //             child: SvgPicture.asset(IconPath.inquiry),
                      // //           ),
                      // //         ),
                      // //         wSize(12),
                      // //         Text(
                      // //           'Side_Cust_0002'.tr(),
                      // //           style: CustomTextStyle.headerS,
                      // //         ),
                      // //       ],
                      // //     ),
                      // //     SvgPicture.asset(IconPath.next),
                      // //   ],
                      // // ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            Container(
              height: 150.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(IconPath.customerBottomBg),
                      fit: BoxFit.fill,
                    )
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Side_Cust_0003'.tr(),
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400,fontSize: 16,color: CustomColor.lightDark,height: 1.4),
                  ),

                  hSize(11),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse('tel:1899 4055');
                      if (await canLaunchUrl(url)) {
                      launchUrl(url);
                      } else {
                      print("Can't launch $url");
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(IconPath.phoneIcon,width: 24.w,),
                        wSize(15),
                        Text(
                          '1899-4055',
                          style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700,fontSize: 22,color: CustomColor.blue),
                        ),
                        wSize(24)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
