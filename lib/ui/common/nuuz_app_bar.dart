import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/modules/connection/connection/connection_bottomsheet.dart';
import 'package:nuuz/modules/connection/connection_controller/bluetooth_controller.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class NuuzAppBar extends AppBar implements PreferredSizeWidget {
  NuuzAppBar({super.key, required BuildContext context, required int index, Function()? onSearchCallBack})
      : super(
          backgroundColor: Colors.transparent,
          title: index == 0
              ? Image.asset(
                  IconPath.logo,
                  height: 20,
                )
              : index == 1
                  ? Text(
                      'Comm_Gene_0023'.tr(),
                      style: CustomTextStyle.headerL,
                    )
                  : index == 2
                      ? Text(
                          'Comm_Gene_0014'.tr(),
                          style: CustomTextStyle.headerL,
                        )
                      : index == 3
                          ? Text(
                              'Comm_Gene_0024'.tr(),
                              style: CustomTextStyle.headerL,
                            )
                          : Text(
                              'Comm_Gene_0011'.tr(),
                              style: CustomTextStyle.headerL,
                            ),
          centerTitle: true,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset(IconPath.drawerIcon));
          }),
          actions: [
            if (index == 0 || index == 1 || index == 2)
              Ink(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: CustomColor.blue,
                ),
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    final connectedDevice = ref.watch(connectProvider);
                    return IconButton(
                      onPressed: () {
                        showConnection(context);
                      },
                      icon: connectedDevice == null
                          ? SvgPicture.asset(IconPath.homeBluetooth)
                          : StreamBuilder(
                              stream: connectedDevice.state,
                              builder: (s, snapshot) {
                                return snapshot.data == BluetoothDeviceState.connected
                                    ? SvgPicture.asset(IconPath.homeBluetoothOn)
                                    : SvgPicture.asset(IconPath.homeBluetooth);

                                // Text(snapshot.data.toString());
                              }),
                    );
                  },
                ),
              ),
            // if (index == 1)
            //   Ink(
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       // color: CustomColor.blue,
            //     ),
            //     child: IconButton(
            //         onPressed: () {
            //           context.goNamed('/gallery');
            //         },
            //         icon: SvgPicture.asset(IconPath.gallery)),
            //   ),
            if (index == 3)
              Ink(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: CustomColor.blue,
                ),
                child: IconButton(
                    onPressed: () {
                      onSearchCallBack?.call();
                    },
                    icon: SvgPicture.asset(IconPath.search)),
              ),
            if (index == 4)
              Ink(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: CustomColor.blue,
                ),
                child: IconButton(
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://nuuz.cafe24.com/',
                      );
                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        // ignore: avoid_print
                      }
                    },
                    icon: SvgPicture.asset(IconPath.shop)),
              ),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: SvgPicture.asset(IconPath.gift));
            })
          ],
        );

  @override
  Size get preferredSize => Size.fromHeight(Platform.isAndroid ? 58.h : 44.h);
}
