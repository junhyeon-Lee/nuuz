import 'package:freezed_annotation/freezed_annotation.dart';
part 'comment_success_model.freezed.dart';
part 'comment_success_model.g.dart';

@freezed
class CommentSuccessModel with _$CommentSuccessModel {
  factory CommentSuccessModel({
    bool? status,
    String? message,
  }) = _CommentSuccessModel;

  factory CommentSuccessModel.fromJson(Map<String, dynamic> json) =>
      _$CommentSuccessModelFromJson(json);
}