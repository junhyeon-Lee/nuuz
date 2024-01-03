
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cheerupuser.freezed.dart';
part 'cheerupuser.g.dart';

@freezed
class CheerUpUser with _$CheerUpUser {
  factory CheerUpUser({
    String? name,
     String? user_id,
     String? nick_name,
    String? profile_image
  }) = _CheerUpUser;

  factory CheerUpUser.fromJson(Map<String, dynamic> json) =>
      _$CheerUpUserFromJson(json);
}
