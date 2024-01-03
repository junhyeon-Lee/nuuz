// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noticeresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoticeResult _$$_NoticeResultFromJson(Map<String, dynamic> json) =>
    _$_NoticeResult(
      status: json['status'] as bool,
      noticeData:
          NoticeList.fromJson(json['noticeData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_NoticeResultToJson(_$_NoticeResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'noticeData': instance.noticeData,
    };
