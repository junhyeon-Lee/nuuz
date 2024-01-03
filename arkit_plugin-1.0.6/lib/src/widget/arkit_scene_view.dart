import 'dart:async';
import 'package:arkit_plugin/src/arkit_node.dart';
import 'package:arkit_plugin/src/enums/coaching_overlay_goal.dart';
import 'package:arkit_plugin/src/geometries/material/arkit_material.dart';
import 'package:arkit_plugin/src/widget/ar_environment_texturing.dart';
import 'package:arkit_plugin/src/widget/ar_tracking_state.dart';
import 'package:arkit_plugin/src/geometries/arkit_anchor.dart';
import 'package:arkit_plugin/src/geometries/arkit_box.dart';
import 'package:arkit_plugin/src/geometries/arkit_capsule.dart';
import 'package:arkit_plugin/src/geometries/arkit_cone.dart';
import 'package:arkit_plugin/src/geometries/arkit_cylinder.dart';
import 'package:arkit_plugin/src/geometries/arkit_plane.dart';
import 'package:arkit_plugin/src/geometries/arkit_pyramid.dart';
import 'package:arkit_plugin/src/geometries/arkit_sphere.dart';
import 'package:arkit_plugin/src/geometries/arkit_text.dart';
import 'package:arkit_plugin/src/geometries/arkit_torus.dart';
import 'package:arkit_plugin/src/geometries/arkit_tube.dart';
import 'package:arkit_plugin/src/hit/arkit_node_pan_result.dart';
import 'package:arkit_plugin/src/hit/arkit_node_pinch_result.dart';
import 'package:arkit_plugin/src/hit/arkit_node_rotation_result.dart';
import 'package:arkit_plugin/src/light/arkit_light_estimate.dart';
import 'package:arkit_plugin/src/utils/json_converters.dart';
import 'package:arkit_plugin/src/widget/arkit_arplane_detection.dart';
import 'package:arkit_plugin/src/hit/arkit_hit_test_result.dart';
import 'package:arkit_plugin/src/widget/arkit_configuration.dart';
import 'package:arkit_plugin/src/widget/arkit_world_alignment.dart';
import 'package:arkit_plugin/src/widget/arkit_reference_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

typedef ARKitPluginCreatedCallback = void Function(ARKitController controller);
typedef StringResultHandler = void Function(String? text);
typedef AnchorEventHandler = void Function(ARKitAnchor anchor);
typedef ARKitTapResultHandler = void Function(List<String> nodes);
typedef ARKitHitResultHandler = void Function(List<ARKitTestResult> hits);
typedef ARKitPanResultHandler = void Function(List<ARKitNodePanResult> pans);
typedef ARKitRotationResultHandler = void Function(
    List<ARKitNodeRotationResult> pans);
typedef ARKitPinchGestureHandler = void Function(
    List<ARKitNodePinchResult> pinch);

/// A widget that wraps ARSCNView from ARKit.
class ARKitSceneView extends StatefulWidget {
  const ARKitSceneView({
    Key? key,
    required this.onARKitViewCreated,
    this.configuration = ARKitConfiguration.worldTracking,
    this.environmentTexturing =
        ARWorldTrackingConfigurationEnvironmentTexturing.none,
    this.showStatistics = false,
    this.autoenablesDefaultLighting = true,
    this.enableTapRecognizer = false,
    this.enablePinchRecognizer = false,
    this.enablePanRecognizer = false,
    this.enableRotationRecognizer = false,
    this.showFeaturePoints = false,
    this.showWorldOrigin = false,
    this.planeDetection = ARPlaneDetection.none,
    this.detectionImagesGroupName,
    this.detectionImages,
    this.trackingImagesGroupName,
    this.trackingImages,
    this.forceUserTapOnCenter = false,
    this.worldAlignment = ARWorldAlignment.gravity,
    this.maximumNumberOfTrackedImages = 0,
    this.debug = false,
  }) : super(key: key);

  /// This function will be fired when ARKit view is created.
  final ARKitPluginCreatedCallback onARKitViewCreated;

  /// The configuration to use.
  /// Defaults to World Tracking.
  final ARKitConfiguration configuration;

