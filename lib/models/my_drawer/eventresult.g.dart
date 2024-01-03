// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventResult _$$_EventResultFromJson(Map<String, dynamic> json) =>
    _$_EventResult(
      status: json['status'] as bool,
      eventData: EventList.fromJson(json['eventData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EventResultToJson(_$_EventResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'eventData': instance.eventData,
    };
