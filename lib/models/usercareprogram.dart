
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/reservationnotice.dart';

part 'usercareprogram.freezed.dart';
part 'usercareprogram.g.dart';

@freezed
class UserCareProgram with _$UserCareProgram {
  factory UserCareProgram({
    @JsonKey(name: "user_care_program_id") required String userCareProgramId,
    @JsonKey(name: "care_program") required Program program,
    @JsonKey(name: "start_day") String? startDay,
    @JsonKey(name: "reservation_notice") ReservationNotice? reservationNotice,
    @JsonKey(name: "cheering_notice") int? cheeringNotice, 
    @JsonKey(name: "start_date") required String startDate,
    required String status,
  }) = _UserCareProgram;
	
  factory UserCareProgram.fromJson(Map<String, dynamic> json) =>
			_$UserCareProgramFromJson(json);
}
