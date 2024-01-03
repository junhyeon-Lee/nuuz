// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservationnotice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReservationNotice _$$_ReservationNoticeFromJson(Map<String, dynamic> json) =>
    _$_ReservationNotice(
      sendReminder: json['send_reminder'] as int?,
      reminderTime: (json['reminder_time'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ReservationNoticeToJson(
        _$_ReservationNotice instance) =>
    <String, dynamic>{
      'send_reminder': instance.sendReminder,
      'reminder_time': instance.reminderTime,
    };
