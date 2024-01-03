// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socialinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SocialInfo _$$_SocialInfoFromJson(Map<String, dynamic> json) =>
    _$_SocialInfo(
      loginType: json['loginType'] as String,
      socialToken: json['socialToken'] as String?,
      email: json['email'] as String?,
      deviceType: json['deviceType'] as String?,
      deviceToken: json['deviceToken'] as String?,
    );

Map<String, dynamic> _$$_SocialInfoToJson(_$_SocialInfo instance) =>
    <String, dynamic>{
      'loginType': instance.loginType,
      'socialToken': instance.socialToken,
      'email': instance.email,
      'deviceType': instance.deviceType,
      'deviceToken': instance.deviceToken,
    };
