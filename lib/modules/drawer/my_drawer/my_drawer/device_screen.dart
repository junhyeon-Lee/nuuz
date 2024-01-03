import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_drawer/userproduct.dart';
import 'package:nuuz/modules/drawer/my_drawer/device/widget/device_managment_bottom_sheet.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import '../my_drawer_controller.dart';

class DeviceRegistrationScreen extends ConsumerStatefulWidget {
  const DeviceRegistrationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DeviceRegistrationScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends ConsumerState<DeviceRegistrationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      safePrint('api 호출');
      ref.watch(userProductProvider.notifier).getUserProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(userProductProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background,
          statusBarColor: CustomColor.background,
          statusBarIconBrightness: Brightness.dark),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              CustomAppBar(
                title: 'Comm_Gene_0015',
                onTap: () {
                  context.pop();
                },
                iconPath: IconPath.closeIcon,
              ),


              Expanded(
                child: productList == null
                    ?  Center(child: CustomIndicator('Comm_Gene_0001'.tr()))
                    : Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Devi_Regi_0001'.tr(),
                        style: CustomTextStyle.headerM,
                      ),
                      hSize(5),
                      Text(
                        'Devi_Regi_0002'.tr(),
                        style: CustomTextStyle.descriptionS,
                      ),
                      hSize(25),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Visibility(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        deviceManagementBottomSheet(context: context);
                                      },
                                      child: productItem(productList.userProduct[index])),
                                );
                              },
                              itemCount: productList.userProduct.length),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: CustomButton(title: 'Devi_Regi_0003', onTap: () {  },horizontalPadding: 38.w,borderColor: CustomColor.primary,bgColor: CustomColor.primary,textColor: CustomColor.white,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productItem(UserProduct product) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CustomContainer(
        radius: 12,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 96.w,
                height: 96.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: product.product.imageUrl.length > 0 ? Image.network(product.product.imageUrl[0].toString(),
                      fit: BoxFit.cover,
                    ) : Image.asset(IconPath.nuuzAppIcon)),
              ),
              wSize(14),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hSize(2),
                  Text(
                    product.product.name,
                    style: CustomTextStyle.buttonM,
                  ),
                  hSize(9),
                  SizedBox(
                    width: 198.w,
                    child: RichText(
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: product.product.description,
                          style: CustomTextStyle.descriptionM,
                        ),
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
