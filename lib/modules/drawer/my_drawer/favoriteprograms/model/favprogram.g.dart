// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favprogram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavProgramModel _$$_FavProgramModelFromJson(Map<String, dynamic> json) =>
    _$_FavProgramModel(
      care_program_id: json['care_program_id'] as int?,
      care_program_name: json['care_program_name'] as String?,
      created_at: json['created_at'] as String?,
      description: json['description'] as String?,
      part_group:
          (json['part_group'] as List<dynamic>?)?.map((e) => e as int).toList(),
      routin_days: json['routin_days'] as int?,
      time_spent: json['time_spent'] as String?,
      image: json['image'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$$_FavProgramModelToJson(_$_FavProgramModel instance) =>
    <String, dynamic>{
      'care_program_id': instance.care_program_id,
      'care_program_name': instance.care_program_name,
      'created_at': instance.created_at,
      'description': instance.description,
      'part_group': instance.part_group,
      'routin_days': instance.routin_days,
      'time_spent': instance.time_spent,
      'image': instance.image,
      'count': instance.count,
    };
