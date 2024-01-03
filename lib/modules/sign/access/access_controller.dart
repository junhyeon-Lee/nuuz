import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:permission_handler/permission_handler.dart';

final accessProvider = StateNotifierProvider<AccessProvider, bool?>((ref) {
  return AccessProvider();
});

class AccessProvider extends StateNotifier<bool?> {
  AccessProvider() : super(null);

  Future<void> permissionHandle() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.notification,
    ].request();
    permissionCheck();
  }

  Future<void> permissionCheck() async {
    safePrint('권한허용 확인 시작');
    state = null;
    safePrint('permission_check_run');
    var photoStatus = await Permission.storage.status.isGranted;
    var cameraStatus = await Permission.camera.status.isGranted;
    var notification = await Permission.notification.status.isGranted;

    var bluetoothStatus;
    if (Platform.isAndroid) {
      bluetoothStatus = await Permission.bluetoothScan.isGranted;
    } else if (Platform.isIOS) {
      bluetoothStatus = await Permission.bluetooth.isGranted;
    }
    var bluetoothStatus2 = await Permission.bluetoothAdvertise.isGranted;
    var bluetoothStatus3 = await Permission.bluetoothConnect.isGranted;
    safePrint('now permission');
    safePrint('photoStatus: $photoStatus');
    safePrint('cameraStatus: $cameraStatus');
    safePrint('bluetoothStatus: $bluetoothStatus');
    safePrint('notification: $notification');
    /*
    safePrint('bluetoothStatus: $bluetoothStatus2');
    safePrint('bluetoothStatus: $bluetoothStatus3');*/
    if (notification) {
      photoStatus && cameraStatus && bluetoothStatus ? state = true : state = false;
    } else {
      state = false;
      if (Platform.isIOS) {
        state = true;
      }
    }
    safePrint('권한허용 확인 완료');
    safePrint(state);
  }

  Future<void> initPermissionCheck() async {
    safePrint('permission_check_run');
    var photoStatus = await Permission.storage.status.isGranted;
    var cameraStatus = await Permission.camera.status.isGranted;

    var bluetoothStatus;
    if (Platform.isAndroid) {
      bluetoothStatus = await Permission.bluetoothScan.isGranted;
    } else if (Platform.isIOS) {
      bluetoothStatus = await Permission.bluetooth.isGranted;
    }
    var bluetoothStatus2 = await Permission.bluetoothAdvertise.isGranted;
    var bluetoothStatus3 = await Permission.bluetoothConnect.isGranted;
    safePrint('now permission');
    safePrint('photoStatus: $photoStatus');
    safePrint('cameraStatus: $cameraStatus');
    safePrint('bluetoothStatus: $bluetoothStatus');
    /*
    safePrint('bluetoothStatus: $bluetoothStatus2');
    safePrint('bluetoothStatus: $bluetoothStatus3');*/

    photoStatus && cameraStatus && bluetoothStatus ? state = true : state = false;
  }
}
