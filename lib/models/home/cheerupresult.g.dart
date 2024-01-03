// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheerupresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CheerUpResult _$$_CheerUpResultFromJson(Map<String, dynamic> json) =>
    _$_CheerUpResult(
      result: (json['result'] as List<dynamic>)
          .map((e) => MyCheerUp.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$$_CheerUpResultToJson(_$_CheerUpResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'count': instance.count,
    };
