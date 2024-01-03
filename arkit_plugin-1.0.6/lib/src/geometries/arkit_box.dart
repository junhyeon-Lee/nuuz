import 'package:arkit_plugin/src/geometries/arkit_geometry.dart';
import 'package:arkit_plugin/src/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/src/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_box.g.dart';

/// ARKitBox represents a box with rectangular sides and optional chamfers.
@JsonSerializable()
class ARKitBox extends ARKitGeometry {
  ARKitBox({
    double width = 1,
    double height = 1,
    double length = 1,
    this.chamferRadius = 0,
    List<ARKitMaterial>? materials,
  })  : width = ValueNotifier(width),
        height = ValueNotifier(height),
        length = ValueNotifier(length),
        super(
          materials: materials,
        );

  @DoubleValueNotifierConverter()
  final ValueNotifier<double> width;

  @DoubleValueNotifierConverter()
  final ValueNotifier<double> height;

  @DoubleValueNotifierConverter()
  final ValueNotifier<double> length;

  final double chamferRadius;

  static ARKitBox fromJson(Map<String, dynamic> json) =>
      _$ARKitBoxFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$ARKitBoxToJson(this)..addAll({'dartType': 'ARKitBox'});
}
