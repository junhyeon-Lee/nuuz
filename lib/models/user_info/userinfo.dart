
import 'package:freezed_annotation/freezed_annotation.dart';

part 'userinfo.freezed.dart';
part 'userinfo.g.dart';

@freezed
class UserInfo with _$UserInfo {
  factory UserInfo({
    required String token,
    required String? email,
    required String? nickname,
    required String? gender,
    required String? profileImage,
    required DateTime? birthday,
    required String? registeredProduct,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
