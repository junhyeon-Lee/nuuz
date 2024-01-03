// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/nuuz_talk/category.dart';
import 'package:nuuz/models/nuuz_talk/latest_comment.dart';
import 'package:nuuz/models/nuuz_talk/user.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/models/program.dart';

part 'userpost.freezed.dart';

part 'userpost.g.dart';

@freezed
class UserPost with _$UserPost {
  factory UserPost({
    @JsonKey(name: "post_id") required String postId,
    @JsonKey(name: "user_id") required String userId,
    @JsonKey(name: "created_at") String? createdAt,
    required String? title,
    required String name,
    List<String>? hashtag,
    List<String>? items,
    @JsonKey(name: "image") required List<String> imageUrls,
    required Category category,
    @JsonKey(name: "product_id") required List<String> productIds,
    @JsonKey(name: "program_id") required List<String> programIds,
    @JsonKey(name: "review_id") required List<String> reviewIds,
    @JsonKey(name: "likes_count") required int likesCount,
    @JsonKey(name: "comments_count") required int commentsCount,
    @JsonKey(name: "latest_comment") LatestComment? latestComment,
    @JsonKey(name: "user") User? user,
    @JsonKey(name: "react_id") String? reactId,
    @JsonKey(name: "html") String? html,
    bool? isLiked,
    int? is_popular
  }) = _UserPost;

  factory UserPost.fromJson(Map<String, dynamic> json) => _$UserPostFromJson(json);
}
