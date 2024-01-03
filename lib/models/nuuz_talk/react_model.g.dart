// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'react_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReactModel _$$_ReactModelFromJson(Map<String, dynamic> json) =>
    _$_ReactModel(
      reactId: json['react_id'] as String,
      postId: json['post_id'] as String,
      commentId: json['comment_id'] as String?,
      userId: json['user_id'] as String?,
      react: json['react'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isDeleted: json['is_deleted'] as int?,
    );

Map<String, dynamic> _$$_ReactModelToJson(_$_ReactModel instance) =>
    <String, dynamic>{
      'react_id': instance.reactId,
      'post_id': instance.postId,
      'comment_id': instance.commentId,
      'user_id': instance.userId,
      'react': instance.react,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_deleted': instance.isDeleted,
    };
