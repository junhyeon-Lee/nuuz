
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/home/cheerupuser.dart';
import 'package:nuuz/models/reservationnotice.dart';

part 'cheerup.freezed.dart';
part 'cheerup.g.dart';

@freezed
class CheerUp with _$CheerUp {
  factory CheerUp({
     String? user_care_program_id,
     String? user_id,
     String? program_id,
    String? start_day,
    int? set_up_routine,
    ReservationNotice? reservation_notice,
    int? cheering_notice,
     String? created_at,
    String? updated_at,
     int? is_deleted,
    String? start_date,
    String? status,
     CheerUpUser? user

  }) = _CheerUp;

  factory CheerUp.fromJson(Map<String, dynamic> json) =>
      _$CheerUpFromJson(json);
}
