![logo](./logo.png)

[![Codemagic build status](https://api.codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/status_badge.svg)](https://codemagic.io/apps/5cb0a01178f5790010ab6978/5cb0a01178f5790010ab6977/latest_build) [![flutter awesome](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://github.com/Solido/awesome-flutter)
[![pub package](https://img.shields.io/pub/v/arkit_plugin.svg)](https://pub.dartlang.org/packages/arkit_plugin)

**Note**: ARKit is only supported by mobile devices with A9 or later processors (iPhone 6s/7/SE/8/X, iPad 2017/Pro) on iOS 11 and newer. For some features iOS 12 or newer is required.

## Usage

### Depend on it

Follow the [installation instructions](https://pub.dartlang.org/packages/arkit_plugin#-installing-tab-) from Dart Packages site.

### Update Info.plist

ARKit uses the device camera, so do not forget to provide the `NSCameraUsageDescription`. You may specify it in `Info.plist` like that:
```xml
    <key>NSCameraUsageDescription</key>
    <string>Describe why your app needs AR here.</string>
```

### Update Podfile

At the top level of the `ios` folder uncomment the second line in the `Podfile` and change the iOS minimum version from `9.0` to the appropriate one.
The minimum supported iOS version is `11.0`, though if you need image anchors use `11.3`, for image tracking configuration or face tracking set `12.0`, and for body tracking minimum version must be `13.0`.

From:
```ruby
# platform :ios, '9.0'
```
To:

```ruby
platform :ios, '11.0'
```

NOTE: If when running for the first time you get a _cocoapods_ error, delete the `Podfile.lock` file in the `ios` folder. Open the `ios` folder in the terminal and run:
```
pod install
```

### Write the app

The simplest code example:

```dart
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('ARKit in Flutter')),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
        geometry: ARKitSphere(radius: 0.1), position: Vector3(0, 0, -0.5));
    this.arkitController.add(node);
  }
}
```
Result:

![flutter](./demo.gif)

## Examples

I would highly recommend to review the [sample](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/main.dart) from the `Example` folder inside the plugin. Some samples rely on [this Earth image](https://upload.wikimedia.org/wikipedia/commons/9/97/The_Earth_seen_from_Apollo_17.jpg)

| Name        | Description                                          | Link | Demo |
|-------------|------------------------------------------------------|------------------------------------------------------|----|
| Hello World | The simplest scene with different geometries.           | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/hello_world.dart)| [twitter](https://twitter.com/OlexaLe/status/1118441432707149824) |
| Check configuration | Shows which kinds of AR configuration are supported on the device | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/check_support_page.dart)|  |
| Earth       | Sphere with an image texture and rotation animation. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/earth_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1118441432707149824) |
| Tap         | Sphere which handles tap event.                      | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/tap_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1118441432707149824) |
| Midas         | Turns walls, floor, and Earth itself into gold by tap.                      | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/midas_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1401561106552967173) |
| Plane Detection | Detects horizontal plane. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/plane_detection_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1118870195743883266) |
| Distance tracking | Detects horizontal plane and track distance on it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/distance_tracking_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1121022506180149248) |
| Measure | Measures distances | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/measure_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1121022506180149248) |
| Physics | A sphere and a plane with dynamic and static physics                      | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/physics_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1119233047851884547) |
| Image Detection | Detects Earth photo and puts a 3D object near it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/image_detection_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1120287361974378496) |
| Network Image Detection | Detects Mars photo and puts a 3D object near it. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/network_image_detection.dart) | |
| Custom Light | Hello World scene with a custom light spot. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_light_page.dart) | |
| Light Estimation | Estimates and applies the light around you. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/light_estimate_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1120671744426221573) |
| Custom Object | Place custom object on plane with coaching overlay. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_object_page.dart) | [twitter](https://twitter.com/OlexaLe/status/1121037162852569090) |
| Occlusion | Spheres which are not visible after horizontal and vertical planes. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/occlusion_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1121421315364274177) |
| Manipulation | Custom objects with pinch and rotation events. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/manipulation_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1123893412279791616) |
| Face Tracking | Face mask sample. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/face_detection_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1143483440278454277) |
| Body Tracking | Dash that follows your hand. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/body_tracking_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1449408839393087494) |
| Panorama | 360 photo. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/panorama_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1154665277654781952) |
| Video | 360 video. | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/video_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1406997587132026885) |
| Custom Animation | Custom object animation. Port of https://github.com/eh3rrera/ARKitAnimation | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_animation_page.dart)|[twitter](https://twitter.com/OlexaLe/status/1173587705206366209) |
| Widget Projection | Flutter widgets in AR | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/widget_projection.dart)|[twitter](https://twitter.com/OlexaLe/status/1174678765592567814) |
| Real Time Updates | Calls a function once per frame | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/real_time_updates.dart)| |
| Snapshot | Make a photo of AR content | [code](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/snapshot_scene.dart)| |

If you prefer video here is a playlist with "AR in Flutter" videos:

[![AR in Flutter videos](https://img.youtube.com/vi/gOgCdl5_E7k/0.jpg)](https://www.youtube.com/watch?v=MaH4L6R8ZfQ&list=PLjaSBcAZ8TqGoWj3FE96uQ2gGPDGaXbDp "AR in Flutter videos")

## UX advice
You might want to check the device capabilities before establishing an AR session. Review the [Check Support](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/check_support_page.dart) sample for the implementation details.

If your app requires placing objects consider using coaching overlays. Review the [Custom Object](https://github.com/olexale/arkit_flutter_plugin/blob/master/example/lib/custom_object_page.dart) sample for the implementation details.

## Before you go to AppStore
The plugin supports TrueDepth API. In case you didn't use it, your app will be rejected by Apple. Hence you need to remove any TrueDepth functionality by modifying your `Podfile` file
```Ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      ... # Here are some configurations automatically generated by flutter

      config.build_settings['OTHER_SWIFT_FLAGS'] = '-DDISABLE_TRUEDEPTH_API'
    end
  end
end
```

## FAQ
- **Is it possible to use this plugin on Android?**  
No, as ARKit is not available on Android. You might want to try [ARCore plugin](https://pub.dev/packages/arcore_flutter_plugin) instead.
- **My app crashes when I open the AR scene several times. Why?**  
Most probably that's because you didn't call `dispose` method on the ARKit controller.
- **One of the features I need is merged in the repository, but is not available on pub.dev. How can I use the latest version?**  
You may use the latest version by changing the `pubspec.yaml` dependency to:
```yaml
dependencies:
  arkit_plugin:
    git: git://github.com/olexale/arkit_flutter_plugin.git
```

## Contributing

If you find a bug or would like to request a new feature, just [open an issue](https://github.com/olexale/arkit_flutter_plugin/issues/new). Your contributions are always welcome!
