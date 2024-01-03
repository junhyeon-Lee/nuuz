
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservationnotice.freezed.dart';
part 'reservationnotice.g.dart';

@freezed
class ReservationNotice with _$ReservationNotice {
  factory ReservationNotice({
    @JsonKey(name: "send_reminder") int? sendReminder,
    @JsonKey(name: "reminder_time") List<String>? reminderTime,
  }) = _ReservationNotice;
	
  factory ReservationNotice.fromJson(Map<String, dynamic> json) =>
			_$ReservationNoticeFromJson(json);
}
