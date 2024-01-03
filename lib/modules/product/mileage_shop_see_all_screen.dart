import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/product/widget/product_item_view.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/price_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class MileageShopSeeAllScreen extends StatelessWidget {
  const MileageShopSeeAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background, statusBarColor: CustomColor.background, statusBarIconBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColor.background,
          body: Column(
            children: [
              CustomAppBar(
                title: 'Prod_Mile_0000',
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
                      hSize(10),
                      myMileagePointView(),
                      popularPackageView(),
                      mileageShopListView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget popularPackageView() {
    return Container(
      height: 156.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.5),
      decoration: BoxDecoration(color: CustomColor.white, borderRadius: BorderRadius.circular(10.w)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(IconPath.popularPackageIcon),
          ),
          Positioned(
            left: 18.w,
            top: 11.h,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prod_Main_0008'.tr(),
                  style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 18.sp),
                ),
                hSize(3),
                Text(
                  'Prod_Desc_0000'.tr(),
                  // 'You can preview the product \ndescription. Up to ? characters are \nshown in the pre',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style:
                      CustomTextStyle.textStyle(height: 1.4, color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 12.sp),
                ),
                const Spacer(),
                PriceButton(
                  price: '9,999,999',
                  iconSize: 20.w,
                  alignment: Alignment.centerLeft,
                ),
                hSize(14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myMileagePointView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        height: 160.h,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                  color: CustomColor.purple_50.withOpacity(0.2),
                ),
                padding: EdgeInsets.only(left: 18.w, top: 16.h),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(IconPath.myMileagePointBg),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prod_Mile_0001'.tr(),
                            style: CustomTextStyle.textStyle(color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w700, fontSize: 19.sp),
                          ),
                          hSize(4),
                          Text(
                            'Prod_Mile_0002'.tr(),
                            style: CustomTextStyle.textStyle(color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 12.sp),
                          ),
                          hSize(10),
                          Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: PriceButton(
                              bgColor: CustomColor.white.withOpacity(0.3),
                              price: '9,9999,999',
                              txtColor: CustomColor.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
                color: CustomColor.white,
              ),
              child: Center(
                child: Image.asset(
                  IconPath.addBtnIcon,
                  width: 26.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mileageShopListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Prod_Mile_0000'.tr(),
            style: CustomTextStyle.headerS,
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20.w),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return ProductIemView(onTap: () {
              context.goNamed('/ProductDetailScreen');
            });
          },
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 12,
            );
          },
        ),
      ],
    );
  }
}
