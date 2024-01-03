// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userpost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserPost _$$_UserPostFromJson(Map<String, dynamic> json) => _$_UserPost(
      postId: json['post_id'] as String,
      userId: json['user_id'] as String,
      createdAt: json['created_at'] as String?,
      title: json['title'] as String?,
      name: json['name'] as String,
      hashtag:
          (json['hashtag'] as List<dynamic>?)?.map((e) => e as String).toList(),
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageUrls:
          (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      productIds: (json['product_id'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      programIds: (json['program_id'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      reviewIds:
          (json['review_id'] as List<dynamic>).map((e) => e as String).toList(),
      likesCount: json['likes_count'] as int,
      commentsCount: json['comments_count'] as int,
      latestComment: json['latest_comment'] == null
          ? null
          : LatestComment.fromJson(
              json['latest_comment'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      reactId: json['react_id'] as String?,
      html: json['html'] as String?,
      isLiked: json['isLiked'] as bool?,
      is_popular: json['is_popular'] as int?,
    );

Map<String, dynamic> _$$_UserPostToJson(_$_UserPost instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'title': instance.title,
      'name': instance.name,
      'hashtag': instance.hashtag,
      'items': instance.items,
      'image': instance.imageUrls,
      'category': instance.category,
      'product_id': instance.productIds,
      'program_id': instance.programIds,
      'review_id': instance.reviewIds,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'latest_comment': instance.latestComment,
      'user': instance.user,
      'react_id': instance.reactId,
      'html': instance.html,
      'isLiked': instance.isLiked,
      'is_popular': instance.is_popular,
    };
