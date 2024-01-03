// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResultList _$$_ResultListFromJson(Map<String, dynamic> json) =>
    _$_ResultList(
      status: json['status'] as bool?,
      resultData: (json['resultData'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ResultListToJson(_$_ResultList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'resultData': instance.resultData,
    };
