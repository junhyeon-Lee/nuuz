
import 'package:freezed_annotation/freezed_annotation.dart';

part 'react_model.freezed.dart';
part 'react_model.g.dart';

@freezed
class ReactModel with _$ReactModel {
  factory ReactModel({
    @JsonKey(name: "react_id") required String reactId,
    @JsonKey(name: "post_id") required String postId,
    @JsonKey(name: "comment_id") String? commentId,
    @JsonKey(name: "user_id") required String? userId,
    @JsonKey(name: "react") required String? react,
    @JsonKey(name: "created_at") required String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
    @JsonKey(name: "is_deleted") int? isDeleted,
  }) = _ReactModel;

  factory ReactModel.fromJson(Map<String, dynamic> json) =>
      _$ReactModelFromJson(json);
}
