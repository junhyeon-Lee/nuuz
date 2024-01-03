// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FaqModel _$$_FaqModelFromJson(Map<String, dynamic> json) => _$_FaqModel(
      faq_id: json['faq_id'] as String?,
      category: json['category'] as String?,
      title_text: json['title_text'] as String?,
      content_text: json['content_text'] as String?,
      status: json['status'] as String?,
      is_deleted: json['is_deleted'] as int?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$$_FaqModelToJson(_$_FaqModel instance) =>
    <String, dynamic>{
      'faq_id': instance.faq_id,
      'category': instance.category,
      'title_text': instance.title_text,
      'content_text': instance.content_text,
      'status': instance.status,
      'is_deleted': instance.is_deleted,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
