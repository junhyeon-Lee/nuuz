// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trendlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrendList _$$_TrendListFromJson(Map<String, dynamic> json) => _$_TrendList(
      trend_id: json['trend_id'] as String?,
      title: json['title'] as String?,
      link_type: json['link_type'] as String?,
      link_value: json['link_value'] as String?,
      additional_information: json['additional_information'] as String?,
      status: json['status'] as String?,
      banner_image: json['banner_image'] as String?,
      end_date: json['end_date'] as String?,
      is_deleted: json['is_deleted'] as int?,
    );

Map<String, dynamic> _$$_TrendListToJson(_$_TrendList instance) =>
    <String, dynamic>{
      'trend_id': instance.trend_id,
      'title': instance.title,
      'link_type': instance.link_type,
      'link_value': instance.link_value,
      'additional_information': instance.additional_information,
      'status': instance.status,
      'banner_image': instance.banner_image,
      'end_date': instance.end_date,
      'is_deleted': instance.is_deleted,
    };
