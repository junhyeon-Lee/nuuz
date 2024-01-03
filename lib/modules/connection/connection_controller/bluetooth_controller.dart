import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as bp;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/util/log_print.dart';

final scanProvider = StateNotifierProvider<ScanProvider, bool>((ref) {
  return ScanProvider();
});

class ScanProvider extends StateNotifier<bool> {
  ScanProvider() : super(false);

  Future<void> startScan(int time) async {
    List<bp.BluetoothDevice> connectedDevices = [];
    connectedDevices = await bp.FlutterBluePlus.instance.connectedDevices.whenComplete(() {
      safePrint('연결된 장비');
      safePrint(connectedDevices);
      for (int i = 0; i < connectedDevices.length; i++) {
        connectedDevices[i].disconnect();
      }
    });

    state = true;
    await bp.FlutterBluePlus.instance.stopScan();
    safePrint("startScan=====================>");
    await bp.FlutterBluePlus.instance.startScan(
      timeout: Duration(seconds: time),
      withServices: [bp.Guid('0000fff0-0000-1000-8000-00805f9b34fb')],
    );
    await bp.FlutterBluePlus.instance.stopScan();
    safePrint('<=====================scan finish');
    state = false;
  }
}

final connectProvider = StateNotifierProvider<ConnectProvider, bp.BluetoothDevice?>((ref) {
  return ConnectProvider();
});

class ConnectProvider extends StateNotifier<bp.BluetoothDevice?> {
  ConnectProvider() : super(null);
  List uuidList = [];
  List<bp.BluetoothDevice> connectedDevices = [];

  ///블루투스 연결
  connecting(bp.ScanResult result) async {
    for(int i=0; i<10; i++){
      bool check = false;
      if(result.device.name=='nuuzme'){
        await Future.delayed(const Duration(seconds: 1));
         check = await connect(result);
        await Future.delayed(const Duration(seconds: 1));
      }
      if(check){
        break;
      }
    }
  }
  Future<bool> connect(bp.ScanResult result) async {
    ///기존 연결된 장비를 모두 제거한다.
    // connectedDevices = await bp.FlutterBluePlus.instance.connectedDevices.whenComplete(() {
    //   safePrint(connectedDevices);
    //   for (int i = 0; i < connectedDevices.length; i++) {
    //     connectedDevices[i].disconnect();
    //   }
    // });

    Future.delayed(const Duration(seconds: 1));
    try {
      await result.device.connect(timeout: const Duration(seconds: 4), autoConnect: false);
      return true;
    } catch (e) {
      safePrint('bluetooth 연결 중 에러 발생');
      safePrint('catch $e');
      safePrint('false');
      return false;
    }
  }

  Future<void> checkConnect() async {
    connectedDevices = await bp.FlutterBluePlus.instance.connectedDevices;
    safePrint('연결된 장비를 찾았습니다.');
    for(int i=0; i<connectedDevices.length; i++){
      if(connectedDevices[i].name=="nuuzme"){
        safePrint(connectedDevices[i].name);
        safePrint(connectedDevices[i].id);
        state = connectedDevices[i];
        safePrint(state?.name??"이름");
        safePrint(state?.id??"아이디");
      }
    }


  }




  ///블루투스 연결끊기
  disconnect() async {
    await state!.disconnect();
    state = null;
  }

  ///이니셜 커넥트
  Future<void> initConnection() async {
    final connect = await bp.FlutterBluePlus.instance.connectedDevices;
    safePrint(connect);
    for (int i = 0; i < connect.length; i++) {
      if (connect[i].id.toString() == 'FD48F266-F011-2CB2-2D71-66588CED191F') {
        state = connect[i];
      }
    }
  }
}

final connectedStateProvider = StateNotifierProvider<ConnectedStateProvider, bool?>((ref) {
  return ConnectedStateProvider();
});

class ConnectedStateProvider extends StateNotifier<bool?> {
  ConnectedStateProvider() : super(null);

  List<bp.BluetoothService?> discover = [];
  late bp.BluetoothService service;
  late bp.BluetoothCharacteristic characteristic;

  // Future<void> getBluetoothDate() async {
  //   await characteristic.setNotifyValue(true);
  //   characteristic.value.listen((value) {
  //     if (state != ascii.decode(value)) {
  //       state = ascii.decode(value);
  //     }
  //   });
  // }

  Future<void> discoverService(bp.BluetoothDevice device) async {
    safePrint('discover start...');
    discover = await device.discoverServices();
    for (int i = 0; i < discover.length; i++) {
      if (discover[i]!.uuid.toString() == '0000fff0-0000-1000-8000-00805f9b34fb') {
        service = discover[i]!;
        for (int i = 0; i < service.characteristics.length; i++) {
          if (service.characteristics[i].uuid.toString() == '0000fff1-0000-1000-8000-00805f9b34fb') {
            characteristic = service.characteristics[i];
          }
        }
      }
    }
  }



}
