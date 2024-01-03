// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Calender _$$_CalenderFromJson(Map<String, dynamic> json) => _$_Calender(
      nickname: json['nickname'] as int,
      profileImage: json['profileImage'] as int,
      days: Days.fromJson(json['days'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CalenderToJson(_$_Calender instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'profileImage': instance.profileImage,
      'days': instance.days,
    };
