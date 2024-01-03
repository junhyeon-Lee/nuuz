
import 'package:freezed_annotation/freezed_annotation.dart';
part 'connectionlist.freezed.dart';
part 'connectionlist.g.dart';

@freezed
class ConnectionList with _$ConnectionList {
  factory ConnectionList({
    required String? user_id,
    required String? name,
    required String? email,
    required String? profile_image,
    required String? nick_name,
    required String? introduction,
  }) = _ConnectionList;

  factory ConnectionList.fromJson(Map<String, dynamic> json) =>
      _$ConnectionListFromJson(json);
}
