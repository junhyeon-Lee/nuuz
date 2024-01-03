// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usercareprogram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserCareProgram _$$_UserCareProgramFromJson(Map<String, dynamic> json) =>
    _$_UserCareProgram(
      userCareProgramId: json['user_care_program_id'] as String,
      program: Program.fromJson(json['care_program'] as Map<String, dynamic>),
      startDay: json['start_day'] as String?,
      reservationNotice: json['reservation_notice'] == null
          ? null
          : ReservationNotice.fromJson(
              json['reservation_notice'] as Map<String, dynamic>),
      cheeringNotice: json['cheering_notice'] as int?,
      startDate: json['start_date'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_UserCareProgramToJson(_$_UserCareProgram instance) =>
    <String, dynamic>{
      'user_care_program_id': instance.userCareProgramId,
      'care_program': instance.program,
      'start_day': instance.startDay,
      'reservation_notice': instance.reservationNotice,
      'cheering_notice': instance.cheeringNotice,
      'start_date': instance.startDate,
      'status': instance.status,
    };
