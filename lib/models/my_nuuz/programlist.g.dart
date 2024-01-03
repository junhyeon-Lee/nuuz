// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'programlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProgramList _$$_ProgramListFromJson(Map<String, dynamic> json) =>
    _$_ProgramList(
      status: json['status'] as bool,
      careProgram: (json['careProgram'] as List<dynamic>?)
          ?.map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProgramListToJson(_$_ProgramList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'careProgram': instance.careProgram,
    };