  /// Determines whether the receiver should display statistics info like FPS.
  /// When set to true, statistics are displayed in a overlay on top of the rendered scene.
  /// Defaults to false.
  final bool showStatistics;

  /// Specifies whether the receiver should automatically light up scenes that have no light source.
  /// When enabled, a diffuse light is automatically added and placed while rendering scenes that have no light or only ambient lights.
  /// The default is true.
  final bool autoenablesDefaultLighting;

  /// Determines whether the receiver should recognize taps.
  /// The default is false.
  final bool enableTapRecognizer;

  /// Determines whether the receiver should recognize pinch events.
  /// The default is false.
  final bool enablePinchRecognizer;

  /// Determines whether the receiver should recognize pan events.
  /// The default is false.
  final bool enablePanRecognizer;

  /// Determines whether the receiver should recognize rotation events.
  /// The default is false.
  final bool enableRotationRecognizer;

  /// Type of planes to detect in the scene.
  /// If set, new planes will continue to be detected and updated over time.
  /// Detected planes will be added to the session as ARPlaneAnchor objects.
  /// In the event that two planes are merged, the newer plane will be removed.
  /// Defaults to ARPlaneDetection.none.
  final ARPlaneDetection planeDetection;

  /// Determines how the coordinate system should be aligned with the world.
  /// The default is ARWorldAlignment.gravity.
  final ARWorldAlignment worldAlignment;

  /// Show detected 3D feature points in the world.
  /// The default is false.
  final bool showFeaturePoints;

  /// Show the world origin in the scene.
  /// The default is false.
  final bool showWorldOrigin;

  /// The mode of environment texturing to run.
  /// If set, texture information will be accumulated and updated. Adding an AREnvironmentProbeAnchor to the session
  /// will get the current environment texture available from that probe's perspective which can be used for lighting
  /// virtual objects in the scene.
  /// Defaults to ARWorldTrackingConfigurationEnvironmentTexturing.none.
  /// Requires iOS 12 or newer
  final ARWorldTrackingConfigurationEnvironmentTexturing environmentTexturing;

  /// Images to detect in the scene.
  /// If set the session will attempt to detect the specified images.
  /// When an image is detected an ARImageAnchor will be added to the session.
  final String? detectionImagesGroupName;

  /// Images to detect in the scene.
  /// If set the session will attempt to detect the specified images (bundle name or url)
  /// When an image is detected an ARImageAnchor will be added to the session.
  final List<ARKitReferenceImage>? detectionImages;

  /// Images to detect in the scene.
  /// If set the session will attempt to detect the specified images.
  /// When an image is detected an ARImageAnchor will be added to the session.
  final String? trackingImagesGroupName;

  /// Images to detect in the scene.
  /// If set the session will attempt to detect the specified images.
  /// When an image is detected an ARImageAnchor will be added to the session.
  final List<ARKitReferenceImage>? trackingImages;

  /// When set every user tap will be processed like user tapped on the center of the screen.
  /// The default is false.
  final bool forceUserTapOnCenter;

  /// Maximum number of images to track simultaneously.
  /// Setting the maximum number of tracked images will limit the number of images that can be tracked in a given frame.
  /// If more than the maximum is visible, only the images already being tracked will continue to track until tracking is lost or another image is removed.
  /// The default is 0
  final int maximumNumberOfTrackedImages;

  /// When true prints all communication between the plugin and the framework.
  /// The default is false;
  final bool debug;

  @override
  State<ARKitSceneView> createState() => _ARKitSceneViewState();
}

class _ARKitSceneViewState extends State<ARKitSceneView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'arkit',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text('$defaultTargetPlatform is not supported by this plugin');
  }

  Future<void> onPlatformViewCreated(int id) async {
    widget.onARKitViewCreated(ARKitController._init(
      id,
      widget.configuration,
      widget.environmentTexturing,
      widget.showStatistics,
      widget.autoenablesDefaultLighting,
      widget.enableTapRecognizer,
      widget.showFeaturePoints,
      widget.showWorldOrigin,
      widget.enablePinchRecognizer,
      widget.enablePanRecognizer,
      widget.enableRotationRecognizer,
      widget.planeDetection,
      widget.worldAlignment,
      widget.detectionImagesGroupName,
      widget.detectionImages,
      widget.trackingImagesGroupName,
      widget.trackingImages,
      widget.forceUserTapOnCenter,
      widget.maximumNumberOfTrackedImages,
      widget.debug,
    ));
  }
}

