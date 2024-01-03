import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/user_info/privacy_notification.dart';

part 'userdata.freezed.dart';
part 'userdata.g.dart';

@freezed
class UserData with _$UserData {
  factory UserData({
    required String? user_id,
    required String? name,
    required String? birth_date,
    required String? gender,
    required String? email,
    required String? profile_image,
    required String? social_token,
    required String? created_at,
    required String? updated_at,
    required int? is_deleted,
    required String? nick_name,
    required String? login_type,
    required String? introduction,
    required String? role,
    required String? password,
    required String? shipping,
    required String? comment,
    required String? post,
    required PrivacySettingsModel? privacy_settings,
    required NotificationSettingsModel? notification_settings,

  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
