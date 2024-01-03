// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginResponse _$$_LoginResponseFromJson(Map<String, dynamic> json) =>
    _$_LoginResponse(
      status: json['status'] as bool,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$_LoginResponseToJson(_$_LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'message': instance.message,
    };
