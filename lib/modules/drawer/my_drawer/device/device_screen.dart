import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/drawer/my_drawer/device/widget/device_item_view.dart';
import 'package:nuuz/modules/drawer/my_drawer/device/widget/device_managment_bottom_sheet.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_service.dart';
import 'package:nuuz/modules/home/main_screen.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/select_product_screen.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/user_product_controller.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/custom_app_bar.dart';
import 'package:nuuz/ui/common_widget/no_item_found.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/log_print.dart';

import '../my_drawer_controller.dart';

class DeviceScreen extends ConsumerStatefulWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends ConsumerState<DeviceScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      safePrint('api 호출');
      ref.watch(userProductProvider.notifier).getUserProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(userProductProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: CustomColor.background,
          statusBarColor: CustomColor.background,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                hSize(MediaQuery.of(context).viewPadding.top),
                CustomAppBar(
                  title: 'Side_Main_0001',
                  onTap: () {
                    context.pop();
                  },
                  rightIconPath: IconPath.addDeviceIcon,
                  iconPath: IconPath.leftBackIcon,
                  rightIconOnTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                const SelectProductScreen()));
                    // context.goNamed("select-product");
                  },
                ),
                hSize(10),
                productList == null
                    ? Container(
                        height: MediaQuery.of(context).size.height - 200,
                        alignment: Alignment.center,
                        child: CustomIndicator('Comm_Gene_0001'.tr()))
                    : Expanded(
                        child:  productList.userProduct.length==0 ? const NoItemFound(title: '디바이스가 없습니다.', icon: IconPath.noPostIcon) : ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return DeviceItemView(
                                settingIcon: true,
                                  onTapSetting: () {
                                    deviceManagementBottomSheet(
                                      context: context,
                                      onTapUse: () {

                                        context.go('/main');
                                        ref.watch(mainPageIndexProvider.notifier).changeTab(2);
                                        ref.watch(mainPageProvider.notifier).pagingMainScreen(2);

                                      },
                                      product:productList.userProduct[i],
                                      isDeleted: (data) async {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        LocalDB localDB = LocalDB();
                                        LoginResponse? loginResponse = await localDB.findAuthInfo();
                                        MyDrawerRepository dr = MyDrawerRepository();
                                        await dr
                                            .deleteUserProduct(
                                                productId: productList.userProduct[i].user_product_id,
                                                token: loginResponse!.accessToken)
                                            .then((value) => {
                                                  if (value) {ref.watch(userProductProvider.notifier).getUserProduct()}
                                                });

                                        await ref.watch(userProductController.notifier).fetchUserProducts();
                                        final userProducts = ref.watch(userProductController);
                                        safePrint('유저 프로덕트의 길이를 확인해보자');
                                        safePrint(userProducts?.length);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                    );
                                  },
                                  product: productList.userProduct[i]);
                            },
                            separatorBuilder: (context, i) {
                              return hSize(11);
                            },
                            itemCount: productList.userProduct.length ?? 0,
                          ),
                        ),
                      ),
              ],
            ),
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height - 200,
                    alignment: Alignment.center,
                    child: CustomIndicator('Comm_Gene_0001'.tr()))
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
