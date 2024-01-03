import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = 'nuzzNotification';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static const String groupKey = 'com.ilooda.nuuz.WORK_EMAIL';

  Future<void> init() async {
    _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(presentSound: false);

  Future<void> scheduleNotifications({required DateTime reservation, required int notificationId}) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      "Prog_Rese_0032".tr(),
      htmlFormatBigText: true,
      contentTitle: '',
      htmlFormatContentTitle: true,
      summaryText: 'Meet your muse',
      htmlFormatSummaryText: true,
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('big text channel id', 'big text channel name',
        channelDescription: 'big text channel description', styleInformation: bigTextStyleInformation);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      '',
      '',
      _nextInstanceOfTenAM(reservation: reservation),
      NotificationDetails(android: androidNotificationDetails, iOS: darwinNotificationDetails),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM({
    required DateTime reservation,
  }) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, reservation.year, reservation.month, reservation.day, reservation.hour, reservation.minute);
    return scheduledDate;
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
