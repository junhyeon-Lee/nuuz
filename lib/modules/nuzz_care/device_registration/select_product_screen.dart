import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/product_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/user_product_controller.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_image_container.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class SelectProductScreen extends ConsumerStatefulWidget {
  const SelectProductScreen({super.key});

  @override
  ConsumerState<SelectProductScreen> createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends ConsumerState<SelectProductScreen> {
  late bool isSelected;

  @override
  Widget build(BuildContext context) {
    var productList = ref.watch(productController);
    var selectedIndex = ref.watch(isSelectedProvider);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
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
            title: Text(
              'Comm_Gene_0015'.tr(),
              style: CustomTextStyle.headerL,
            ),
          ),
          body: NuuzContainer(
            containerColor: CustomColor.lightWhite,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Devi_Regi_0001'.tr(),
                    style: CustomTextStyle.headerL,
                  ),
                  Text(
                    'Devi_Regi_0002'.tr(),
                    style: CustomTextStyle.descriptionL,
                  ),
                  SizedBox(height: 30.h),
                  productList.when(
                    data: (data) => Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: data
                              .map((e) => Visibility(visible: e.value == 'device', child: _renderProductItem(data, e, selectedIndex, context)))
                              .toList(),
                        ),
                      ),
                    ),
                    error: (err, stack) => Text('Error: $err'),
                    loading: () => const Center(child: CustomIndicator('')),
                  ),
                  // loading: () => const CircularProgressIndicator()),
                  CommonButton(
                    text: 'Devi_Regi_0003'.tr(),
                    onPressed: ref.read(isSelectedProvider) != null
                        ? () async {
                            var productsList = ref.read(productController).value;
                            var selectedIndex = ref.read(isSelectedProvider);
                            var productId = productsList!.elementAt(selectedIndex!).productId;
                            _showBottomSheet(context, productId);
                          }
                        : null,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
        loadingScreen(),
      ],
    );
  }

  Padding _renderProductItem(List<Product> data, Product e, int? selectedIndex, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      child: GestureDetector(
        onTap: () => ref.read(isSelectedProvider.notifier).state = data.indexOf(e),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ref.read(isSelectedProvider.notifier).state == data.indexOf(e) ? CustomColor.primary : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: CustomColor.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 12.h),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: e.imageUrl[0] ?? '',
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                          height: 100.w,
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: e.imageUrl[1] ?? '',
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                height: 46.h,
                                width: 200.w,
                                fit: BoxFit.fitWidth,
                              ),
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  e.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyle.descriptionL,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _showBottomSheet(BuildContext context, String productId) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => NuuzContainer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: CustomColor.white,
                leading: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(
                      IconPath.close,
                    ),
                  ),
                ),
                title: Text(
                  'Comm_Gene_0005'.tr(),
                  style: CustomTextStyle.headerL,
                ),
              ),
              Divider(
                height: 24.h,
                thickness: 1.h,
              ),
              Text(
                'Devi_Regi_0004'.tr(),
                style: CustomTextStyle.descriptionM,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150.h,
                    child: CommonOutlinedButton(
                      onPressed: () async {
                        await _showSuccessBottomSheet(productId);
                        context.pop();
                        context.pop();
                        context.pop();
                        context.go('/main');
                      },
                      child: Text("Comm_Gene_0035".tr()),

                      ///나중에
                    ),
                  ),
                  SizedBox(
                    width: 150.h,
                    child: CommonButton(
                      onPressed: () => context.goNamed(
                        'scan-qrcode',
                        queryParams: {'product_id': productId},
                      ),
                      text: 'Devi_Regi_0000'.tr(),

                      ///등록하기
                    ),
                  ),
                ],
              ),
              hSize(13),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSuccessBottomSheet(String productId) async {
    try {
      await ref.read(userProductController.notifier).updateUserProduct(productId, null); //Hardcoding productId as suggested by backend
      setState(() {});
      if (mounted) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => CommonMessageBottomSheet(
            headerText: "Comm_Gene_0036".tr(),
            descriptionText: "Devi_Regi_0005".tr(),
            primaryButtonText: "Comm_Gene_0023".tr(),
            onPrimaryButtonPressed: () {
              context.go('/main');
              ref.read(mainPageIndexProvider.notifier).changeTab(1);
              ref.read(mainPageProvider.notifier).pagingMainScreen(1);
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
              }
            },
          ),
        );
      }
    } on Exception catch (e) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => CommonMessageBottomSheet(
          headerText: "Comm_Gene_0005".tr(),
          descriptionText: (e as DioError).response!.data['message'].toString(),
        ),
      );
    }

    // return showModalBottomSheet(
    //   context: context,
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   builder: (context) => CommonMessageBottomSheet(
    //     headerText: 'Comm_Gene_0036'.tr(),
    //     descriptionText: 'Devi_Regi_0005'.tr(),
    //   ),
    // );
  }
}

var isSelectedProvider = StateProvider<int?>((ref) => null);
