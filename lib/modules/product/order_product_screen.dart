import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/product/widget/product_item_view.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/common_widget/custom_radio_button.dart';
import 'package:nuuz/ui/common_widget/custom_textfield.dart';
import 'package:nuuz/ui/common_widget/custom_tile_view.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class OrderProductScreen extends StatelessWidget {
  OrderProductScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController cellPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();
  TextEditingController noteController = TextEditingController();

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
                  context.pop();
                },
                iconPath: IconPath.closeIcon,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h), child: const ProductIemView()),
                        shippingView(),
                        hSize(30),
                        CustomTileView(
                            context: context,
                            title: 'Prod_Mile_0018',
                            description:
                                'This is where health precautions for product use are written. Details will be forthcoming with product launch.I want the area to be designed as an area that can be easily managed through the admin. \n\n If the content inside is long, scrolling must be controlled by touch. \n\n This is where health precautions for product use are written. Details will be forthcoming with product launch.I want the area to be designed as an area that can be easily managed through the admin.\n\n\n'),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 26.h),
                          child: CustomButton(
                            title: 'Prod_Mile_0003',
                            height: 48.h,
                            onTap: () {
                              safePrint('tap');
                              context.goNamed('/CompleteOrderScreen');
                            },
                            horizontalPadding: 40.w,
                            bgColor: CustomColor.primary,
                            borderColor: CustomColor.primary,
                            textColor: CustomColor.white,
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
      ),
    );
  }

  Widget shippingView() {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        children: [
          Text(
            'Prod_Mile_0006'.tr(),
            style: CustomTextStyle.textStyle(color: CustomColor.dark.withOpacity(0.7), fontWeight: FontWeight.w400, height: 1.2, fontSize: 14.sp),
          ),
          hSize(19),
          Row(
            children: [
              Expanded(
                  child: CustomRadioButton(
                title: 'Prod_Mile_0007',
                isSelect: true,
              )),
              Expanded(child: CustomRadioButton(title: 'Prod_Mile_0008')),
            ],
          ),
          defaultShippingView(),
        ],
      ),
    );
  }

  Widget defaultShippingView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hSize(16),
        CustomTextField(
          controller: nameController,
          title: 'Prod_Mile_0009',
          inputType: TextInputType.text,
          hintText: 'Sign_Inup_0029'.tr(),
        ),
        hSize(10),
        CustomTextField(
          controller: cellPhoneController,
          title: 'Prod_Mile_0010',
          inputType: TextInputType.number,
          hintText: 'Enter Your Cell Number',
        ),
        hSize(10),
        Text(
          'Prod_Mile_0011'.tr(),
          style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
        ),
        hSize(8.2),
        Container(
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColor.darkWhite,
          ),
          child: Row(
            children: [
              wSize(12.w),
              Expanded(
                child: TextField(
                  controller: addressController,
                  obscuringCharacter: '*',
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Prod_Mile_0012'.tr(),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Container(
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColor.primary,
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Center(
                  child: Text(
                    'Comm_Gene_0037'.tr(),
                    style: CustomTextStyle.textStyle(color: CustomColor.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        hSize(10),
        CustomTextField(
          controller: addressDetailController,
          inputType: TextInputType.text,
          hintText: 'Prod_Mile_0013',
        ),
        hSize(10),
        CustomTextField(
          controller: noteController,
          title: 'Prod_Mile_0014',
          inputType: TextInputType.text,
          maxLine: 10,
          hintText: 'Prod_Mile_0015',
        ),
        hSize(28),
      ],
    );
  }
}
