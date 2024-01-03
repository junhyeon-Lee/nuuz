// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mycheeruplist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyCheerUpList _$$_MyCheerUpListFromJson(Map<String, dynamic> json) =>
    _$_MyCheerUpList(
      status: json['status'] as bool,
      data: CheerUpResult.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MyCheerUpListToJson(_$_MyCheerUpList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
