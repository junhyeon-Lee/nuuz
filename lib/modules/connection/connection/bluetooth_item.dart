import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/modules/connection/connection_controller/bluetooth_controller.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import '../../nuzz_care/care_program/care_program_controller.dart';
import '../connection_controller/mynuuz_controller.dart';

class BluetoothItem extends ConsumerWidget {
  const BluetoothItem({Key? key, required this.result}) : super(key: key);
  final ScanResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionController = ref.watch(connectProvider.notifier);
    final connectedDevice = ref.watch(connectProvider);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 52.h,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(14)), color: CustomColor.grayLine),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 19),
                  if (result.rssi > -65) SvgPicture.asset(IconPath.connectH),
                  if (result.rssi > -75 && result.rssi <= -65) SvgPicture.asset(IconPath.connectM),
                  if (result.rssi > -80 && result.rssi <= -75) SvgPicture.asset(IconPath.connectMR),
                  if (result.rssi <= -80) SvgPicture.asset(IconPath.connectR),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160.w,
                    child: Text(
                      result.device.name.toString() == '' ? result.device.id.toString() : result.device.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  ref.watch(loadingProvider.notifier).isLoadingTrue();
                  try{
                    if (Platform.isIOS) {
                      await Future.delayed(const Duration(seconds: 1));
                    }
                    await connectionController.connecting(result);
                    await connectionController.checkConnect();
                    await Future.delayed(const Duration(seconds: 1));
                    final connectDev = ref.watch(connectProvider);
                    ///이거 열면 ios 난리남
                    //await ref.watch(scanProvider.notifier).startScan(1);
                    await ref.watch(mynuuzProvider.notifier).discoverService(connectDev!);
                    ref.watch(mynuuzProvider.notifier).getBluetoothDate();
                  }catch(e){
                    safePrint(e);
                  }
                  ref.watch(loadingProvider.notifier).isLoadingFalse();
                },
                child: Container(
                  width: 120.w,
                  height: 44.h,
                  decoration: BoxDecoration(border: Border.all(color: CustomColor.dark), borderRadius: const BorderRadius.all(Radius.circular(14))),
                  child: Center(
                    child: Text('Blue_Tooth_0005'.tr(), style: CustomTextStyle.buttonM),
                  ),
                ),
              )
            ],
          ),
        ),
        hSize(4)
      ],
    );
  }
}

class ConnectedItem extends ConsumerWidget {
  const ConnectedItem(
    this.connected, {
    Key? key,
  }) : super(key: key);

  final bool connected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectedDevice = ref.watch(connectProvider);
    final connectionController = ref.watch(connectProvider.notifier);
    return SizedBox(
      height: 105.h,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 53.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(14)), color: CustomColor.lightGray),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 19),
                    SvgPicture.asset(
                      IconPath.connectH,
                      color: connected ? CustomColor.blue : CustomColor.gray,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(connectedDevice!.name!, style: Theme.of(context).textTheme.headlineSmall),
                        connected
                            ? Text('Connected', style: CustomTextStyle.descriptionM)
                            : Text('Disconnected', style: CustomTextStyle.descriptionM)
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      connectionController.disconnect();
                      ref.watch(scanProvider.notifier).startScan(1);
                    },
                    child: Container(
                      width: 112.w,
                      height: 34.h,
                      decoration: BoxDecoration(color: CustomColor.red.withOpacity(0.1), borderRadius: const BorderRadius.all(Radius.circular(18))),
                      child: Center(
                        child: connected
                            ? Text('Blue_Tooth_0009'.tr(), style: CustomTextStyle.nicknameM.copyWith(color: CustomColor.red))
                            : Text('Blue_Tooth_0005'.tr(), style: CustomTextStyle.nicknameM.copyWith(color: CustomColor.red)),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
