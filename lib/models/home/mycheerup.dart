
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/home/cheerupuser.dart';

part 'mycheerup.freezed.dart';
part 'mycheerup.g.dart';

@freezed
class MyCheerUp with _$MyCheerUp {
  factory MyCheerUp({
    String? cheer_up_id,
    String? user_care_program_id,
    String? cheer_up_by_user_id,
    String? cheered_up_user_id,
    String? created_at,
    String? updated_at,
    int? is_deleted,
    CheerUpUser? user

  }) = _MyCheerUp;

  factory MyCheerUp.fromJson(Map<String, dynamic> json) =>
      _$MyCheerUpFromJson(json);
}