/// Controls an [ARKitSceneView].
///
/// An [ARKitController] instance can be obtained by setting the [ARKitSceneView.onARKitViewCreated]
/// callback for an [ARKitSceneView] widget.
class ARKitController {
  ARKitController._init(
    int id,
    ARKitConfiguration configuration,
    ARWorldTrackingConfigurationEnvironmentTexturing environmentTexturing,
    bool showStatistics,
    bool autoenablesDefaultLighting,
    bool enableTapRecognizer,
    bool showFeaturePoints,
    bool showWorldOrigin,
    bool enablePinchRecognizer,
    bool enablePanRecognizer,
    bool enableRotationRecognizer,
    ARPlaneDetection planeDetection,
    ARWorldAlignment worldAlignment,
    String? detectionImagesGroupName,
    List<ARKitReferenceImage>? detectionImages,
    String? trackingImagesGroupName,
    List<ARKitReferenceImage>? trackingImages,
    bool forceUserTapOnCenter,
    int maximumNumberOfTrackedImages,
    this.debug,
  ) {
    _channel = MethodChannel('arkit_$id');
    _channel.setMethodCallHandler(_platformCallHandler);
    _channel.invokeMethod<void>('init', {
      'configuration': configuration.index,
      'environmentTexturing': environmentTexturing.index,
      'showStatistics': showStatistics,
      'autoenablesDefaultLighting': autoenablesDefaultLighting,
      'enableTapRecognizer': enableTapRecognizer,
      'enablePinchRecognizer': enablePinchRecognizer,
      'enablePanRecognizer': enablePanRecognizer,
      'enableRotationRecognizer': enableRotationRecognizer,
      'planeDetection': planeDetection.index,
      'showFeaturePoints': showFeaturePoints,
      'showWorldOrigin': showWorldOrigin,
      'detectionImagesGroupName': detectionImagesGroupName,
      'detectionImages': detectionImages?.map((i) => i.toJson()).toList(),
      'trackingImagesGroupName': trackingImagesGroupName,
      'trackingImages': trackingImages?.map((i) => i.toJson()).toList(),
      'forceUserTapOnCenter': forceUserTapOnCenter,
      'worldAlignment': worldAlignment.index,
      'maximumNumberOfTrackedImages': maximumNumberOfTrackedImages,
    });
  }

  late MethodChannel _channel;

  /// This is called when a session fails.
  /// On failure the session will be paused.
  StringResultHandler? onError;

  /// This is called when a session is interrupted.
  /// A session will be interrupted and no longer able to track when
  /// it fails to receive required sensor data. This happens when video capture is interrupted,
  /// for example when the application is sent to the background or when there are
  /// multiple foreground applications (see AVCaptureSessionInterruptionReason).
  /// No additional frame updates will be delivered until the interruption has ended.
  VoidCallback? onSessionWasInterrupted;

  /// This is called when a session interruption has ended.
  /// A session will continue running from the last known state once
  /// the interruption has ended. If the device has moved, anchors will be misaligned.
  VoidCallback? onSessionInterruptionEnded;

  ARKitTapResultHandler? onNodeTap;
  ARKitHitResultHandler? onARTap;
  ARKitPinchGestureHandler? onNodePinch;
  ARKitPanResultHandler? onNodePan;
  ARKitRotationResultHandler? onNodeRotation;

  /// Called when a new node has been mapped to the given anchor.
  AnchorEventHandler? onAddNodeForAnchor;

  /// Called when a node will be updated with data from the given anchor.
  AnchorEventHandler? onUpdateNodeForAnchor;

  /// Called when a mapped node has been removed from the scene graph for the given anchor.
  AnchorEventHandler? onDidRemoveNodeForAnchor;

  /// Called once per frame
  Function(double time)? updateAtTime;

