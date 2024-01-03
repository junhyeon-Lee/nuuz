// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'days.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Days _$$_DaysFromJson(Map<String, dynamic> json) => _$_Days(
      year: json['year'] as int,
      month: json['month'] as int,
      day: json['day'] as int,
      inMonth: json['inMonth'] as bool,
      picked: json['picked'] as bool,
      result: json['result'] as bool,
    );

Map<String, dynamic> _$$_DaysToJson(_$_Days instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'inMonth': instance.inMonth,
      'picked': instance.picked,
      'result': instance.result,
    };
