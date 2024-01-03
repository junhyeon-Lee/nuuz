import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/user_info/userdata.dart';

part 'getuserdata.freezed.dart';
part 'getuserdata.g.dart';

@freezed
class GetUserData with _$GetUserData {
  factory GetUserData({
    required bool? status,
    required UserData? userData,
  }) = _GetUserData;

  factory GetUserData.fromJson(Map<String, dynamic> json) =>
      _$GetUserDataFromJson(json);
}
