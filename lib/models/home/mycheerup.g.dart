// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mycheerup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyCheerUp _$$_MyCheerUpFromJson(Map<String, dynamic> json) => _$_MyCheerUp(
      cheer_up_id: json['cheer_up_id'] as String?,
      user_care_program_id: json['user_care_program_id'] as String?,
      cheer_up_by_user_id: json['cheer_up_by_user_id'] as String?,
      cheered_up_user_id: json['cheered_up_user_id'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
      user: json['user'] == null
          ? null
          : CheerUpUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MyCheerUpToJson(_$_MyCheerUp instance) =>
    <String, dynamic>{
      'cheer_up_id': instance.cheer_up_id,
      'user_care_program_id': instance.user_care_program_id,
      'cheer_up_by_user_id': instance.cheer_up_by_user_id,
      'cheered_up_user_id': instance.cheered_up_user_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
      'user': instance.user,
    };
