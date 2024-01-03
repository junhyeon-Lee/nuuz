import 'package:freezed_annotation/freezed_annotation.dart';

part 'loginresponse.freezed.dart';

part 'loginresponse.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  factory LoginResponse({
    required bool status,
    required String accessToken,
    required String refreshToken,
    String? message,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}
