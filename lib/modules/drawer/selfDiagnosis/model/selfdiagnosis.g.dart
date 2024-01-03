// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selfdiagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SelfDiagnosisModel _$$_SelfDiagnosisModelFromJson(
        Map<String, dynamic> json) =>
    _$_SelfDiagnosisModel(
      self_diagnosis_id: json['self_diagnosis_id'] as String?,
      user_id: json['user_id'] as String?,
      skin_type: json['skin_type'] as String?,
      skin_concerns: (json['skin_concerns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      detailed_concern: (json['detailed_concern'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      frequently_replaced: json['frequently_replaced'] as String?,
      color_makeup: json['color_makeup'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      is_deleted: json['is_deleted'] as int?,
      skin_care_habits: json['skin_care_habits'] as String?,
    );

Map<String, dynamic> _$$_SelfDiagnosisModelToJson(
        _$_SelfDiagnosisModel instance) =>
    <String, dynamic>{
      'self_diagnosis_id': instance.self_diagnosis_id,
      'user_id': instance.user_id,
      'skin_type': instance.skin_type,
      'skin_concerns': instance.skin_concerns,
      'detailed_concern': instance.detailed_concern,
      'frequently_replaced': instance.frequently_replaced,
      'color_makeup': instance.color_makeup,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_deleted': instance.is_deleted,
      'skin_care_habits': instance.skin_care_habits,
    };
