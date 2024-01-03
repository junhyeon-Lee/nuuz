import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:video_player/video_player.dart';

class ServiceGuideScreen extends StatefulWidget {
  const ServiceGuideScreen({Key? key}) : super(key: key);

  @override
  State<ServiceGuideScreen> createState() => _ServiceGuideScreenState();
}

class _ServiceGuideScreenState extends State<ServiceGuideScreen> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late VideoPlayerController _controller3;
  late VideoPlayerController _controller4;
  late VideoPlayerController _controller5;

  late Future<void> _initializeVideoPlayerFuture;
  PageController pageController = PageController();

  @override
  void initState() {
    if (Platform.isAndroid) {
      _controller1 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide1.avi',
      )..setLooping(true);
      _controller2 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide2.avi',
      )..setLooping(true);
      _controller3 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide3.avi',
      )..setLooping(true);
      _controller4 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide4.avi',
      )..setLooping(true);
      _controller5 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide5.avi',
      )..setLooping(true);
    } else {
      _controller1 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide1.mp4',
      )..setLooping(true);
      _controller2 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide2.mp4',
      )..setLooping(true);
      _controller3 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide3.mp4',
      )..setLooping(true);
      _controller4 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide4.mp4',
      )..setLooping(true);
      _controller5 = VideoPlayerController.asset(
        'assets/serviceGuide/serviceGuide5.mp4',
      )..setLooping(true);
    }

    _initializeVideoPlayerFuture = _controller5.initialize();
    _initializeVideoPlayerFuture = _controller4.initialize();
    _initializeVideoPlayerFuture = _controller3.initialize();
    _initializeVideoPlayerFuture = _controller2.initialize();
    _initializeVideoPlayerFuture = _controller1.initialize();

    _controller1.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 56.h, 20.w, 40.h),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final pagingIndex = ref.watch(serviceGuideProvider);
            ref.listen(serviceGuideProvider, (previous, next) {
              switch (next) {
                case 0:
                  _controller1.play();
                  break;
                case 1:
                  _controller2.play();
                  break;
                case 2:
                  _controller3.play();
                  break;
                case 3:
                  _controller4.play();
                  break;
                case 4:
                  _controller5.play();
                  break;
              }
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 20.h, child: Image.asset(IconPath.logo)),
                        Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/main');
                            },
                            child: Text(
                              'SKIP',
                              style: CustomTextStyle.descriptionM,
                            ),
                          ),
                        ),
                      ],
                    ),
                    hSize(25.h),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: SizedBox(
                        width: 350.w,
                        height: 450.h,
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: pageController,
                            children: [
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return AspectRatio(
                                      aspectRatio: _controller1.value.aspectRatio,
                                      child: VideoPlayer(_controller1),
                                    );
                                  } else {
                                    return const Center(child: CustomIndicator(''));
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return AspectRatio(
                                      aspectRatio: _controller2.value.aspectRatio,
                                      child: VideoPlayer(_controller2),
                                    );
                                  } else {
                                    return const Center(child: CustomIndicator(''));
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return AspectRatio(
                                      aspectRatio: _controller3.value.aspectRatio,
                                      child: VideoPlayer(_controller3),
                                    );
                                  } else {
                                    return const Center(child: CustomIndicator(''));
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return AspectRatio(
                                      aspectRatio: _controller4.value.aspectRatio,
                                      child: VideoPlayer(_controller4),
                                    );
                                  } else {
                                    return const Center(child: CustomIndicator(''));
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return AspectRatio(
                                      aspectRatio: _controller5.value.aspectRatio,
                                      child: VideoPlayer(_controller5),
                                    );
                                  } else {
                                    return const Center(child: CustomIndicator(''));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    hSize(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: pagingIndex == 0 ? 32.w : 6.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColor.primary, width: 1.w),
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: pagingIndex == 0 ? Colors.transparent : CustomColor.primary,
                          ),
                        ),
                        wSize(4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: pagingIndex == 1 ? 32.w : 6.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColor.primary, width: 1.w),
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: pagingIndex == 1 ? Colors.transparent : CustomColor.primary,
                          ),
                        ),
                        wSize(4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: pagingIndex == 2 ? 32.w : 6.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColor.primary, width: 1.w),
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: pagingIndex == 2 ? Colors.transparent : CustomColor.primary,
                          ),
                        ),
                        wSize(4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: pagingIndex == 3 ? 32.w : 6.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColor.primary, width: 1.w),
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: pagingIndex == 3 ? Colors.transparent : CustomColor.primary,
                          ),
                        ),
                        wSize(4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: pagingIndex == 4 ? 32.w : 6.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColor.primary, width: 1.w),
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            color: pagingIndex == 4 ? Colors.transparent : CustomColor.primary,
                          ),
                        ),
                      ],
                    ),
                    hSize(34),
                    Text(
                      ref.watch(serviceGuideTitleProvider).tr(),
                      style: CustomTextStyle.headerM,
                    ),
                    hSize(22),
                    SizedBox(
                      width: 326.w,
                      child: Text(
                        ref.watch(serviceGuideBodyProvider).tr(),
                        style: CustomTextStyle.descriptionM,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: pagingIndex == 0
                          ? null
                          : () async {
                              await pageController.animateToPage(pageController.page!.toInt() - 1,
                                  duration: const Duration(milliseconds: 200), curve: Curves.ease);
                              ref.watch(serviceGuideProvider.notifier).indexChange(pageController.page!.toInt());
                              ref.watch(serviceGuideTitleProvider.notifier).setTitleText(pageController.page!.toInt());
                              ref.watch(serviceGuideBodyProvider.notifier).setBodyText(pageController.page!.toInt());
                            },
                      child: CustomContainer(
                        width: 120.w,
                        height: 44.h,
                        borderColor: pagingIndex == 0 ? CustomColor.gray : CustomColor.dark,
                        containerColor: CustomColor.darkGray,
                        child: Center(
                            child: Text(
                          'Comm_Gene_0003'.tr(),
                          style: CustomTextStyle.buttonM.copyWith(color: pagingIndex == 0 ? CustomColor.gray : CustomColor.dark),
                        )),
                      ),
                    ),
                    wSize(12),
                    GestureDetector(
                      onTap: pagingIndex == 4
                          ? () {
                              context.go('/main');
                            }
                          : () async {
                              await pageController.animateToPage(pageController.page!.toInt() + 1,
                                  duration: const Duration(milliseconds: 200), curve: Curves.ease);
                              ref.watch(serviceGuideProvider.notifier).indexChange(pageController.page!.toInt());
                              ref.watch(serviceGuideTitleProvider.notifier).setTitleText(pageController.page!.toInt());
                              ref.watch(serviceGuideBodyProvider.notifier).setBodyText(pageController.page!.toInt());
                            },
                      child: CustomContainer(
                        width: 120.w,
                        height: 44.h,
                        containerColor: CustomColor.primary,
                        child: Center(
                            child: Text(
                          'Comm_Gene_0004'.tr(),
                          style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

final serviceGuideProvider = StateNotifierProvider<ServiceGuideProvider, int>((ref) {
  return ServiceGuideProvider();
});

class ServiceGuideProvider extends StateNotifier<int> {
  ServiceGuideProvider() : super(0);

  indexChange(int index) {
    state = index;
    safePrint(state);
  }
}

final serviceGuideTitleProvider = StateNotifierProvider<ServiceGuideTitleProvider, String>((ref) {
  return ServiceGuideTitleProvider();
});

class ServiceGuideTitleProvider extends StateNotifier<String> {
  ServiceGuideTitleProvider() : super('Guid_Serv_0012');
  List<String> titleList = ['Guid_Serv_0012', 'Guid_Serv_0014', 'Guid_Serv_0016', 'Guid_Serv_0018', 'Guid_Serv_0020'];

  setTitleText(int index) {
    state = titleList[index];
  }
}

final serviceGuideBodyProvider = StateNotifierProvider<ServiceGuideBodyProvider, String>((ref) {
  return ServiceGuideBodyProvider();
});

class ServiceGuideBodyProvider extends StateNotifier<String> {
  ServiceGuideBodyProvider() : super('Guid_Serv_0013');
  List<String> bodyList = ['Guid_Serv_0012', 'Guid_Serv_0015', 'Guid_Serv_0017', 'Guid_Serv_0019', 'Guid_Serv_0021'];

  setBodyText(int index) {
    state = bodyList[index];
  }
}
