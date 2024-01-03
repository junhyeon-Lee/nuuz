// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Banner _$$_BannerFromJson(Map<String, dynamic> json) => _$_Banner(
      banner_id: json['banner_id'] as String?,
      banner_image: json['banner_image'] as String?,
      title_text: json['title_text'] as String?,
      content_text: json['content_text'] as String?,
      link: json['link'] as String?,
      banner_order: json['banner_order'] as String?,
      status: json['status'] as String?,
      is_deleted: json['is_deleted'] as int?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      link_value: json['link_value'] as String?,
    );

Map<String, dynamic> _$$_BannerToJson(_$_Banner instance) => <String, dynamic>{
      'banner_id': instance.banner_id,
      'banner_image': instance.banner_image,
      'title_text': instance.title_text,
      'content_text': instance.content_text,
      'link': instance.link,
      'banner_order': instance.banner_order,
      'status': instance.status,
      'is_deleted': instance.is_deleted,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'link_value': instance.link_value,
    };
