import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common/simple_appbar.dart';
import 'package:nuuz/ui/report/report_bottomsheet.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import 'my_drawer/my_drawer_controller.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(myDrawerProvider.notifier).getUserData();
      final userData = ref.watch(myDrawerProvider);
      safePrint(userData!.profile_image);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final menuNavigator = ref.watch(navigatorProvider);
        final userData = ref.watch(myDrawerProvider);
        return Scaffold(
          appBar: SimpleAppbar(context: context, title: userData!.nick_name!,),
          body: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      hSize(54),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomContainer(
                          width: double.infinity,
                          radius: 12,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              hSize(50.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: SizedBox(
                                    child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elitsed do eiusmod temperLorem ipsum dolor sit amet, consectetur adipiscing elitsed do eiusmod',
                                  style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
                                )),
                              ),
                              hSize(30.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 64.h,
                                    width: 154.w,
                                    decoration: BoxDecoration(
                                      color: CustomColor.lightWhite,
                                      border: Border.all(color: CustomColor.gray),
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            top: 8.h,
                                            child: Text(
                                              'Follower',
                                              style: CustomTextStyle.descriptionS.copyWith(color: CustomColor.dark),
                                            )),
                                        Positioned(
                                            top: 16.h,
                                            child: Text(
                                              '5.68K',
                                              style: CustomTextStyle.headerXL.copyWith(color: CustomColor.primary),
                                            ))
                                      ],
                                    ),
                                  ),
                                  wSize(12),
                                  Container(
                                    height: 64.h,
                                    width: 154.w,
                                    decoration: BoxDecoration(
                                      color: CustomColor.lightWhite,
                                      border: Border.all(color: CustomColor.gray),
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            top: 8.h,
                                            child: Text(
                                              'Following',
                                              style: CustomTextStyle.descriptionS.copyWith(color: CustomColor.dark),
                                            )),
                                        Positioned(
                                            top: 16.h,
                                            child: Text(
                                              '10.2K',
                                              style: CustomTextStyle.headerXL.copyWith(color: CustomColor.primary),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              hSize(16),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: CustomContainer(
                                  width: double.infinity,
                                  height: 44.h,
                                  containerColor: CustomColor.primary,
                                  radius: 13,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        IconPath.post,
                                        color: Colors.white,
                                      ),
                                      wSize(8),
                                      Text(
                                        'Edit Profile',
                                        style: CustomTextStyle.headerS.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              hSize(16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8.h,
                    child: Container(
                      width: 90.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.w, color: Colors.white),
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                        image: const DecorationImage(image: AssetImage(IconPath.noProfile)),
                      ),
                      child: ClipRRect(borderRadius: BorderRadius.circular(100.0), child: Image.network(userData!.profile_image!)),
                    ),
                  ),
                ],
              ),
              hSize(12),
              Stack(alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomContainer(
                      width: double.infinity,
                      height: 46.h,
                      radius: 12,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap:(){
                                safePrint('tap');
                                ref.watch(navigatorProvider.notifier).tapLeft(menuNavigator);
                              },
                              child: SizedBox(  height: 46.h,
                                child: Center(
                                  child: Text(
                                    'Posts',
                                    style: CustomTextStyle.buttonM.copyWith(color: menuNavigator?CustomColor.primary:CustomColor.dark),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap:(){
                                ref.watch(navigatorProvider.notifier).tapRight(menuNavigator);
                              },
                              child: SizedBox(height: 46.h,
                                child: Center(
                                  child: Text(
                                    'Comments',
                                    style: CustomTextStyle.buttonM.copyWith(color: menuNavigator?CustomColor.dark:CustomColor.primary),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                      left: menuNavigator ? 158-90.w : 158+85.w,
                      duration: const Duration(milliseconds: 200),
                      child: CustomContainer(width: 74.w, height: 3.h, containerColor: CustomColor.primary,))
                ],
              ),

              hSize(30),
              OutlinedButton(onPressed: (){
                showReport(context: context, isUserReport: true, isPostReport: false, );
              }, child: const Text('신고버튼')),

            ],
          ),
        );
      },
    );
  }
}


final navigatorProvider = StateNotifierProvider<NavigatorProvider, bool>((ref) {
  return NavigatorProvider();
});

class NavigatorProvider extends StateNotifier<bool> {
  NavigatorProvider() : super(true);

  tapLeft(bool nowState)=>nowState?null:state=true;
  tapRight(bool nowState)=>nowState?state=false:null;


}


