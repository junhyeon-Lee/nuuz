// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Result _$$_ResultFromJson(Map<String, dynamic> json) => _$_Result(
      result_id: json['result_id'] as String?,
      user_id: json['user_id'] as String?,
      product_id: json['product_id'] as String?,
      result_image: json['result_image'] as String?,
      date: json['date'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
      program: json['program'] == null
          ? null
          : ResultProgram.fromJson(json['program'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ResultToJson(_$_Result instance) => <String, dynamic>{
      'result_id': instance.result_id,
      'user_id': instance.user_id,
      'product_id': instance.product_id,
      'result_image': instance.result_image,
      'date': instance.date,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
      'program': instance.program,
    };
