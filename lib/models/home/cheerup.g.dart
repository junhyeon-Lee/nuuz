// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheerup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CheerUp _$$_CheerUpFromJson(Map<String, dynamic> json) => _$_CheerUp(
      user_care_program_id: json['user_care_program_id'] as String?,
      user_id: json['user_id'] as String?,
      program_id: json['program_id'] as String?,
      start_day: json['start_day'] as String?,
      set_up_routine: json['set_up_routine'] as int?,
      reservation_notice: json['reservation_notice'] == null
          ? null
          : ReservationNotice.fromJson(
              json['reservation_notice'] as Map<String, dynamic>),
      cheering_notice: json['cheering_notice'] as int?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
      start_date: json['start_date'] as String?,
      status: json['status'] as String?,
      user: json['user'] == null
          ? null
          : CheerUpUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CheerUpToJson(_$_CheerUp instance) =>
    <String, dynamic>{
      'user_care_program_id': instance.user_care_program_id,
      'user_id': instance.user_id,
      'program_id': instance.program_id,
      'start_day': instance.start_day,
      'set_up_routine': instance.set_up_routine,
      'reservation_notice': instance.reservation_notice,
      'cheering_notice': instance.cheering_notice,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
      'start_date': instance.start_date,
      'status': instance.status,
      'user': instance.user,
    };
