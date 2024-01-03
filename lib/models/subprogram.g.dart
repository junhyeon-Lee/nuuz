// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subprogram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Subprogram _$$_SubprogramFromJson(Map<String, dynamic> json) =>
    _$_Subprogram(
      cartridgeType: json['cartridgeType'] as String,
      expectedShots: json['expectedShots'] as int?,
      timeInMin: json['timeInMin'] as String?,
      imageUrl: json['imageUrl'] as String?,
      areas: (json['areas'] as List<dynamic>).map((e) => e as String).toList(),
      partDetails: (json['partDetails'] as List<dynamic>)
          .map((e) => PartDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SubprogramToJson(_$_Subprogram instance) =>
    <String, dynamic>{
      'cartridgeType': instance.cartridgeType,
      'expectedShots': instance.expectedShots,
      'timeInMin': instance.timeInMin,
      'imageUrl': instance.imageUrl,
      'areas': instance.areas,
      'partDetails': instance.partDetails,
    };