  /// Called when camera tracking state is changed;
  Function(ARTrackingState trackingState, ARTrackingStateReason? reason)?
      onCameraDidChangeTrackingState;

  /// This is called when the view deactivates, either manually or automatically
  /// Set this function to do any custom actions your app requires to begin
  /// the AR experience.
  /// For example, when coaching is deactivated, your app might restore custom UI.
  VoidCallback? coachingOverlayViewDidDeactivate;

  final bool debug;

  static const _boolConverter = ValueNotifierConverter();
  static const _vector3Converter = Vector3Converter();
  static const _matrixValueNotifierConverter = MatrixValueNotifierConverter();
  static const _matrixConverter = MatrixConverter();
  static const _materialsConverter = ListMaterialsValueNotifierConverter();
  static const _stateConverter = ARTrackingStateConverter();
  static const _stateReasonConverter = ARTrackingStateReasonConverter();

  void dispose() {
    _channel.invokeMethod<void>('dispose');
  }

  Future<void> add(ARKitNode node, {String? parentNodeName}) {
    final params = _addParentNodeNameToParams(node.toMap(), parentNodeName);
    _subsribeToChanges(node);
    return _channel.invokeMethod('addARKitNode', params);
  }

  Future<void> update(
    String nodeName, {
    ARKitNode? node,
    List<ARKitMaterial>? materials,
  }) {
    final params = <String, dynamic>{'nodeName': nodeName};
    if (node != null) {
      params.addAll(node.toMap());
    }
    if (materials != null) {
      params['materials'] = materials.map((e) => e.toJson()).toList();
    }
    return _channel.invokeMethod('onUpdateNode', params);
  }

  Future<void> remove(String nodeName) {
    return _channel.invokeMethod('removeARKitNode', {'nodeName': nodeName});
  }

  Future<void> removeAnchor(String anchorIdentifier) {
    return _channel.invokeMethod(
        'removeARKitAnchor', {'anchorIdentifier': anchorIdentifier});
  }

  /// Perform Hit Test
  /// defaults to center of the screen.
  /// x and y values are between 0 and 1
  Future<List<ARKitTestResult>> performHitTest(
      {required double x, required double y}) async {
    assert(x > 0 && y > 0);
    final results =
        await _channel.invokeListMethod('performHitTest', {'x': x, 'y': y});
    if (results == null) {
      return [];
    } else {
      final map = results.map((e) => Map<String, dynamic>.from(e));
      final objects = map.map((e) => ARKitTestResult.fromJson(e)).toList();
      return objects;
    }
  }

  /// Return list of 2 Vector3 elements, where first element - min value, last element - max value.
  Future<List<Vector3>> getNodeBoundingBox(ARKitNode node) async {
    final params = _addParentNodeNameToParams(node.toMap(), null);
    final result =
        await _channel.invokeListMethod('getNodeBoundingBox', params);
    final typed = result!.map((e) => List<double>.from(e));
    final vectors = typed.map((e) => _vector3Converter.fromJson(e));
    return vectors.toList();
  }

  Future<ARKitLightEstimate?> getLightEstimate() async {
    final estimate =
        await _channel.invokeMethod<Map<dynamic, dynamic>>('getLightEstimate');
    return estimate != null
        ? ARKitLightEstimate.fromJson(estimate.cast<String, double>())
        : null;
  }

  /// Updates the geometry with the vertices of a face geometry.
  void updateFaceGeometry(ARKitNode node, String fromAnchorId) {
    _channel.invokeMethod<void>(
        'updateFaceGeometry',
        _getHandlerParams(
            node, 'geometry', <String, dynamic>{'fromAnchorId': fromAnchorId}));
  }

  Future<Vector3?> projectPoint(Vector3 point) async {
    final projectPoint = await _channel.invokeListMethod<double>(
        'projectPoint', {'point': _vector3Converter.toJson(point)});
    return projectPoint != null
        ? _vector3Converter.fromJson(projectPoint)
        : null;
  }

  Future<Matrix4?> cameraProjectionMatrix() async {
    final cameraProjectionMatrix =
        await _channel.invokeListMethod<double>('cameraProjectionMatrix');
    return cameraProjectionMatrix != null
        ? _matrixConverter.fromJson(cameraProjectionMatrix)
        : null;
  }

