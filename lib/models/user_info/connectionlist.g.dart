// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectionlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConnectionList _$$_ConnectionListFromJson(Map<String, dynamic> json) =>
    _$_ConnectionList(
      user_id: json['user_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profile_image: json['profile_image'] as String?,
      nick_name: json['nick_name'] as String?,
      introduction: json['introduction'] as String?,
    );

Map<String, dynamic> _$$_ConnectionListToJson(_$_ConnectionList instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'name': instance.name,
      'email': instance.email,
      'profile_image': instance.profile_image,
      'nick_name': instance.nick_name,
      'introduction': instance.introduction,
    };
