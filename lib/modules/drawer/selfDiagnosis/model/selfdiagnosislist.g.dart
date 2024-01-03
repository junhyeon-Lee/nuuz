// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selfdiagnosislist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SelfDiagnosisList _$$_SelfDiagnosisListFromJson(Map<String, dynamic> json) =>
    _$_SelfDiagnosisList(
      status: json['status'] as bool,
      selfDiagnosis: (json['selfDiagnosis'] as List<dynamic>)
          .map((e) => SelfDiagnosisModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SelfDiagnosisListToJson(
        _$_SelfDiagnosisList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'selfDiagnosis': instance.selfDiagnosis,
    };
