
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "user_id") String? user_id,
    @JsonKey(name: "profile_image") String? profile_image,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
