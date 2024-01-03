import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nuuz/firebase_options.dart';
import 'package:nuuz/routes.dart';
import 'package:nuuz/ui/theme/custom_theme.dart';
import 'package:nuuz/util/notification_service.dart';
import 'package:wakelock/wakelock.dart';

///@@@@@@@@@@@@@@@@@@@App VERSION@@@@@@@@@@@@@@@@@@@@///
const String appVersion = '1.0.1';

///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///
String fcmToken = '';
final supportedLocales = [const Locale('en', 'US'), const Locale('ko', 'KR')];

var channel = const AndroidNotificationChannel(
  'nuuz-c749c', // id
  'nuuz', // name
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

late List<CameraDescription> _cameras;

Future<void> main() async {
  KakaoSdk.init(nativeAppKey: 'adf071a3c53292a6b6522a38414999cb');
  WidgetsFlutterBinding.ensureInitialized();

  await _flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (Platform.isAndroid) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _firebaseMessagingBackgroundHandler(message);
    });
  }

  Wakelock.enable();

  String? token = await FirebaseMessaging.instance.getToken();
  fcmToken = token ?? "";

  NotificationService().init();
  _cameras = await availableCameras();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child:
          EasyLocalization(supportedLocales: supportedLocales, path: 'assets/translation', fallbackLocale: const Locale('ko', 'KR'), child: MyApp()),
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    icon: 'ic_launcher',
  );
  await FlutterLocalNotificationsPlugin().show(
    0,
    message.notification?.title ?? "",
    message.notification?.body ?? "",
    NotificationDetails(android: androidPlatformChannelSpecifics),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
