import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/modules/connection/connection/bluetooth_item.dart';
import 'package:nuuz/modules/connection/connection_controller/bluetooth_controller.dart';
import 'package:nuuz/modules/connection/connection_controller/mynuuz_controller.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

Future<void> showConnection(context) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Stack(
              children: [
                SizedBox(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ConnectHead(),
                            Column(
                              children: [hSize(17.h), const ConnectedList(), connectableList(context)],
                            ),
                            connectFoot(context)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                loadingScreen(),
              ],
            );
          },
        );
      });
}

class ConnectHead extends ConsumerStatefulWidget {
  const ConnectHead({Key? key}) : super(key: key);

  @override
  ConsumerState<ConnectHead> createState() => _ConnectHeadState();
}

class _ConnectHeadState extends ConsumerState<ConnectHead> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final connect = ref.watch(connectProvider);
    final mynuuzController = ref.watch(mynuuzProvider.notifier);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(IconPath.close)),
            Text('Blue_Tooth_0001'.tr(), style: CustomTextStyle.headerM),
            wSize(48.w),
          ],
        ),
        hSize(20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Container(
            height: 1.h,
            color: CustomColor.grayLine,
          ),
        ),
      ],
    );
  }
}

class ConnectedList extends ConsumerStatefulWidget {
  const ConnectedList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConnectedList> createState() => _ConnectedListState();
}

class _ConnectedListState extends ConsumerState<ConnectedList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final connectionController = ref.watch(connectProvider.notifier);
      // connectionController.initConnection();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final isConnected = ref.watch(connectProvider);
        final successConnect = ref.listen(connectProvider, (previous, next) {
          if (next != null) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
          }
        });
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Blue_Tooth_0002'.tr(), style: CustomTextStyle.headerS),
            hSize(12),
            isConnected == null
                ? Container(
                    width: 350.w,
                    height: 105.h,
                    decoration: BoxDecoration(color: CustomColor.lightGray, borderRadius: const BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      children: [
                        hSize(22),
                        SvgPicture.asset(
                          IconPath.noData,
                          color: CustomColor.lightDark,
                        ),
                        hSize(13),
                        Text(
                          'Blue_Tooth_0003'.tr(),
                          style: CustomTextStyle.descriptionS.copyWith(color: CustomColor.lightDark),
                        ),
                      ],
                    ),
                  )
                : StreamBuilder(
                    stream: isConnected.state,
                    builder: (s, snapshot) {
                      return ConnectedItem(snapshot.data == BluetoothDeviceState.connected);

                      // Text(snapshot.data.toString());
                    }),

            // const ConnectedItem(),
            hSize(20),
          ],
        );
      },
    );
  }
}

Widget connectableList(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Blue_Tooth_0004'.tr(), style: CustomTextStyle.headerS),
      Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final isLoading = ref.watch(scanProvider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBluePlus.instance.scanResults,
                initialData: const [],
                builder: (c, snapshot) => SizedBox(
                  height: 280.h,
                  child: isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 57.h,
                              decoration: BoxDecoration(color: CustomColor.lightGray, borderRadius: const BorderRadius.all(Radius.circular(12))),
                              child: Row(
                                children: [
                                  wSize(8),
                                  Container(
                                    width: 164.w,
                                    height: 41.h,
                                    decoration:
                                        BoxDecoration(color: CustomColor.greyContainer, borderRadius: const BorderRadius.all(Radius.circular(12))),
                                  ),
                                  wSize(41),
                                  Container(
                                    width: 40.w,
                                    height: 41.h,
                                    decoration:
                                        BoxDecoration(color: CustomColor.greyContainer, borderRadius: const BorderRadius.all(Radius.circular(12))),
                                  ),
                                  wSize(8),
                                  Container(
                                    width: 81.w,
                                    height: 41.h,
                                    decoration: BoxDecoration(color: CustomColor.white, borderRadius: const BorderRadius.all(Radius.circular(12))),
                                  ),
                                ],
                              ),
                            ),
                            CustomIndicator('Blue_Tooth_0008'.tr()),
                          ],
                        )
                      : ListView(
                          shrinkWrap: true,
                          children: snapshot.data!
                              .map(
                                (r) => BluetoothItem(
                                  result: r,
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}

Widget connectFoot(BuildContext context) {
  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final bluetoothController = ref.watch(scanProvider.notifier);
      final isLoading = ref.watch(scanProvider);
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: GestureDetector(
              onTap: () {
                bluetoothController.startScan(4);
              },
              child: isLoading
                  ? hSize(44)
                  : Container(
                      height: 44.h,
                      width: double.infinity,
                      decoration: BoxDecoration(color: CustomColor.primary, borderRadius: BorderRadius.circular(14)),
                      child: Center(child: Text('Blue_Tooth_0006'.tr(), style: CustomTextStyle.buttonM.copyWith(color: CustomColor.white))),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 2.w),
            child: Column(
              children: [
                Text('Blue_Tooth_0007'.tr(), textAlign: TextAlign.center, style: CustomTextStyle.descriptionS.copyWith(fontSize: 12.sp)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 13),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 44.h,
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(14)), border: Border.all(color: CustomColor.dark)),
                child: Center(
                  child: Text('Comm_Gene_0013'.tr(), style: CustomTextStyle.buttonM),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
