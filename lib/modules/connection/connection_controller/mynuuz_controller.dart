import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///state.substring(3,4) Notified data
///state.substring(5,11) is Cartridge type
///state.substring(12,18) is remaining cartridge
///state.substring(19,25) is cartridge capacity
///state.substring(26,29) is number of uses
///state.substring(30,32) battery

final mynuuzProvider = StateNotifierProvider.autoDispose<MynuuzProvider, String>((ref) {
  return MynuuzProvider();
});
class MynuuzProvider extends StateNotifier<String> {
  MynuuzProvider() : super('00000000000');

  List<BluetoothService?> discover = [];
  late BluetoothService service;
  late BluetoothCharacteristic characteristic;

  Future<void> getBluetoothDate() async {
    await characteristic.setNotifyValue(true);
    characteristic.value.listen((value) {
      if (state.substring(5, 11) != ascii.decode(value).substring(5, 11)) {
        state = ascii.decode(value);
      }
    });
  }
  Future<void> discoverService(BluetoothDevice device) async {
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

final batteryProvider = StateNotifierProvider.autoDispose<BatteryProvider, String>((ref) {
  return BatteryProvider();
});
class BatteryProvider extends StateNotifier<String> {
  BatteryProvider() : super('004');
  batteryState(String value){
    if(state!=value){
      state = value;
    }
  }
}

final shotProvider = StateNotifierProvider.autoDispose<ShotProvider, String>((ref) {
  return ShotProvider();
});
class ShotProvider extends StateNotifier<String> {
  ShotProvider() : super('000000');
  shotState(String value){
    if(state!=value){
      state = value;
    }
  }
}

final cartridgeProvider = StateNotifierProvider.autoDispose<CartridgeProvider, String>((ref) {
  return CartridgeProvider();
});
class CartridgeProvider extends StateNotifier<String> {
  CartridgeProvider() : super('1');
  cartridgeState(String value){
    if(state!=value){
      state = value;
    }
  }
}

final totalCartridgeProvider = StateNotifierProvider.autoDispose<TotalCartridgeProvider, String>((ref) {
  return TotalCartridgeProvider();
});
class TotalCartridgeProvider extends StateNotifier<String> {
  TotalCartridgeProvider() : super('1');
  totalCartridgeState(String value){
    if(state!=value){
      state = value;
    }
  }
}

final cartridgeTypeProvider = StateNotifierProvider.autoDispose<CartridgeTypeProvider, String>((ref) {
  return CartridgeTypeProvider();
});
class CartridgeTypeProvider extends StateNotifier<String> {
  CartridgeTypeProvider() : super('3');
  cartridgeTypeState(String value){
    if(state!=value){
      state = value;
    }
  }
}





