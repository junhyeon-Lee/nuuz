// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arkit_anchor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARKitUnkownAnchor _$ARKitUnkownAnchorFromJson(Map json) => ARKitUnkownAnchor(
      json['anchorType'] as String,
      json['nodeName'] as String?,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List),
    );

Map<String, dynamic> _$ARKitUnkownAnchorToJson(ARKitUnkownAnchor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  val['identifier'] = instance.identifier;
  val['transform'] = const MatrixConverter().toJson(instance.transform);
  val['anchorType'] = instance.anchorType;
  return val;
}

ARKitPlaneAnchor _$ARKitPlaneAnchorFromJson(Map json) => ARKitPlaneAnchor(
      const Vector3Converter().fromJson(json['center'] as List),
      const Vector3Converter().fromJson(json['extent'] as List),
      json['nodeName'] as String?,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List),
    );

Map<String, dynamic> _$ARKitPlaneAnchorToJson(ARKitPlaneAnchor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  val['identifier'] = instance.identifier;
  val['transform'] = const MatrixConverter().toJson(instance.transform);
  val['center'] = const Vector3Converter().toJson(instance.center);
  val['extent'] = const Vector3Converter().toJson(instance.extent);
  return val;
}

ARKitImageAnchor _$ARKitImageAnchorFromJson(Map json) => ARKitImageAnchor(
      json['referenceImageName'] as String?,
      const Vector2Converter()
          .fromJson(json['referenceImagePhysicalSize'] as List),
      json['isTracked'] as bool,
      json['nodeName'] as String?,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List),
    );

Map<String, dynamic> _$ARKitImageAnchorToJson(ARKitImageAnchor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  val['identifier'] = instance.identifier;
  val['transform'] = const MatrixConverter().toJson(instance.transform);
  writeNotNull('referenceImageName', instance.referenceImageName);
  val['referenceImagePhysicalSize'] =
      const Vector2Converter().toJson(instance.referenceImagePhysicalSize);
  val['isTracked'] = instance.isTracked;
  return val;
}

ARKitFaceAnchor _$ARKitFaceAnchorFromJson(Map json) => ARKitFaceAnchor(
      ARKitFace.fromJson(json['geometry'] as Map),
      (json['blendShapes'] as Map).map(
        (k, e) => MapEntry(k as String, (e as num).toDouble()),
      ),
      json['isTracked'] as bool,
      json['nodeName'] as String?,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List),
      const MatrixConverter().fromJson(json['leftEyeTransform'] as List),
      const MatrixConverter().fromJson(json['rightEyeTransform'] as List),
      const Vector3ListConverter().fromJson(json['geometryVertices'] as List),
    );

Map<String, dynamic> _$ARKitFaceAnchorToJson(ARKitFaceAnchor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  val['identifier'] = instance.identifier;
  val['transform'] = const MatrixConverter().toJson(instance.transform);
  val['geometry'] = instance.geometry;
  val['leftEyeTransform'] =
      const MatrixConverter().toJson(instance.leftEyeTransform);
  val['rightEyeTransform'] =
      const MatrixConverter().toJson(instance.rightEyeTransform);
  val['geometryVertices'] =
      const Vector3ListConverter().toJson(instance.geometryVertices);
  val['blendShapes'] = instance.blendShapes;
  val['isTracked'] = instance.isTracked;
  return val;
}

ARKitBodyAnchor _$ARKitBodyAnchorFromJson(Map json) => ARKitBodyAnchor(
      ARKitSkeleton.fromJson(json['skeleton'] as Map),
      json['isTracked'] as bool,
      json['nodeName'] as String?,
      json['identifier'] as String,
      const MatrixConverter().fromJson(json['transform'] as List),
    );

Map<String, dynamic> _$ARKitBodyAnchorToJson(ARKitBodyAnchor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nodeName', instance.nodeName);
  val['identifier'] = instance.identifier;
  val['transform'] = const MatrixConverter().toJson(instance.transform);
  val['skeleton'] = instance.skeleton;
  val['isTracked'] = instance.isTracked;
  return val;
}
