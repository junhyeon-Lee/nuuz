// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Form _$$_FormFromJson(Map<String, dynamic> json) => _$_Form(
      form_id: json['form_id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
    );

Map<String, dynamic> _$$_FormToJson(_$_Form instance) => <String, dynamic>{
      'form_id': instance.form_id,
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'type': instance.type,
      'status': instance.status,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
    };
