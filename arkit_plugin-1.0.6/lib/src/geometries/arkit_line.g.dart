// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitLine _$ARKitLineFromJson(Map json) => ARKitLine(
      fromVector: const Vector3Converter().fromJson(json['fromVector'] as List),
      toVector: const Vector3Converter().fromJson(json['toVector'] as List),
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => ARKitMaterial.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$ARKitLineToJson(ARKitLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('materials',
      const ListMaterialsValueNotifierConverter().toJson(instance.materials));
  val['fromVector'] = const Vector3Converter().toJson(instance.fromVector);
  val['toVector'] = const Vector3Converter().toJson(instance.toVector);
  return val;
}
