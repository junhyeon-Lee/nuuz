// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheeruplist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CheerUpList _$$_CheerUpListFromJson(Map<String, dynamic> json) =>
    _$_CheerUpList(
      status: json['status'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => CheerUp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CheerUpListToJson(_$_CheerUpList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
