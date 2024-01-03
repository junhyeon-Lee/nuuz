// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PartDetail _$$_PartDetailFromJson(Map<String, dynamic> json) =>
    _$_PartDetail(
      partName: json['partName'] as String?,
      cartridgeType: json['cartridgeType'] as String?,
      shots: json['shots'] as int?,
    );

Map<String, dynamic> _$$_PartDetailToJson(_$_PartDetail instance) =>
    <String, dynamic>{
      'partName': instance.partName,
      'cartridgeType': instance.cartridgeType,
      'shots': instance.shots,
    };
