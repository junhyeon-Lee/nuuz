import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:yaml/yaml.dart';

///app version check
final deviceInfoProvider = StateNotifierProvider<DeviceInfoProvider, String>((ref) {
  return DeviceInfoProvider();
});

class DeviceInfoProvider extends StateNotifier<String> {
  DeviceInfoProvider() : super('');

  getAppVersion() async {
    safePrint('app version check....');
    await rootBundle.loadString("pubspec.yaml").then((yamlValue) {
      var yaml = loadYaml(yamlValue);
      safePrint(yaml['version']);
      state = yaml['version'];
    });
    safePrint('app version check complete!');
  }
}
