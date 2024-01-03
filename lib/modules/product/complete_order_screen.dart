import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/modules/product/widget/product_item_view.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CompleteOrderScreen extends StatelessWidget {
  const CompleteOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background, statusBarColor: CustomColor.background, statusBarIconBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: 'Prod_Mile_0005',
                onTap: () {
                  Navigator.pop(context);
                },
                iconPath: IconPath.closeIcon,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: LayoutBuilder(builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Column(
                              children: [
                                hSize(22),
                                Image.asset(
                                  IconPath.completeOrderIcon,
                                  width: 129.w,
                                  height: 129.w,
                                ),
                                hSize(10),
                                Text(
                                  'Comm_Gene_0028'.tr(),
                                  style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 18.sp),
                                ),
                                hSize(36),
                                const ProductIemView(),
                                hSize(12),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: CustomColor.white,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Prod_Mile_0016'.tr(),
                                        style: CustomTextStyle.textStyle(
                                            height: 1.4, color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 18.sp),
                                      ),
                                      hSize(15),
                                      Text(
                                        'Prod_Mile_0017'.tr(),
                                        style: CustomTextStyle.textStyle(
                                            height: 1.4, color: CustomColor.dark, fontWeight: FontWeight.w400, fontSize: 12.sp),
                                      ),
                                      hSize(12),
                                      Text(
                                        'Prod_Mile_0006'.tr(),
                                        style: CustomTextStyle.textStyle(
                                            color: CustomColor.dark.withOpacity(0.7), height: 1.6, fontWeight: FontWeight.w400, fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                hSize(14),
                                const Spacer(),
                                CustomButton(
                                  title: 'Comm_Gene_0034',
                                  height: 48.h,
                                  onTap: () {},
                                  horizontalPadding: 24.w,
                                  bgColor: CustomColor.primary,
                                  borderColor: CustomColor.primary,
                                  textColor: CustomColor.white,
                                ),
                                hSize(28),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
