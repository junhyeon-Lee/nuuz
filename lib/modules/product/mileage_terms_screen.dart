import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/common_widget/custom_check_box.dart';
import 'package:nuuz/ui/common_widget/custom_tile_view.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class MileageTermsScreen extends StatefulWidget {
  const MileageTermsScreen({Key? key}) : super(key: key);

  @override
  State<MileageTermsScreen> createState() => _MileageTermsScreenState();
}

class _MileageTermsScreenState extends State<MileageTermsScreen> {
  bool isAllNoticeRead = false;
  bool isTerms = false;
  bool isPrivacyPolicy = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.white, statusBarColor: CustomColor.background, statusBarIconBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: 'Prod_Mile_0004',
                onTap: () {
                  context.pop();
                },
                iconPath: IconPath.closeIcon,
              ),
              hSize(5),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomTileView(
                            context: context,
                            title: 'Sign_Inup_0019',
                            description:
                                'This is where health precautions for product use are written. Details will be forthcoming with product launch.I want the area to be designed as an area that can be easily managed through the admin. \n\n If the content inside is long, scrolling must be controlled by touch. \n\n This is where health precautions for product use are written. Details will be forthcoming with product launch.I want the area to be designed as an area that can be easily managed through the admin.\n\n\n',
                            isSelected: isTerms),
                        CustomTileView(
                            context: context,
                            title: 'Sign_Inup_0020',
                            description:
                                'This is where health precautions for product use are written. Details will be forthcoming with product launch.I want the area to be designed as an area that can be easily managed through the admin. \n\n If the content inside is long, scrolling must be controlled by touch. \n\n This is where health precautions for product use are written. Details will be forthcoming with product launch.I want the area to be designed as an area that can be easily managed through the admin.\n\n\n',
                            isSelected: isPrivacyPolicy),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: CustomColor.white,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomCheckbox(
                          isSelect: isAllNoticeRead,
                          onTap: () {
                            setState(() {
                              if (isAllNoticeRead) {
                                isTerms = false;
                                isPrivacyPolicy = false;
                              } else {
                                isTerms = true;
                                isPrivacyPolicy = true;
                              }
                              isAllNoticeRead = !isAllNoticeRead;
                            });
                          },
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        Text(
                          'Sign_Inup_0022'.tr(),
                          style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
                        ),
                      ],
                    ),
                    hSize(35),
                    CustomButton(
                      title: 'Comm_Gene_0046',
                      onTap: () {
                        safePrint('tap');
                        context.goNamed('/OrderProductScreen');
                      },
                      horizontalPadding: 0,
                      bgColor: CustomColor.primary,
                      borderColor: CustomColor.primary,
                      textColor: CustomColor.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
