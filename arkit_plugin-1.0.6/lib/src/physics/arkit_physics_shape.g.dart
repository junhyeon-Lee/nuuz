// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_physics_shape.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitPhysicsShape _$ARKitPhysicsShapeFromJson(Map json) => ARKitPhysicsShape(
      const ARKitGeometryConverter().fromJson(json['geometry'] as Map),
    );

Map<String, dynamic> _$ARKitPhysicsShapeToJson(ARKitPhysicsShape instance) =>
    <String, dynamic>{
      'geometry': const ARKitGeometryConverter().toJson(instance.geometry),
    };
