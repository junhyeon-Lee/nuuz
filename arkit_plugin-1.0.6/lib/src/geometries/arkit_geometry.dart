import 'package:arkit_plugin/src/geometries/arkit_box.dart';
import 'package:arkit_plugin/src/geometries/arkit_capsule.dart';
import 'package:arkit_plugin/src/geometries/arkit_cone.dart';
import 'package:arkit_plugin/src/geometries/arkit_cylinder.dart';
import 'package:arkit_plugin/src/geometries/arkit_face.dart';
import 'package:arkit_plugin/src/geometries/arkit_line.dart';
import 'package:arkit_plugin/src/geometries/arkit_plane.dart';
import 'package:arkit_plugin/src/geometries/arkit_pyramid.dart';
import 'package:arkit_plugin/src/geometries/arkit_sphere.dart';
import 'package:arkit_plugin/src/geometries/arkit_text.dart';
import 'package:arkit_plugin/src/geometries/arkit_torus.dart';
import 'package:arkit_plugin/src/geometries/arkit_tube.dart';
import 'package:arkit_plugin/src/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/src/utils/json_converters.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'arkit_geometry.g.dart';

/// ARKitGeometry is an abstract class that represents the geometry that can be attached to a SCNNode.
abstract class ARKitGeometry {
  ARKitGeometry({List<ARKitMaterial>? materials})
      : materials = ValueNotifier(materials);

  factory ARKitGeometry.fromJson(Map<String, dynamic> arguments) {
    final type = arguments['geometryType'].toString();
    switch (type) {
      case 'box':
        return ARKitBox.fromJson(arguments);
      case 'capsule':
        return ARKitCapsule.fromJson(arguments);
      case 'cone':
        return ARKitCone.fromJson(arguments);
      case 'cylinder':
        return ARKitCylinder.fromJson(arguments);
      case 'face':
        return ARKitFace.fromJson(arguments);
      case 'line':
        return ARKitLine.fromJson(arguments);
      case 'plane':
        return ARKitPlane.fromJson(arguments);
      case 'pyramid':
        return ARKitPyramid.fromJson(arguments);
      case 'sphere':
        return ARKitSphere.fromJson(arguments);
      case 'text':
        return ARKitText.fromJson(arguments);
      case 'torus':
        return ARKitTorus.fromJson(arguments);
      case 'tube':
        return ARKitTube.fromJson(arguments);
    }
    return ARKitUnkownGeometry.fromJson(arguments);
  }

  /// Specifies the receiver's materials array.
  /// Each geometry element can be rendered using a different material.
  /// The index of the material used for a geometry element is equal to the index of that element modulo the number of materials.
  @ListMaterialsValueNotifierConverter()
  final ValueNotifier<List<ARKitMaterial>?> materials;

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class ARKitUnkownGeometry extends ARKitGeometry {
  ARKitUnkownGeometry(this.geometryType);

  final String? geometryType;

  static ARKitUnkownGeometry fromJson(Map<String, dynamic> json) =>
      _$ARKitUnkownGeometryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ARKitUnkownGeometryToJson(this);
}
