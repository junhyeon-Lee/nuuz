import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/user_product_controller.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/image_path.dart';
import 'package:nuuz/util/dio/dio_interceptor.dart';
import 'package:nuuz/util/log_print.dart';

class ProductRegistration extends ConsumerStatefulWidget {
  const ProductRegistration({super.key, required this.productId, required this.productCode});

  final String productId;
  final String? productCode;

  @override
  ConsumerState<ProductRegistration> createState() => _ProductRegistrationState();
}

class _ProductRegistrationState extends ConsumerState<ProductRegistration> {
  // late final pageController;
  // final pages = <Widget>[
  //   StepOne(),
  //   StepTwo(),
  // ];
  final TextEditingController _controllerText1 = TextEditingController();
  final TextEditingController _controllerText2 = TextEditingController();
  final TextEditingController _controllerText3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // pageController = PageController(viewportFraction: 1);
    safePrint('프로덕트 코드');
    safePrint(widget.productCode);
    safePrint(widget.productCode == null);
    safePrint(widget.productCode == '');
    if (widget.productCode != '') {
      safePrint('qr로 코드를 읽은 경우');
      if (widget.productCode!.substring(0, 4) == 'S/N:') {
        _controllerText1.text = widget.productCode!.substring(4, 8);
        _controllerText2.text = widget.productCode!.substring(8, 12);
        _controllerText3.text = widget.productCode!.substring(12, 16);
      } else {
        _controllerText1.text = widget.productCode!.substring(0, 4);
        _controllerText2.text = widget.productCode!.substring(4, 8);
        _controllerText3.text = widget.productCode!.substring(8, 12);
      }
    } else {
      safePrint('직접 입력');
      _controllerText1.text = '';
      _controllerText2.text = '';
      _controllerText3.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: NuuzContainer(
          containerColor: CustomColor.lightWhite,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: CustomColor.lightWhite,
                  leading: GestureDetector(
                    onTap: context.pop,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        IconPath.close,
                      ),
                    ),
                  ),
                  title: LargeHeaderText(text: 'Comm_Gene_0015'.tr()),
                ),
                SizedBox(height: 20.h),
                NuuzContainer(
                    // height: 350.h,
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MediumHeaderText(text: "Devi_Regi_0009".tr()),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(ImagePath.productCodeGuideImage),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    MediumDescriptionText(text: "Devi_Regi_0010".tr()),
                    SizedBox(height: 12.h),
                  ],
                )),
                SizedBox(height: 12.h),
                SmallHeaderText(text: "Devi_Regi_0011".tr()),
                SizedBox(height: 12.h),
                Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controllerText1,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide.none)),
                          maxLength: 4,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      const Text("-"),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: TextField(
                          controller: _controllerText2,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide.none)),
                          maxLength: 4,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      const Text("-"),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: TextField(
                          controller: _controllerText3,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide.none)),
                          maxLength: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                CommonButton(onPressed: _onRegisterButtonPress, text: "Devi_Regi_0000".tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegisterButtonPress() async {
    var productCode = _controllerText1.text + _controllerText2.text + _controllerText3.text;
    if (productCode.length != 12) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => CommonMessageBottomSheet(headerText: "Comm_Gene_0005".tr(), descriptionText: "Devi_Regi_0013".tr()),
      );
    }
    try {
      await ref.read(userProductController.notifier).updateUserProduct(widget.productId, productCode);
      if (mounted) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => CommonMessageBottomSheet(
              headerText: "Comm_Gene_0005".tr(),
              descriptionText: "Prod_Poin_0031".tr(),
              onPrimaryButtonPressed: () {
                context.pop();
                context.pop();
              }),
        );
      }
    } on Exception catch (e) {
      safePrint('에러입니다.');
      safePrint(productRegister);
      safePrint(e);
      if (productRegister == 1) {
        productRegister = 0;
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => CommonMessageBottomSheet(headerText: "Comm_Gene_0005".tr(), descriptionText: "Devi_Regi_0014".tr()),
        );
      } else {
        productRegister = 0;
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => CommonMessageBottomSheet(headerText: "Comm_Gene_0005".tr(), descriptionText: "Devi_Regi_0013".tr()),
        );
      }
    }
  }
}