  /// Provides the point of view transform in world space (relative to the scene's root node)
  Future<Matrix4?> pointOfViewTransform() async {
    final pointOfViewTransform =
        await _channel.invokeListMethod<double>('pointOfViewTransform');
    return pointOfViewTransform != null
        ? _matrixConverter.fromJson(pointOfViewTransform)
        : null;
  }

  Future<void> playAnimation(
      {required String key,
      required String sceneName,
      required String animationIdentifier}) {
    return _channel.invokeMethod('playAnimation', {
      'key': key,
      'sceneName': sceneName,
      'animationIdentifier': animationIdentifier,
    });
  }

  Future<void> stopAnimation({
    required String key,
  }) {
    return _channel.invokeMethod('stopAnimation', {
      'key': key,
    });
  }

  /// A view that displays standardized onboarding instructions to direct users toward a specific goal.
  /// The view will use context aware messaging and animations to instruct the user on gathering required info for the AR session.
  /// Requires iOS 13 and above.
  Future<void> addCoachingOverlay(CoachingOverlayGoal goal) =>
      _channel.invokeMethod('addCoachingOverlay', {
        'goal': goal.index,
      });

  Future<void> removeCoachingOverlay() =>
      _channel.invokeMethod('removeCoachingOverlay');

  Map<String, dynamic> _addParentNodeNameToParams(
      Map geometryMap, String? parentNodeName) {
    if (parentNodeName?.isNotEmpty ?? false) {
      geometryMap['parentNodeName'] = parentNodeName;
    }
    return geometryMap as Map<String, dynamic>;
  }

