// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
      token: json['token'] as String,
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      gender: json['gender'] as String?,
      profileImage: json['profileImage'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      registeredProduct: json['registeredProduct'] as String?,
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'token': instance.token,
      'email': instance.email,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'profileImage': instance.profileImage,
      'birthday': instance.birthday?.toIso8601String(),
      'registeredProduct': instance.registeredProduct,
    };
