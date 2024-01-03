// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PartDetail _$$_PartDetailFromJson(Map<String, dynamic> json) =>
    _$_PartDetail(
      partName: json['partName'] as String,
      title: json['title'] as String,
      imageUrl: json['image'] as String?,
      cartridgeType: json['cartridgeType'] as String,
      description: json['description'] as String,
      line_group_details: (json['line_group_details'] as List<dynamic>)
          .map((e) => LineGroupDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      shots: json['shots'] as int,
    );

Map<String, dynamic> _$$_PartDetailToJson(_$_PartDetail instance) =>
    <String, dynamic>{
      'partName': instance.partName,
      'title': instance.title,
      'image': instance.imageUrl,
      'cartridgeType': instance.cartridgeType,
      'description': instance.description,
      'line_group_details': instance.line_group_details,
      'shots': instance.shots,
    };
