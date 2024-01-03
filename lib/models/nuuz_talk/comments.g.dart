// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserComment _$$_UserCommentFromJson(Map<String, dynamic> json) =>
    _$_UserComment(
      comment_id: json['comment_id'] as String?,
      post_id: json['post_id'] as String?,
      user_id: json['user_id'] as String?,
      description: json['description'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
      user: json['user'] == null
          ? null
          : CommentUserInfo.fromJson(json['user'] as Map<String, dynamic>),
      reactions: json['reactions'] as int?,
      is_liked: json['is_liked'] as int?,
      reactId: json['reactId'] as String?,
      postImage: json['postImage'] as String?,
      categoryName: json['categoryName'] as String?,
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$$_UserCommentToJson(_$_UserComment instance) =>
    <String, dynamic>{
      'comment_id': instance.comment_id,
      'post_id': instance.post_id,
      'user_id': instance.user_id,
      'description': instance.description,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
      'user': instance.user,
      'reactions': instance.reactions,
      'is_liked': instance.is_liked,
      'reactId': instance.reactId,
      'postImage': instance.postImage,
      'categoryName': instance.categoryName,
      'categoryId': instance.categoryId,
    };
