// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noticelist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoticeList _$$_NoticeListFromJson(Map<String, dynamic> json) =>
    _$_NoticeList(
      count: json['count'] as int,
      result: (json['result'] as List<dynamic>)
          .map((e) => Notice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_NoticeListToJson(_$_NoticeList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'result': instance.result,
    };
