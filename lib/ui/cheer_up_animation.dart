import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/log_print.dart';

class CheerUpAnimationScreen extends ConsumerStatefulWidget {
  const CheerUpAnimationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CheerUpAnimationScreen> createState() => _CheerUpAnimationScreenState();
}

class _CheerUpAnimationScreenState extends ConsumerState<CheerUpAnimationScreen> with TickerProviderStateMixin {
  List<bool> isAnimatedList = [true, true, true, true, true, true, true, true, true, true, true, true];
  List<double> leftPositionList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<double> bottomPositionList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<double> animatedOpacityList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<double> animatedScaleList = [0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3];
  Random random = Random();
  List<double> itemSize = [46, 26, 38, 46, 26, 38, 46, 26, 38, 26, 38, 46];

  Future<void> leftAnimation(int index) async {
    while (isAnimatedList[index]) {
      if (mounted) {
        setState(() {
          leftPositionList[index] += 30;
          bottomPositionList[index] += 25;
        });
      }
      await Future.delayed(const Duration(milliseconds: 400), () {});
      if (mounted) {
        setState(() {
          leftPositionList[index] -= 30;
          bottomPositionList[index] += 25;
        });
      }
      await Future.delayed(const Duration(milliseconds: 400), () {});
    }
  }

  Future<void> leftAnimation2(int index) async {
    while (isAnimatedList[index]) {
      if (mounted) {
        setState(() {
          leftPositionList[index] += 20;
          bottomPositionList[index] += 20;
        });
      }
      await Future.delayed(const Duration(milliseconds: 400), () {});
      if (mounted) {
        setState(() {
          leftPositionList[index] -= 20;
          bottomPositionList[index] += 20;
        });
      }
      await Future.delayed(const Duration(milliseconds: 400), () {});
    }
  }

  Future<void> rightAnimation(int index) async {
    while (isAnimatedList[index]) {
      if (mounted) {
        setState(() {
          leftPositionList[index] -= 30;
          bottomPositionList[index] += 30;
        });
      }
      await Future.delayed(const Duration(milliseconds: 500), () {});
      if (mounted) {
        setState(() {
          leftPositionList[index] += 30;
          bottomPositionList[index] += 30;
        });
      }
      await Future.delayed(const Duration(milliseconds: 500), () {});
    }
  }

  Future<void> rightAnimation2(int index) async {
    while (isAnimatedList[index]) {
      if (mounted) {
        setState(() {
          leftPositionList[index] -= 20;
          bottomPositionList[index] += 27;
        });
      }
      await Future.delayed(const Duration(milliseconds: 500), () {});
      if (mounted) {
        setState(() {
          leftPositionList[index] += 20;
          bottomPositionList[index] += 27;
        });
      }
      await Future.delayed(const Duration(milliseconds: 500), () {});
    }
  }

  Future<void> scaleAnimation(int index) async {
    if (mounted) {
      setState(() {
        animatedScaleList[index] = 1.2;
      });
    }
    await Future.delayed(const Duration(milliseconds: 300), () {});
    if (mounted) {
      setState(() {
        animatedScaleList[index] = 1;
      });
    }
  }

  Future<void> endScaleAnimation(int index) async {
    if (mounted) {
      setState(() {
        animatedScaleList[index] = 0;
      });
    }
  }

