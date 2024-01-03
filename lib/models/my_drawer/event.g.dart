// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      event_id: json['event_id'] as String,
      user_id: json['user_id'] as String,
      image: json['image'] as String,
      title_text: json['title_text'] as String,
      body_text: json['body_text'] as String,
      status: json['status'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      is_deleted: json['is_deleted'] as int,
      invoked_link: json['invoked_link'] as String,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'event_id': instance.event_id,
      'user_id': instance.user_id,
      'image': instance.image,
      'title_text': instance.title_text,
      'body_text': instance.body_text,
      'status': instance.status,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'is_deleted': instance.is_deleted,
      'invoked_link': instance.invoked_link,
    };
