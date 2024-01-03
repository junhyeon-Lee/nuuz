import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/user_info/userdata.dart';

part 'userupdate.freezed.dart';

part 'userupdate.g.dart';

@freezed
class UserUpdate with _$UserUpdate {
  factory UserUpdate({
    required String? name,
    required String? birth_date,
    required String? gender,
    required String? email,
    required String? profile_image,
    required String? is_deleted,
    required String? nick_name,
  }) = _UserUpdate;

  factory UserUpdate.fromJson(Map<String, dynamic> json) => _$UserUpdateFromJson(json);
}
