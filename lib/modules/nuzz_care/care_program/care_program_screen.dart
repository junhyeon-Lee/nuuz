import 'dart:io';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/cheer_up_animation.dart';
import 'package:nuuz/modules/connection/connection/connection_bottomsheet.dart';
import 'package:nuuz/modules/connection/connection_controller/bluetooth_controller.dart';
import 'package:nuuz/modules/connection/connection_controller/mynuuz_controller.dart';
import 'package:nuuz/modules/home/nuuz_home/cheer_up_widget.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/face_detection_ios/arkit_screen_2mm.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/care_guide_path.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:rive/rive.dart' as rive;

import 'face_detection_ios/arkit_screen.dart';

class CareProgramScreen extends ConsumerStatefulWidget {
  const CareProgramScreen({Key? key, required this.initialPart}) : super(key: key);

  final String initialPart;

  @override
  ConsumerState<CareProgramScreen> createState() => _CareProgramScreenState();
}

class _CareProgramScreenState extends ConsumerState<CareProgramScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final connectedDevice = ref.watch(connectProvider);
      Future.delayed(const Duration(seconds: 1), () {
        guideShow();
      });
      Future.delayed(const Duration(seconds: 2), () {
        faceGuideShow(10);
      });
      await ref.watch(mynuuzProvider.notifier).discoverService(connectedDevice!);

      final cheerUpImageList = ref.watch(myCheerUpGetProvider.notifier).cheerUpImageList;
      for(int i=0; i<cheerUpImageList.length; i++){
        ref.watch(userCheerUpProvider.notifier).setImage(i, cheerUpImageList[i]);
      }


      ref.watch(userCheerUpProvider.notifier).cheerUpSetting();
      ref.watch(mynuuzProvider.notifier).getBluetoothDate();
      careUserId = ref.watch(careIdProvider);
    });
    super.initState();
  }

  String careUserId = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isFixAnimation = ref.watch(uiVisibleProvider);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isAnimated = true;
      });
    });
    if (isFixAnimation == false) {
      Future.delayed(const Duration(seconds: 6), () {
        setState(() {
          isAnimated = false;
        });
      });
    }

    setState(() {});
  }

  Future<void> guideShow() async {
    setState(() {
      isGuide = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isGuide = false;
      });
    });
  }

  Future<void> faceGuideShow(int time) async {
    final isFixAnimation = ref.watch(uiVisibleProvider);
    setState(() {
      isFaceGuide = true;
    });
    if (isFixAnimation == false) {
      Future.delayed(Duration(seconds: time), () {
        setState(() {
          isFaceGuide = false;
        });
      });
    }
  }

  bool isAnimated = false;
  bool isFaceGuide = false;
  bool faceGuide = true;

  bool isGuide = false;
  int timer = 0;
  bool twommStart = true;
  int loop = 0;
  bool loopState = true;

  @override
  Widget build(BuildContext context) {
    late rive.RiveAnimationController riveController;
    const String viewType = '<platform-view-type>';
    final careProgramId = ref.watch(careIdProvider);
    final careController = ref.watch(partGroupProvider.notifier);
    final Map<String, dynamic> creationParams = <String, dynamic>{"region": widget.initialPart};
    final program = ref.watch(careProgramProvider);
    final shot = careController.shot;
    final maxShot = careController.maxShot;
    final cartridge = careController.nowCartridge;
    final battery = ref.watch(batteryProvider);
    final remainCartridge = ref.watch(cartridgeProvider);
    final totalCartridge = ref.watch(totalCartridgeProvider);
    final cartridgeType = ref.watch(cartridgeTypeProvider);
    final userCareId = ref.watch(userCareIdProvider);
    safePrint(userCareId);
    String nowPart = widget.initialPart;
    int nowLine = 1;
    final data = ref.listen(mynuuzProvider, (previous, next) async {
      ref.watch(cartridgeProvider.notifier).cartridgeState(next.substring(5, 11));
      ref.watch(shotProvider.notifier).shotState(next.substring(19, 25));
      ref.watch(batteryProvider.notifier).batteryState(next.substring(26, 29));
      ref.watch(totalCartridgeProvider.notifier).totalCartridgeState(next.substring(12, 18));
      ref.watch(cartridgeTypeProvider.notifier).cartridgeTypeState(next.substring(3, 4));


      if (careController.nowCartridge == '3mm') {
        String data = ref.watch(partGroupProvider.notifier).shotData3mm();

        ///가이드 이미지 변경
        nowPart = ref.watch(partGroupProvider.notifier).programGuide[ref.watch(partGroupProvider.notifier).partIndex].name ?? "";
        nowLine = ref.watch(partGroupProvider.notifier).line ?? 0;
        ref.watch(guildImageProvider.notifier).setGuideImage(nowPart, nowLine);
        ref.watch(guideAnimationProvider.notifier).setGuideImage(nowPart);
        ref.watch(deviceAnimationProvider.notifier).setDeviceGuideImage(nowPart);

        safePrint(data);
        if (data == 'done') {
          safePrint(userCareId);
          //MessageChannelTool.transformData(CloseParam());
          context.pushNamed('care-result-shoot', queryParams: {
            "care_program_id": careProgramId,
            "user_care_program_id": userCareId,
          });
        }

        if (data.substring(data.length - 12) == 'line:1shot:1'||data.substring(data.length - 12) == 'line:1shot:2') {
          guideShow();
          Future.delayed(const Duration(seconds: 2), () {
            faceGuideShow(10);
          });

        } else if (data.substring(data.length - 6) == 'shot:1'||data.substring(data.length - 6) == 'shot:2') {
          faceGuideShow(5);
        }
        if (ref.watch(partGroupProvider.notifier).cartridge) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Stack(
                      children: [
                        Positioned(
                          top: 115.h,
                          left: 20.w,
                          child: GestureDetector(
                            onTap: () {
                              context.pop();
                            },
                            child: CustomContainer(
                              width: 350.w,
                              height: 420.h,
                              radius: 10,
                              containerColor: Colors.white.withOpacity(0.8),
                              child: Column(
                                children: [
                                  hSize(24),
                                  Text(
                                    "Care_Prog_0004".tr(),
                                    style: CustomTextStyle.headerL,
                                  ),
                                  hSize(20),
                                  CustomContainer(
                                    width: 300.w,
                                    height: 40.h,
                                    radius: 6,
                                    containerColor: CustomColor.darkWhite,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomContainer(
                                          width: 110.w,
                                          height: 24.h,
                                          radius: 5,
                                          containerColor: const Color(0xffd9d9d9),
                                          child: Center(
                                              child: Text(
                                            '3mm',
                                            style: CustomTextStyle.buttonM,
                                          )),
                                        ),
                                        wSize(15),
                                        SvgPicture.asset(
                                          IconPath.cartridgeChangeIcon,
                                          color: CustomColor.dark,
                                          width: 14.w,
                                          height: 14.h,
                                        ),
                                        wSize(15),
                                        CustomContainer(
                                          width: 110.w,
                                          height: 24.h,
                                          radius: 5,
                                          containerColor: const Color(0xffd9d9d9),
                                          child: Center(
                                              child: Text(
                                            '2mm',
                                            style: CustomTextStyle.buttonM,
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  hSize(14),
                                  Image.asset(
                                    IconPath.cartridgeChange,
                                    width: 300.w,
                                  ),
                                  hSize(11),
                                  SizedBox(
                                      width: 280.w,
                                      child: Text(
                                        "Care_Prog_0005".tr(),
                                        style: CustomTextStyle.descriptionM,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
          await Future.delayed(const Duration(seconds: 4), () {
            context.pop();
          });
          guideShow();
        }
        setState(() {});
      }
    });
    int cartridge1 = 0;
    int totalCartridge1 = 0;
    cartridge1 = int.parse(ref.watch(cartridgeProvider));
    totalCartridge1 = int.parse(ref.watch(totalCartridgeProvider));

    ///애니메이션
    final isFixAnimation = ref.watch(uiVisibleProvider);
    final fixAnimation = ref.listen(uiVisibleProvider, (previous, next) {
      if (next) {
        isAnimated = true;
        isFaceGuide = true;
      } else {
        isAnimated = false;
        isFaceGuide = false;
      }
    });

    return WillPopScope(
      onWillPop: () async => exitBottomSheet(context),
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
              isAnimated = true;
              isFaceGuide = true;
              setState(() {});
              Future.delayed(const Duration(seconds: 2), () {
                if (isFixAnimation == false){
                  isAnimated = false;
                  isFaceGuide = false;
                }
                setState(() {});
              });
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [

                Container(color: CustomColor.dark,),

                if(Platform.isAndroid)
                  AndroidView(
                  viewType: viewType,
                  layoutDirection: ui.TextDirection.ltr,
                  creationParams: creationParams,
                  creationParamsCodec: const StandardMessageCodec(),
                ),
                if(Platform.isIOS)
                  cartridge == '3mm'?const ArkitScreen():const ArkitScreen2mm(),

                ///face guide
                Positioned(
                  top: 131.h,
                  child: AnimatedOpacity(
                    opacity:  isFaceGuide? 1 : 0,
                    duration: const Duration(seconds: 2),
                    child: Stack(alignment: Alignment.topCenter,
                      children: [
                        if(ref.watch(deviceAnimationProvider)!='else')
                          SizedBox(
                            width: 390.w,
                            height: 530.h,
                            child: rive.RiveAnimation.asset(
                            ref.watch(deviceAnimationProvider),
                              fit: BoxFit.fitWidth,
                            )),
                        SizedBox(
                          width: 390.w,
                          height: 530.h,
                          child: SvgPicture.asset(
                            ref.watch(guildImageProvider),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned.fill(
                          child: SizedBox(
                              width: 390.w,
                              height: 530.h,
                              child: rive.RiveAnimation.asset(
                                ref.watch(guideAnimationProvider),
                                fit: BoxFit.fitWidth,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

                ///top left widget
                AnimatedPositioned(
                  top: 55.h,
                  left: isAnimated ? 16.w : -170.w,
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 170.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 28.h,
                                child: battery == '004'
                                    ? Image.asset(IconPath.battery1)
                                    : battery == '003'
                                        ? Image.asset(IconPath.battery2)
                                        : battery == '002'
                                            ? Image.asset(IconPath.battery3)
                                            : battery == '001'
                                                ? Image.asset(IconPath.battery4)
                                                : Image.asset(IconPath.battery5)),
                            Container(
                              width: 98.w,
                              height: 28.h,
                              decoration:
                                  BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), color: Colors.black.withOpacity(0.4)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(IconPath.scanner),
                                    Text(
                                      '${cartridgeType}mm',
                                      style: CustomTextStyle.headerXS.copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSize(8),
                      Container(
                        width: 170.w,
                        height: 28.h,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), color: Colors.black.withOpacity(0.4)),
                        child: Row(
                          children: [
                            wSize(16),
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                final connectedDevice = ref.watch(connectProvider);
                               final bluetoothIcon = ref.watch(bluetoothIconProvider);
                                connectedDevice?.state.listen((state) {
                                  if (state == BluetoothDeviceState.connected) {
                                    ref.watch(bluetoothIconProvider.notifier).stateConnected();
                                  } else {
                                    ref.watch(bluetoothIconProvider.notifier).stateDisconnected();
                                  }
                                });
                                ref.listen(bluetoothIconProvider, (previous, next) {
                                  safePrint('블루투스 연결상태');
                                  safePrint(next);
                                  if (next == IconPath.connectD) {
                                    showConnection(context);
                                  }
                                });
                                return SvgPicture.asset(bluetoothIcon);
                              },
                            ),
                            wSize(12),
                            Text(
                              'nuuz me',
                              style: CustomTextStyle.headerXS.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      hSize(8),
                      Container(
                        width: 170.w,
                        height: 28.h,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), color: Colors.black.withOpacity(0.4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  width: 170 / totalCartridge1.toDouble() * cartridge1.toDouble().w,
                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), color: CustomColor.primary),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Text(
                                    '$remainCartridge / $totalCartridge',
                                    // '$cartridge / $totalCartridge',
                                    style: CustomTextStyle.headerXS.copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ///top right widget
                AnimatedPositioned(
                  top: isAnimated ? 55.h : -110,
                  right: 16.w,
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          settingBottomSheet(context);
                        },
                        child: Container(
                          width: 36.w,
                          height: 36.h,
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(
                              IconPath.setting,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      hSize(12),
                      Container(
                          constraints: BoxConstraints(
                            minWidth: 62.w,
                            minHeight: 62.h,
                          ),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Progress', style: CustomTextStyle.descriptionS.copyWith(color: Colors.white)),

                                  careController.nowCartridge == '2mm'
                                      ?  int.parse(ref.watch(shotProvider)??'000000')<10?
                                  Text(subOnCharecter(str: ref.watch(shotProvider)??"000000", from: 5, to: 6), style: CustomTextStyle.headerXS.copyWith(color: Colors.white)):
                                  int.parse(ref.watch(shotProvider)??'000000')<100?
                                  Text(subOnCharecter(str: ref.watch(shotProvider)??"000000", from: 4, to: 6,), style: CustomTextStyle.headerXS.copyWith(color: Colors.white)):
                                  int.parse(ref.watch(shotProvider)??'000000')<1000?
                                  Text(subOnCharecter(str: ref.watch(shotProvider)??"000000", from: 3, to: 6,), style: CustomTextStyle.headerXS.copyWith(color: Colors.white)):
                                  Text(subOnCharecter(str: ref.watch(shotProvider)??"000000", from: 2, to: 6,), style: CustomTextStyle.headerXS.copyWith(color: Colors.white))
                                      : Text('${careController.totalShot??0}/${careController.progress??0}',
                                      style: CustomTextStyle.headerXS.copyWith(color: Colors.white))

                            ],
                          )),
                    ],
                  ),
                ),

                ///shot widget
                AnimatedPositioned(
                  top: isAnimated ? 177.h : 55.h,
                  right: isAnimated ? 16.w : 25.w,
                  duration: const Duration(milliseconds: 200),
                  child: cartridge == ''
                      ? Container()
                      : AnimatedScale(
                          scale: isAnimated ? 1 : 1.4,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                              constraints: BoxConstraints(
                                minWidth: 62.w,
                                minHeight: 62.h,
                              ),
                              decoration:
                                  BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(15))),
                              child: cartridge == '3mm'
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Shot', style: CustomTextStyle.descriptionS.copyWith(color: Colors.white)),
                                        Text('$shot/${maxShot ?? '-'}', style: CustomTextStyle.headerXS.copyWith(color: Colors.white))
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Time', style: CustomTextStyle.descriptionM.copyWith(color: Colors.white)),
                                        Text('$timer', style: CustomTextStyle.headerXS.copyWith(color: Colors.white))
                                      ],
                                    )),
                        ),
                ),

                // if (careController.nowCartridge != '2mm')
                //   Positioned(
                //     top: 250.h,
                //     right: 16.w,
                //     child: GestureDetector(
                //       onTap: ()
                //       async {
                //         if (careController.nowCartridge == '3mm') {
                //
                //           String data = ref.watch(partGroupProvider.notifier).shotData3mm();
                //
                //           ///가이드 이미지 변경
                //           nowPart = ref.watch(partGroupProvider.notifier).programGuide[ref.watch(partGroupProvider.notifier).partIndex].name ?? "";
                //           nowLine = ref.watch(partGroupProvider.notifier).line ?? 0;
                //           ref.watch(guildImageProvider.notifier).setGuideImage(nowPart, nowLine);
                //           ref.watch(guideAnimationProvider.notifier).setGuideImage(nowPart);
                //           ref.watch(deviceAnimationProvider.notifier).setDeviceGuideImage(nowPart);
                //           safePrint(data);
                //           if (data == 'done') {
                //             safePrint('결과창 넘어가기전 유저 케어 아이디 확인');
                //             safePrint(userCareId);
                //             //MessageChannelTool.transformData(CloseParam());
                //             context.pushNamed('care-result-shoot', queryParams: {
                //               "care_program_id": careProgramId,
                //               "user_care_program_id": userCareId,
                //             });
                //           }
                //
                //
                //           safePrint('검증');
                //           safePrint(data.substring(data.length - 12)=='line:1shot:1');
                //           safePrint(data.substring(data.length - 12));
                //           if (data.substring(data.length - 12) == 'line:1shot:1'||data.substring(data.length - 12) == 'line:1shot:2') {
                //             safePrint('문제있음?');
                //             guideShow();
                //             Future.delayed(const Duration(seconds: 2), () {
                //               faceGuideShow(10);
                //             });
                //
                //           } else if (data.substring(data.length - 6) == 'shot:1'||data.substring(data.length - 6) == 'shot:2') {
                //             faceGuideShow(5);
                //           }
                //           if (ref.watch(partGroupProvider.notifier).cartridge) {
                //             showDialog(
                //                 context: context,
                //                 barrierDismissible: false,
                //                 builder: (BuildContext context) {
                //                   return WillPopScope(
                //                     onWillPop: () async => false,
                //                     child: Scaffold(
                //                       backgroundColor: Colors.transparent,
                //                       body: Stack(
                //                         children: [
                //                           Positioned(
                //                             top: 115.h,
                //                             left: 20.w,
                //                             child: GestureDetector(
                //                               onTap: () {
                //                                 context.pop();
                //                               },
                //                               child: CustomContainer(
                //                                 width: 350.w,
                //                                 height: 420.h,
                //                                 radius: 10,
                //                                 containerColor: Colors.white.withOpacity(0.8),
                //                                 child: Column(
                //                                   children: [
                //                                     hSize(24),
                //                                     Text(
                //                                       "Care_Prog_0004".tr(),
                //                                       style: CustomTextStyle.headerL,
                //                                     ),
                //                                     hSize(20),
                //                                     CustomContainer(
                //                                       width: 300.w,
                //                                       height: 40.h,
                //                                       radius: 6,
                //                                       containerColor: CustomColor.darkWhite,
                //                                       child: Row(
                //                                         mainAxisAlignment: MainAxisAlignment.center,
                //                                         children: [
                //                                           CustomContainer(
                //                                             width: 110.w,
                //                                             height: 24.h,
                //                                             radius: 5,
                //                                             containerColor: const Color(0xffd9d9d9),
                //                                             child: Center(
                //                                                 child: Text(
                //                                                   '3mm',
                //                                                   style: CustomTextStyle.buttonM,
                //                                                 )),
                //                                           ),
                //                                           wSize(15),
                //                                           SvgPicture.asset(
                //                                             IconPath.cartridgeChangeIcon,
                //                                             color: CustomColor.dark,
                //                                             width: 14.w,
                //                                             height: 14.h,
                //                                           ),
                //                                           wSize(15),
                //                                           CustomContainer(
                //                                             width: 110.w,
                //                                             height: 24.h,
                //                                             radius: 5,
                //                                             containerColor: const Color(0xffd9d9d9),
                //                                             child: Center(
                //                                                 child: Text(
                //                                                   '2mm',
                //                                                   style: CustomTextStyle.buttonM,
                //                                                 )),
                //                                           ),
                //                                         ],
                //                                       ),
                //                                     ),
                //                                     hSize(14),
                //                                     Image.asset(
                //                                       IconPath.cartridgeChange,
                //                                       width: 300.w,
                //                                     ),
                //                                     hSize(11),
                //                                     SizedBox(
                //                                         width: 280.w,
                //                                         child: Text(
                //                                           "Care_Prog_0005".tr(),
                //                                           style: CustomTextStyle.descriptionM,
                //                                         )),
                //                                   ],
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   );
                //                 });
                //             await Future.delayed(const Duration(seconds: 4), () {
                //               context.pop();
                //             });
                //             guideShow();
                //           }
                //           setState(() {});
                //         }
                //       },
                //       child: Container(
                //           width: 62.w,
                //           height: 62.h,
                //           decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: const BorderRadius.all(Radius.circular(15))),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text('Shooting', style: CustomTextStyle.descriptionM.copyWith(color: Colors.white)),
                //             ],
                //           )),
                //     ),
                //   ),

                ///bottom guide widget
                ///이거는 고정 위젯
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 390.w,
                    height: 346.h,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.83),
                      ],
                    )),
                    child: Column(
                      children: [
                        hSize(55),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: isGuide ? 0 : 100,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isGuide ? 1 : 0,
                          child: SizedBox(
                            height: 96.h,
                            width: 390.w,
                            child: PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: careController.programGuide.length,
                              controller: careController.guideController,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Opacity(
                                    opacity: index == careController.partIndex ? 1 : 0.5,
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        child: SizedBox(
                                            width: 96,
                                            height: 96.h,
                                            child: Image.network(
                                              careController.programGuide[index].image!,
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///cheerUp
                Positioned(
                  bottom: 0,
                  child: Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final visible = ref.watch(cheeringVisibleProvider);
                      return Visibility(visible: visible, child: const CheerUpAnimationScreen());
                    },
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    child: Container(
                        width: 390.w,
                        height: 156.h,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                        child: PageView.builder(
                          controller: ref.watch(partGroupProvider.notifier).pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                                            child: SizedBox(
                                              width: 96.h,
                                              height: 96.h,
                                              child: Image.network(careController.programGuide[index].image!),
                                            ),
                                          ),
                                        ],
                                      ),
                                      wSize(20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            careController.programGuide[index].title!.tr(),
                                            style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                                          ),
                                          hSize(10),
                                          SizedBox(
                                            width: 217.w,
                                            child: Text(
                                              careController.programGuide[index].description!.tr() ?? "",
                                              style: CustomTextStyle.descriptionS.copyWith(
                                                color: Colors.white.withOpacity(0.7),
                                              ),
                                            ),
                                          ),
                                          hSize(14),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: careController.programGuide.length,
                        )),
                  ),
                ),

                  if (twommStart)
                    if (careController.nowCartridge == '2mm')
                      Positioned.fill(
                       child: GestureDetector(
                           behavior: HitTestBehavior.translucent,
                         onTap:(){

                       },
                         child: Container(
                           color: Colors.black.withOpacity(0.5),
                           child: Center(
                             child: GestureDetector(
                                 onTap: () async {
                                   setState(() {
                                     safePrint('데이터 콜');
                                     safePrint(loop);
                                     twommStart = false;
                                     loopState = true;
                                   });

                                   timer = careController.shotCounter[0][0][0];

                                   setState(() {
                                     timer -= loop;
                                     safePrint('타이머 콜');
                                     safePrint(timer);
                                   });

                                   for (int i = loop; i < careController.shotCounter[0][0][0]; i++) {
                                     if (loopState == false) {
                                       setState(() {
                                         twommStart = true;
                                       });
                                       break;
                                     }
                                     await Future.delayed(const Duration(seconds: 1), () async {
                                       safePrint(i);
                                       String data = await ref.watch(partGroupProvider.notifier).shotData2mm(loop);
                                       nowPart =
                                           ref.watch(partGroupProvider.notifier).programGuide[ref.watch(partGroupProvider.notifier).partIndex].name ?? "";
                                       nowLine = ref.watch(partGroupProvider.notifier).line;
                                       ref.watch(guildImageProvider.notifier).setGuideImage(nowPart, nowLine);
                                       ref.watch(guideAnimationProvider.notifier).setGuideImage(nowPart);
                                       ref.watch(deviceAnimationProvider.notifier).setDeviceGuideImage(nowPart);

                                       if (data == 'next') {
                                         guideShow();
                                         Future.delayed(const Duration(seconds: 2), () {
                                           faceGuideShow(10);
                                         });
                                       }

                                       if (data == 'done') {
                                         safePrint('결과창 넘어가기전 유저 케어 아이디 확인');
                                         safePrint(userCareId);

                                         if (mounted) {
                                           context.pop();
                                           context.pop();
                                           context.pushNamed('care-result-shoot', queryParams: {
                                             "care_program_id": careProgramId,
                                             "user_care_program_id": userCareId,
                                           });
                                         }
                                       }
                                       loop++;
                                       setState(() {
                                         timer--;
                                       });
                                     });

                                     if (timer == 0) {
                                       loop = 0;
                                       break;
                                     }
                                   }
                                   setState(() {
                                     twommStart = true;
                                   });
                                 },
                                 child: Container(
                                   width: 100.w,
                                   height: 100.h,
                                   child: const rive.RiveAnimation.asset(
                                     IconPath.twommStart,
                                   ),
                                 )
                               //  const rive.RiveAnimation.asset(IconPath.saveInstagram,),

                             ),
                           ),
                         ),
                       )
                      ),

                if (twommStart == false)
                  if (careController.nowCartridge == '2mm')
                    Positioned(
                      top: 612.h,
                      right: 16.w,
                      child: GestureDetector(
                        onTap: () async {
                          loopState = false;
                        },
                        child: Image.asset(
                          IconPath.twommPause,
                          width: 56.w,
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  settingBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final uiVisible = ref.watch(uiVisibleProvider);
                final cheeringVisible = ref.watch(cheeringVisibleProvider);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 56.h,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0.w,
                            top: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    IconPath.closeIcon,
                                    width: 27.w,
                                  )),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Text(
                                'Blue_Tooth_0013'.tr(),
                                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CustomColor.dark),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0xffebeae9),
                    ),
                    hSize(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Care_Prog_0011'.tr(),
                              style: CustomTextStyle.nicknameM,
                            ),
                            hSize(6),
                            Text(
                              "Care_Prog_0012".tr(),
                              style: CustomTextStyle.iconS,
                            ),
                          ],
                        ),
                        FlutterSwitch(
                          width: 49.w,
                          height: 31.w,
                          toggleSize: 27.w,
                          value: uiVisible,
                          borderRadius: 15.5,
                          padding: 2.w,
                          activeToggleColor: CustomColor.white,
                          activeColor: CustomColor.primary,
                          inactiveColor: CustomColor.lightWhite,
                          toggleColor: CustomColor.dark,
                          onToggle: (val) {
                            ref.watch(uiVisibleProvider.notifier).changeState();
                          },
                        ),
                      ],
                    ),
                    hSize(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Care_Prog_0013'.tr(),
                              style: CustomTextStyle.nicknameM,
                            ),
                            hSize(6),
                            Text(
                              "Care_Prog_0014".tr(),
                              style: CustomTextStyle.iconS,
                            ),
                          ],
                        ),
                        FlutterSwitch(
                          width: 49.w,
                          height: 31.w,
                          toggleSize: 27.w,
                          value: cheeringVisible,
                          borderRadius: 15.5,
                          padding: 2.w,
                          activeToggleColor: CustomColor.white,
                          activeColor: CustomColor.primary,
                          inactiveColor: CustomColor.lightWhite,
                          toggleColor: CustomColor.dark,
                          onToggle: (val) {
                            ref.watch(cheeringVisibleProvider.notifier).changeState();
                          },
                        ),
                      ],
                    ),
                    hSize(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showConnection(context);
                          },
                          child: CustomContainer(
                            width: 168.w,
                            height: 44.h,
                            containerColor: CustomColor.dark,
                            radius: 13,
                            child: Center(
                              child: Text(
                                'Care_Prog_0015'.tr(),
                                style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        wSize(10),
                        GestureDetector(
                          onTap: () {
                            //context.pop();
                            exitBottomSheet(context);
                            // context.go('/main');
                          },
                          child: CustomContainer(
                            width: 168.w,
                            height: 44.h,
                            containerColor: CustomColor.primary,
                            child: Center(
                              child: Text(
                                'Care_Prog_0016'.tr(),
                                style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    hSize(17),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: CustomContainer(
                        width: double.infinity,
                        height: 44.h,
                        radius: 13,
                        borderColor: CustomColor.dark,
                        child: Center(
                          child: Text(
                            "Comm_Gene_0013".tr(),
                            style: CustomTextStyle.buttonM,
                          ),
                        ),
                      ),
                    ),
                    hSize(24)
                  ],
                );
              },
            ),
          );
        });
  }
}

exitBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 56.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 20.w,
                    top: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            IconPath.closeIcon,
                            width: 27.w,
                          )),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        'Comm_Gene_0005'.tr(),
                        style: CustomTextStyle.textStyle(fontWeight: FontWeight.w700, fontSize: 20, color: CustomColor.dark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              width: double.infinity,
              height: 1,
              color: const Color(0xffebeae9),
            ),
            hSize(44),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                'Care_Prog_0020'.tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 14, color: CustomColor.lightDark, height: 1.3),
              ),
            ),
            hSize(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: CustomContainer(
                    width: 120.w,
                    height: 44.h,
                    borderColor: CustomColor.dark,
                    radius: 13,
                    child: Center(
                      child: Text(
                        'Comm_Gene_0006'.tr(),
                        style: CustomTextStyle.buttonM,
                      ),
                    ),
                  ),
                ),
                wSize(12),
                GestureDetector(
                  onTap: () {
                    //MessageChannelTool.transformData(CloseParam());
                    context.go('/main');
                  },
                  child: CustomContainer(
                    width: 120.w,
                    height: 44.h,
                    containerColor: CustomColor.primary,
                    child: Center(
                      child: Text(
                        'Care_Prog_0021'.tr(),
                        style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            hSize(32)
          ],
        );
      });
}

final uiVisibleProvider = StateNotifierProvider<UiVisibleProvider, bool>((ref) {
  return UiVisibleProvider();
});

class UiVisibleProvider extends StateNotifier<bool> {
  UiVisibleProvider() : super(false);

  changeState() => state ? state = false : state = true;
}

final cheeringVisibleProvider = StateNotifierProvider<CheeringVisibleProvider, bool>((ref) {
  return CheeringVisibleProvider();
});

class CheeringVisibleProvider extends StateNotifier<bool> {
  CheeringVisibleProvider() : super(false);

  changeState() => state ? state = false : state = true;
}

final bluetoothIconProvider = StateNotifierProvider<BluetoothIconProvider, String>((ref) {
  return BluetoothIconProvider();
});

class BluetoothIconProvider extends StateNotifier<String> {
  BluetoothIconProvider() : super(IconPath.connectH);

  stateConnected() {
    state = IconPath.connectH;
  }

  stateDisconnected() {
    state = IconPath.connectD;
  }
}


subOnCharecter({required String str, required int from, required int to}) {
  var runes = str.runes.toList();
  String result = '';
  for (var i = from; i < to; i++) {
    result = result + String.fromCharCode(runes[i]);
  }
  return result;
}