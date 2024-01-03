// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventList _$$_EventListFromJson(Map<String, dynamic> json) => _$_EventList(
      count: json['count'] as int,
      result: (json['result'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_EventListToJson(_$_EventList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'result': instance.result,
    };
