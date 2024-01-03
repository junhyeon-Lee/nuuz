import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/home/nuuz_home/home_controller.dart';
import 'package:nuuz/modules/product/controller/product_controller.dart';
import 'package:nuuz/modules/sign/access/access_controller.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/app_setting_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  initState() {
    super.initState();

    ///App start
    ///check user token and permission
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ///제품 데이터 가져오기
      ref.watch(getProductProvider.notifier).getProgram();

      ///노티스 가져오기
      await ref.watch(noticeProvider.notifier).getNotice(context: context);

      ///이벤트 가져오기
      await ref.watch(eventProvider.notifier).getEvent();

      ///배너 가져오기
      await ref.watch(bannerListProvider.notifier).getBannerList();

      await ref.watch(accessProvider.notifier).initPermissionCheck();
      await ref.watch(deviceInfoProvider.notifier).getAppVersion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final splashRoute = ref.listen(accessProvider, (previous, next) {
          if (next != null) {
            if (next) {
              context.go('/signScreen');
            } else {
              context.go('/accessScreen');
            }
          }
        });
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 172.h),
                  child: Container(
                    width: 191.35.w,
                    height: 44.h,
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(IconPath.logo))),
                  ),
                ),
                Stack(
                  children: [
                    Positioned.fill(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [const CustomIndicator('Loading..'), SizedBox(height: 108.h)],
                      )),
                    ),
                    SizedBox(width: double.infinity, child: SvgPicture.asset(IconPath.splash, fit: BoxFit.fill)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
