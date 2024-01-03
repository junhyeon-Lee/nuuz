// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Program _$$_ProgramFromJson(Map<String, dynamic> json) => _$_Program(
      id: json['care_program_id'] as int,
      name: json['care_program_name'] as String,
      description: json['description'] as String?,
      routineDays: json['routin_days'] as int?,
      image: json['image'] as String?,
      subprograms: (json['subprograms'] as List<dynamic>?)
          ?.map((e) => Subprogram.fromJson(e as Map<String, dynamic>))
          .toList(),
      product_id_array: (json['product_id_array'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ProgramToJson(_$_Program instance) =>
    <String, dynamic>{
      'care_program_id': instance.id,
      'care_program_name': instance.name,
      'description': instance.description,
      'routin_days': instance.routineDays,
      'image': instance.image,
      'subprograms': instance.subprograms,
      'product_id_array': instance.product_id_array,
    };