  changeStyle(int index) {
    int randomNumber = random.nextInt(3);
    if (randomNumber == 0) {
      itemSize[index] = 46;
    } else if (randomNumber == 1) {
      itemSize[index] = 38;
    } else {
      itemSize[index] = 26;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> showAnimation(int index) async {
    final animationState = ref.watch(animationStateProvider);
    if (animationState) {
      changeStyle(index);
      if (mounted) {
        setState(() {});
      }
      await Future.delayed(const Duration(milliseconds: 500), () {});
      isAnimatedList[index] = true;
      scaleAnimation(index);
      if (index % 3 == 0) {
        if (index % 2 == 0) {
          leftAnimation(index);
        } else {
          leftAnimation2(index);
        }
      } else {
        if (index % 4 == 0) {
          rightAnimation(index);
        } else {
          rightAnimation2(index);
        }
      }
      animatedOpacityList[index] = 1;
      await Future.delayed(const Duration(seconds: 3), () {
        //   animatedScaleList[index] = 0;
        animatedOpacityList[index] = 0;
      });
      await Future.delayed(const Duration(seconds: 1), () {
        isAnimatedList[index] = false;
      });

      leftPositionList[index] = 0;
      bottomPositionList[index] = 0;

      await Future.delayed(const Duration(seconds: 2), () {});
      showAnimation(index);
    }
  }

  Future<void> playAnimation() async {
    for (int i = 0; i < 12; i++) {
      showAnimation(i);
      await Future.delayed(const Duration(milliseconds: 500), () {});
    }
  }

  @override
  void initState() {
    isAnimatedList = [false, false, false, false, false, false, false, false, false, false, false, false];
    leftPositionList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    bottomPositionList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    animatedOpacityList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    animatedScaleList = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1), () {});
      await ref.watch(animationStateProvider.notifier).animationStart();
    });
    playAnimation();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 1), () {});
      await ref.watch(animationStateProvider.notifier).animationEnd();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 400,
          height: 300,
          color: Colors.transparent,
        ),

        //left
        cheerUpAnimatedContainer(0, 4.w),

        cheerUpAnimatedContainer(5, 41.w),

        cheerUpAnimatedContainer(3, 45.w),

        cheerUpAnimatedContainer(7, 70.w),

        cheerUpAnimatedContainer(10, 99.w),

        cheerUpAnimatedContainer(11, 110.w),

        //right
        cheerUpAnimatedContainer(4, 260.w),

        cheerUpAnimatedContainer(8, 286.w),

        cheerUpAnimatedContainer(6, 302.w),

        cheerUpAnimatedContainer(9, 310.w),

        cheerUpAnimatedContainer(2, 332.w),

        cheerUpAnimatedContainer(1, 356.w),
      ],
    );
  }

  Widget cheerUpAnimatedContainer(int index, double position) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final cheerUpList = ref.watch(userCheerUpProvider);
        return AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: bottomPositionList[index],
            left: leftPositionList[index] + position,
            child: AnimatedOpacity(
              opacity: animatedOpacityList[index],
              duration: const Duration(milliseconds: 300),
              child: AnimatedScale(
                  scale: animatedScaleList[index],
                  duration: const Duration(milliseconds: 300),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.w),
                        child: CustomContainer(
                          radius: 100,
                          containerColor: Colors.white,
                          width: itemSize[index].w,
                          height: itemSize[index].w,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              child: SizedBox(
                                  width: (itemSize[index] - 1).w,
                                  height: (itemSize[index] - 1).w,
                                  child: cheerUpList[index] == ''
                                      ? Image.network(
                                          IconPath.nuuzDefaultImage,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          cheerUpList[index] ?? IconPath.nuuzDefaultImage,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: (itemSize[index]).h,
                        child: Image.asset(
                          IconPath.cheerUpHeart,
                          width: itemSize[index] - 10,
                        ),
                      )
                    ],
                  )),
            ));
      },
    );
  }
}

final animationStateProvider = StateNotifierProvider<AnimationStateProvider, bool>((ref) {
  return AnimationStateProvider();
});

class AnimationStateProvider extends StateNotifier<bool> {
  AnimationStateProvider() : super(false);

  animationStart() => state = true;

  animationEnd() => state = false;
}

final userCheerUpProvider = StateNotifierProvider<UserCheerUpProvider, List<String?>>((ref) {
  return UserCheerUpProvider();
});

class UserCheerUpProvider extends StateNotifier<List<String?>> {
  UserCheerUpProvider() : super([null, null, null, null, null, null, null, null, null, null, null, null]);
  List<String> defaultImageList = [
    IconPath.cheerUp01,
    IconPath.cheerUp02,
    IconPath.cheerUp03,
    IconPath.cheerUp04,
    IconPath.cheerUp05,
    IconPath.cheerUp06,
    IconPath.cheerUp07,
    IconPath.cheerUp08,
    IconPath.cheerUp09,
    IconPath.cheerUp10,
    IconPath.nuuzDefaultImage,
    IconPath.nuuzDefaultImage
  ];

  ///이미지의 리스트를 만든다.
  setImage(int index, String imageUrl) {
    state[index] = imageUrl;
  }

  cheerUpSetting() {
    safePrint('응원하기 세팅 시작');
    for (int i = 0; i < 12; i++) {
      if (state[i] == null) {
        state[i] = defaultImageList[i];
      }
      safePrint('$i 번째 이미지');
      safePrint(state[i].toString());
    }
  }
}
