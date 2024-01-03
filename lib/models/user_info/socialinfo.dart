
import 'package:freezed_annotation/freezed_annotation.dart';

part 'socialinfo.freezed.dart';
part 'socialinfo.g.dart';

@freezed
class SocialInfo with _$SocialInfo {
  factory SocialInfo({
    required String loginType,
    required String? socialToken,
    required String? email,
    required String? deviceType,
    required String? deviceToken
  }) = _SocialInfo;

  factory SocialInfo.fromJson(Map<String, dynamic> json) =>
      _$SocialInfoFromJson(json);
}