  Future<void> _platformCallHandler(MethodCall call) {
    if (debug) {
      debugPrint('_platformCallHandler call ${call.method} ${call.arguments}');
    }
    try {
      switch (call.method) {
        case 'onError':
          if (onError != null) {
            onError!(call.arguments);
            debugPrint(call.arguments);
          }
          break;
        case 'onNodeTap':
          if (onNodeTap != null) {
            final list = call.arguments as List<dynamic>;
            onNodeTap!(list.map((e) => e.toString()).toList());
          }
          break;
        case 'onARTap':
          if (onARTap != null) {
            final input = call.arguments as List<dynamic>;
            final map1 =
                input.map((e) => Map<String, dynamic>.from(e)).toList();
            final map2 = map1.map((e) {
              return ARKitTestResult.fromJson(e);
            }).toList();
            onARTap!(map2);
          }
          break;
        case 'onNodePinch':
          if (onNodePinch != null) {
            final List<dynamic> input = call.arguments;
            final listMap = input.map((e) => Map<String, dynamic>.from(e));
            final objects =
                listMap.map((e) => ARKitNodePinchResult.fromJson(e));
            onNodePinch!(objects.toList());
          }
          break;
        case 'onNodePan':
          if (onNodePan != null) {
            final List<dynamic> input = call.arguments;
            final listMap = input.map((e) => Map<String, dynamic>.from(e));
            final objects = listMap.map((e) => ARKitNodePanResult.fromJson(e));
            onNodePan!(objects.toList());
          }
          break;
        case 'onNodeRotation':
          if (onNodeRotation != null) {
            final List<dynamic> input = call.arguments;
            final listMap = input.map((e) => Map<String, dynamic>.from(e));
            final objects =
                listMap.map((e) => ARKitNodeRotationResult.fromJson(e));
            onNodeRotation!(objects.toList());
          }
          break;
        case 'didAddNodeForAnchor':
          if (onAddNodeForAnchor != null) {
            final anchor =
                ARKitAnchor.fromJson(Map<String, dynamic>.from(call.arguments));
            onAddNodeForAnchor!(anchor);
          }
          break;
        case 'didUpdateNodeForAnchor':
          if (onUpdateNodeForAnchor != null) {
            final anchor =
                ARKitAnchor.fromJson(Map<String, dynamic>.from(call.arguments));
            onUpdateNodeForAnchor!(anchor);
          }
          break;
        case 'didRemoveNodeForAnchor':
          if (onDidRemoveNodeForAnchor != null) {
            final anchor =
                ARKitAnchor.fromJson(Map<String, dynamic>.from(call.arguments));
            onDidRemoveNodeForAnchor!(anchor);
          }
          break;
        case 'updateAtTime':
          if (updateAtTime != null) {
            final double time = call.arguments['time'];
            updateAtTime!(time);
          }
          break;
        case 'onCameraDidChangeTrackingState':
          if (onCameraDidChangeTrackingState != null) {
            final int rawTrackingState = call.arguments['trackingState'];
            final trackingState = _stateConverter.fromJson(rawTrackingState);

            final int? rawReason = call.arguments['reason'];
            final reason = _stateReasonConverter.fromJson(rawReason);

            onCameraDidChangeTrackingState!(trackingState, reason);
          }
          break;
        case 'coachingOverlayViewDidDeactivate':
          coachingOverlayViewDidDeactivate?.call();
          break;
        default:
          if (debug) {
            debugPrint('Unknowm method ${call.method} ');
          }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return Future.value();
  }

  void _subsribeToChanges(ARKitNode node) {
    node.transformNotifier
        .addListener(() => _handleTransformationChanged(node));
    node.isHidden.addListener(() => _handleIsHiddenChanged(node));

    if (node.geometry != null) {
      node.geometry!.materials.addListener(() => _updateMaterials(node));
      switch (node.geometry.runtimeType) {
        case ARKitPlane:
          _subscribeToPlaneGeometry(node);
          break;
        case ARKitSphere:
          _subscribeToSphereGeometry(node);
          break;
        case ARKitText:
          _subscribeToTextGeometry(node);
          break;
        case ARKitBox:
          _subscribeToBoxGeometry(node);
          break;
        case ARKitCylinder:
          _subscribeToCylinderGeometry(node);
          break;
        case ARKitCone:
          _subscribeToConeGeometry(node);
          break;
        case ARKitPyramid:
          _subscribeToPyramidGeometry(node);
          break;
        case ARKitTube:
          _subscribeToTubeGeometry(node);
          break;
        case ARKitTorus:
          _subscribeToTorusGeometry(node);
          break;
        case ARKitCapsule:
          _subscribeToCapsuleGeometry(node);
          break;
      }
    }
    if (node.light != null) {
      node.light!.intensity.addListener(() => _updateSingleProperty(
          node, 'intensity', node.light!.intensity.value, 'light'));
    }
  }

  void _subscribeToCapsuleGeometry(ARKitNode node) {
    final capsule = node.geometry as ARKitCapsule;
    capsule.capRadius.addListener(() => _updateSingleProperty(
        node, 'capRadius', capsule.capRadius.value, 'geometry'));
    capsule.height.addListener(() => _updateSingleProperty(
        node, 'height', capsule.height.value, 'geometry'));
  }

  void _subscribeToTorusGeometry(ARKitNode node) {
    final torus = node.geometry as ARKitTorus;
    torus.pipeRadius.addListener(() => _updateSingleProperty(
        node, 'pipeRadius', torus.pipeRadius.value, 'geometry'));
    torus.ringRadius.addListener(() => _updateSingleProperty(
        node, 'ringRadius', torus.ringRadius.value, 'geometry'));
  }

  void _subscribeToTubeGeometry(ARKitNode node) {
    final tube = node.geometry as ARKitTube;
    tube.innerRadius.addListener(() => _updateSingleProperty(
        node, 'innerRadius', tube.innerRadius.value, 'geometry'));
    tube.outerRadius.addListener(() => _updateSingleProperty(
        node, 'outerRadius', tube.outerRadius.value, 'geometry'));
    tube.height.addListener(() =>
        _updateSingleProperty(node, 'height', tube.height.value, 'geometry'));
  }

  void _subscribeToPyramidGeometry(ARKitNode node) {
    final pyramid = node.geometry as ARKitPyramid;
    pyramid.width.addListener(() =>
        _updateSingleProperty(node, 'width', pyramid.width.value, 'geometry'));
    pyramid.height.addListener(() => _updateSingleProperty(
        node, 'height', pyramid.height.value, 'geometry'));
    pyramid.length.addListener(() => _updateSingleProperty(
        node, 'length', pyramid.length.value, 'geometry'));
  }

  void _subscribeToConeGeometry(ARKitNode node) {
    final cone = node.geometry as ARKitCone;
    cone.topRadius.addListener(() => _updateSingleProperty(
        node, 'topRadius', cone.topRadius.value, 'geometry'));
    cone.bottomRadius.addListener(() => _updateSingleProperty(
        node, 'bottomRadius', cone.bottomRadius.value, 'geometry'));
    cone.height.addListener(() =>
        _updateSingleProperty(node, 'height', cone.height.value, 'geometry'));
  }

  void _subscribeToCylinderGeometry(ARKitNode node) {
    final cylinder = node.geometry as ARKitCylinder;
    cylinder.radius.addListener(() => _updateSingleProperty(
        node, 'radius', cylinder.radius.value, 'geometry'));
    cylinder.height.addListener(() => _updateSingleProperty(
        node, 'height', cylinder.height.value, 'geometry'));
  }

  void _subscribeToBoxGeometry(ARKitNode node) {
    final box = node.geometry as ARKitBox;
    box.width.addListener(() =>
        _updateSingleProperty(node, 'width', box.width.value, 'geometry'));
    box.height.addListener(() =>
        _updateSingleProperty(node, 'height', box.height.value, 'geometry'));
    box.length.addListener(() =>
        _updateSingleProperty(node, 'length', box.length.value, 'geometry'));
  }

  void _subscribeToTextGeometry(ARKitNode node) {
    final text = node.geometry as ARKitText;
    text.text.addListener(
        () => _updateSingleProperty(node, 'text', text.text.value, 'geometry'));
  }

  void _subscribeToSphereGeometry(ARKitNode node) {
    final sphere = node.geometry as ARKitSphere;
    sphere.radius.addListener(() =>
        _updateSingleProperty(node, 'radius', sphere.radius.value, 'geometry'));
  }

  void _subscribeToPlaneGeometry(ARKitNode node) {
    final plane = node.geometry as ARKitPlane;
    plane.width.addListener(() =>
        _updateSingleProperty(node, 'width', plane.width.value, 'geometry'));
    plane.height.addListener(() =>
        _updateSingleProperty(node, 'height', plane.height.value, 'geometry'));
  }

  void _handleTransformationChanged(ARKitNode node) {
    _channel.invokeMethod<void>(
        'transformationChanged',
        _getHandlerParams(node, 'transformation',
            _matrixValueNotifierConverter.toJson(node.transformNotifier)));
  }

  void _handleIsHiddenChanged(ARKitNode node) {
    _channel.invokeMethod<void>(
        'isHiddenChanged',
        _getHandlerParams(
            node, 'isHidden', _boolConverter.toJson(node.isHidden)));
  }

  void _updateMaterials(ARKitNode node) {
    final materials = _materialsConverter.toJson(node.geometry!.materials);
    _channel.invokeMethod<void>(
        'updateMaterials', _getHandlerParams(node, 'materials', materials));
  }

  void _updateSingleProperty(
      ARKitNode node, String propertyName, dynamic value, String keyProperty) {
    _channel.invokeMethod<void>(
        'updateSingleProperty',
        _getHandlerParams(node, 'property', <String, dynamic>{
          'propertyName': propertyName,
          'propertyValue': value,
          'keyProperty': keyProperty,
        }));
  }

  Map<String, dynamic> _getHandlerParams(
      ARKitNode node, String paramName, dynamic params) {
    final values = <String, dynamic>{'name': node.name}
      ..addAll({paramName: params});
    return values;
  }

  Future<Vector3> getCameraEulerAngles() async {
    final result = await _channel.invokeListMethod('cameraEulerAngles');
    final vector3 = _vector3Converter.fromJson(result!);
    return vector3;
  }

  Future<ImageProvider> snapshot() async {
    final result = await _channel.invokeMethod<Uint8List>('snapshot');
    return MemoryImage(result!);
  }

  Future<Vector3?> cameraPosition() async {
    final result = await _channel.invokeListMethod('cameraPosition');
    if (result != null) {
      return _vector3Converter.fromJson(result);
    } else {
      return null;
    }
  }
}
