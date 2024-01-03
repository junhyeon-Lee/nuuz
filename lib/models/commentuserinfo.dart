import 'package:freezed_annotation/freezed_annotation.dart';
part 'commentuserinfo.freezed.dart';
part 'commentuserinfo.g.dart';

@freezed
class CommentUserInfo with _$CommentUserInfo {
  factory CommentUserInfo({
    required String? name,
    required String? user_id,
    required String? nick_name,
    required String? profile_image,
  }) = _CommentUserInfo;

  factory CommentUserInfo.fromJson(Map<String, dynamic> json) =>
      _$CommentUserInfoFromJson(json);
}
