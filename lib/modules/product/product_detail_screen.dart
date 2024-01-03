import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background, statusBarColor: CustomColor.background, statusBarIconBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColor.background,
          body: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Column(
                  children: [
                    CustomAppBar(
                      title: 'Prod_Main_0005',
                      onTap: () {
                        context.pop();
                      },
                      iconPath: IconPath.leftBackIcon,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            imageView(),
                            priceView(),
                            titleDescriptionView(),
                            hSize(12),
                            recommendProductView(),
                            SizedBox(
                              height: 40.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 24.h,
                child: CustomButton(
                  height: 42.h,
                  title: 'Prod_Mile_0003',
                  onTap: () {
                    safePrint('tap');
                    context.goNamed('/MileageTermsScreen');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Image.asset(
            IconPath.productDetailBg,
            fit: BoxFit.fill,
          ),
          hSize(10),
          listViewPhotos(),
        ],
      ),
    );
  }

  Widget listViewPhotos() {
    return SizedBox(
      height: 68.w,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                IconPath.productDetailBg,
                width: 68.w,
                fit: BoxFit.cover,
              ),
            );
          },
          separatorBuilder: (context, i) {
            return SizedBox(
              width: 9.w,
            );
          },
          itemCount: 10),
    );
  }

  Widget priceView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(11.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Price',
            style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 18.sp),
          ),
          Row(
            children: [
              Image.asset(
                IconPath.mIcon,
                width: 28.w,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                '9,9999,999',
                maxLines: 1,
                style: CustomTextStyle.textStyle(color: CustomColor.purple, fontWeight: FontWeight.w700, fontSize: 20.sp),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget titleDescriptionView() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(10.w),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prod_Titl_0000'.tr(),
            style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 18.sp),
          ),
          const SizedBox(
            height: 8,
          ),
          ExpandableText(
            'Synergistically create collaborative platforms without viral processes. Intrinsicly orchestrate distributed initiatives through goal-oriented synergy. Credibly maintain cooperative infrastructures via cross-unit outsourcing. Distinctively seize efficient niches for 24/7 interfaces. Credibly streamline goal-oriented quality vectors with dynamic best practices. Synergistically create collaborative platforms without viral processes. Intrinsicly orchestrate distributed initiatives through goal-oriented synergy. Credibly maintain cooperative infrastructures via cross-unit outsourcing. Distinctively seize efficient niches for 24/7 interfaces. Credibly streamline goal-oriented quality vectors with dynamic best practices.',
            expandText: 'Comm_Gene_0010'.tr(),
            collapseText: 'SHOW_LESS'.tr(),
            maxLines: 7,
            style: CustomTextStyle.textStyle(color: CustomColor.dark, height: 1.7, fontWeight: FontWeight.w400, fontSize: 12.sp),
            linkColor: CustomColor.primary,
            animation: true,
            collapseOnTextTap: true,
          ),
          hSize(10),
        ],
      ),
    );
  }

  Widget recommendProductView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Prod_Main_0006'.tr(),
            style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 18.sp),
          ),
        ),
        SizedBox(
          height: 200.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return SizedBox(
                width: 116.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        IconPath.productDetailBg,
                        width: 116.w,
                        height: 116.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Nourshing Skin Cream',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, i) {
              return SizedBox(
                width: 12.w,
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
