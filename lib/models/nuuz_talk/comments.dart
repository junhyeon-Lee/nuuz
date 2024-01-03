import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/commentuserinfo.dart';
part 'comments.freezed.dart';
part 'comments.g.dart';

@freezed
class UserComment with _$UserComment {
  factory UserComment({
    String? comment_id,
    String? post_id,
    String? user_id,
    String? description,
    String? created_at,
    String? updated_at,
    int? is_deleted,
    CommentUserInfo? user,
    int? reactions,
    int? is_liked,
    String? reactId,
    String? postImage,
    String? categoryName,
    String? categoryId,
  }) = _UserComment;

  factory UserComment.fromJson(Map<String, dynamic> json) =>
      _$UserCommentFromJson(json);
}