// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subprogram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubProgram _$$_SubProgramFromJson(Map<String, dynamic> json) =>
    _$_SubProgram(
      areas:
          (json['areas'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cartridgeType: json['cartridgeType'] as String?,
      partDetails: (json['partDetails'] as List<dynamic>?)
          ?.map((e) => PartDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      expectedShots: json['expectedShots'] as int,
    );

Map<String, dynamic> _$$_SubProgramToJson(_$_SubProgram instance) =>
    <String, dynamic>{
      'areas': instance.areas,
      'cartridgeType': instance.cartridgeType,
      'partDetails': instance.partDetails,
      'expectedShots': instance.expectedShots,
    };
