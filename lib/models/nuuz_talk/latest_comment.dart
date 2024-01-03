
import 'package:freezed_annotation/freezed_annotation.dart';

part 'latest_comment.freezed.dart';

part 'latest_comment.g.dart';

@freezed
class LatestComment with _$LatestComment {
  factory LatestComment({
    @JsonKey(name: "comment_id") String? commentId,
    @JsonKey(name: "description") String? description,
  }) = _LatestComment;

  factory LatestComment.fromJson(Map<String, dynamic> json) => _$LatestCommentFromJson(json);
}
