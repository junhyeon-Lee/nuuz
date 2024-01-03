// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getuserdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetUserData _$$_GetUserDataFromJson(Map<String, dynamic> json) =>
    _$_GetUserData(
      status: json['status'] as bool?,
      userData: json['userData'] == null
          ? null
          : UserData.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GetUserDataToJson(_$_GetUserData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'userData': instance.userData,
    };
