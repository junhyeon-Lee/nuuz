// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Notice _$$_NoticeFromJson(Map<String, dynamic> json) => _$_Notice(
      notice_id: json['notice_id'] as String?,
      user_id: json['user_id'] as String?,
      category: json['category'] as String?,
      title_text: json['title_text'] as String?,
      body_text: json['body_text'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
    );

Map<String, dynamic> _$$_NoticeToJson(_$_Notice instance) => <String, dynamic>{
      'notice_id': instance.notice_id,
      'user_id': instance.user_id,
      'category': instance.category,
      'title_text': instance.title_text,
      'body_text': instance.body_text,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
    };
