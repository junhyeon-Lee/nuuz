// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userupdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserUpdate _$$_UserUpdateFromJson(Map<String, dynamic> json) =>
    _$_UserUpdate(
      name: json['name'] as String?,
      birth_date: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      profile_image: json['profile_image'] as String?,
      is_deleted: json['is_deleted'] as String?,
      nick_name: json['nick_name'] as String?,
    );

Map<String, dynamic> _$$_UserUpdateToJson(_$_UserUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birth_date': instance.birth_date,
      'gender': instance.gender,
      'email': instance.email,
      'profile_image': instance.profile_image,
      'is_deleted': instance.is_deleted,
      'nick_name': instance.nick_name,
    };
