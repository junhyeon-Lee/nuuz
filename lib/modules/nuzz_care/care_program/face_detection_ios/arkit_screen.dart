import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
///이 변수를 통해 현재 part와 line을 설정합니다.
int wantLine = 0;
String wantPart = '3mm Left Cheek A';
int wantPartIndex = 0;
List<String> wantParts = [
'3mm Left Cheek A','3mm Left Cheek Horizontal', '3mm Right Cheek A','3mm Right Cheek Horizontal',
'3mm Left Feet Vertical', '3mm Left Feet Horizontal','3mm Right Feet Vertical', '3mm Right Feet Horizontal',
'3mm Left Nasolabial', '3mm Right Nasolabial',
  '3mm Left Tear','3mm Right Tear', '3mm Forehead',
];




class ArkitScreen extends ConsumerStatefulWidget {


  const ArkitScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ArkitScreen> createState() => _ArkitScreenState();
}

class _ArkitScreenState extends ConsumerState<ArkitScreen> {

  late ARKitController arkitController;
  List<ARKitNode> points = [];

  @override
  void initState() {
    viewTransformationController = TransformationController(scaleMatrix);
    viewTransformationController.value.setEntry(0, 0, zoomFactor);
    viewTransformationController.value.setEntry(1, 1, zoomFactor);
    viewTransformationController.value.setEntry(2, 2, zoomFactor);
    viewTransformationController.value.setEntry(0, 3, -195.w);
    viewTransformationController.value.setEntry(1, 3, -422.h);
    for(int i=0; i<10; i++){
      ///개발이 완료되면 i=10
      points.add(ARKitNode());
    }
    super.initState();
  }

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  final scaleMatrix = Matrix4.identity()..scale(1.7);
  final zoomFactor = 1.7;
  final yTranslate = 300.0;
  late TransformationController viewTransformationController ;
  @override
  Widget build(BuildContext context) => Scaffold(
    body:
    InteractiveViewer(
      panEnabled: false,
      scaleEnabled: false,
      transformationController: viewTransformationController,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ARKitSceneView(

          configuration: ARKitConfiguration.faceTracking,
          onARKitViewCreated: onARKitViewCreated,
        ),
      ),
    ),

    //
    // Column(
    //   children: [
    //     Stack(alignment: Alignment.topCenter,
    //       children: [
    //         InteractiveViewer(
    //           panEnabled: false,
    //           scaleEnabled: false,
    //           transformationController: viewTransformationController,
    //           child: SizedBox(
    //             width: MediaQuery.of(context).size.width,
    //             height: MediaQuery.of(context).size.height,
    //             child: ARKitSceneView(
    //
    //               configuration: ARKitConfiguration.faceTracking,
    //               onARKitViewCreated: onARKitViewCreated,
    //             ),
    //           ),
    //         ),
    //
    //         ///가이드 띄우기
    //         ///face guide
    //         Positioned(
    //           top: 131.h,
    //           child: Stack(alignment: Alignment.topCenter,
    //             children: [
    //               if(ref.watch(deviceAnimationProvider)!='else')
    //                 Container(
    //                     width: 390.w,
    //                     height: 530.h,
    //                     child: rive.RiveAnimation.asset(
    //                       ref.watch(deviceAnimationProvider),
    //                       fit: BoxFit.fitWidth,
    //                     )),
    //               SizedBox(
    //                 width: 390.w,
    //                 height: 530.h,
    //                 child: SvgPicture.asset(
    //                   ref.watch(guildImageProvider),
    //                   fit: BoxFit.fitWidth,
    //                 ),
    //               ),
    //               Positioned.fill(
    //                 child: SizedBox(
    //                     width: 390.w,
    //                     height: 530.h,
    //                     child: rive.RiveAnimation.asset(
    //                       ref.watch(guideAnimationProvider),
    //                       fit: BoxFit.fitWidth,
    //                     )),
    //               ),
    //             ],
    //           )
    //         ),
    //
    //         Positioned( bottom: 0,
    //           child: Padding(
    //             padding: const EdgeInsets.only(bottom: 30.0),
    //             child: Column(
    //               children: [
    //                 Text('part: $wantPart  line: $wantLine', style: CustomTextStyle.buttonM.copyWith(color: Colors.white),),
    //                 hSize(10),
    //                 Row(mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     GestureDetector(
    //                       onTap : (){
    //                         safePrint('change part');
    //                         setState(() {
    //                           wantLine =0;
    //                           if(wantPartIndex==wantParts.length-1){
    //                             wantPartIndex = 0;
    //                           }else{
    //                             wantPartIndex++;
    //                           }
    //                           wantPart = wantParts[wantPartIndex];
    //                           ref.watch(guildImageProvider.notifier).setGuideImage(wantPart, wantLine+1);
    //                           ref.watch(guideAnimationProvider.notifier).setGuideImage(wantPart);
    //                           ref.watch(deviceAnimationProvider.notifier).setDeviceGuideImage(wantPart);
    //
    //                         });
    //                       },
    //                       child: CustomContainer(width: 100, height: 100, containerColor: CustomColor.gray,
    //                       borderColor: CustomColor.dark,
    //                       child: const Center(child: Text('change part'),),
    //                       ),
    //                     ),
    //                     wSize(20),
    //                     GestureDetector(
    //                       onTap : (){
    //                         safePrint('change line');
    //                         setState(() {
    //                           if(wantLine==7){
    //                             wantLine = 0;
    //                           }else{
    //                             wantLine++;
    //                           }
    //
    //                         });
    //                       },
    //                       child: CustomContainer(width: 100, height: 100, containerColor: CustomColor.gray,
    //                         borderColor: CustomColor.dark,
    //                         child: const Center(child: Text('change line'),),),
    //                     )
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is! ARKitFaceAnchor) {
      return;
    }
    final material = ARKitMaterial(fillMode: ARKitFillMode.lines);
    anchor.geometry.materials.value = [material];

    ///10개의 노드를 생성하고 arkit에 추가합니다.
    points[0] = _foreheadPoint1(anchor ,0)!;
    points[1] = _foreheadPoint1(anchor ,1)!;
    points[2] = _foreheadPoint1(anchor ,2)!;
    points[3] = _foreheadPoint1(anchor ,3)!;
    points[4] = _foreheadPoint1(anchor ,4)!;
    points[5] = _foreheadPoint1(anchor ,5)!;
    points[6] = _foreheadPoint1(anchor ,6)!;
    points[7] = _foreheadPoint1(anchor ,7)!;
    points[8] = _foreheadPoint1(anchor ,8)!;
    points[9] = _foreheadPoint1(anchor ,9)!;

    arkitController.add(points[0], parentNodeName: anchor.nodeName);
    arkitController.add(points[1], parentNodeName: anchor.nodeName);
    arkitController.add(points[2], parentNodeName: anchor.nodeName);
    arkitController.add(points[3], parentNodeName: anchor.nodeName);
    arkitController.add(points[4], parentNodeName: anchor.nodeName);
    arkitController.add(points[5], parentNodeName: anchor.nodeName);
    arkitController.add(points[6], parentNodeName: anchor.nodeName);
    arkitController.add(points[7], parentNodeName: anchor.nodeName);
    arkitController.add(points[8], parentNodeName: anchor.nodeName);
    arkitController.add(points[9], parentNodeName: anchor.nodeName);

  }

  ///forehead 이마
  ARKitNode? _foreheadPoint0(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.02, anchor.geometryVertices[20].z);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i<5){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x-0.05, position1.y+y+0.005, position1.z-0.004), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.05, position1.y+0.005, position1.z-0.004), name:0.toString());
    }


  }
  ARKitNode? _foreheadPoint1(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.004, anchor.geometryVertices[20].z);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x-0.036, position1.y+y+0.005, position1.z-0.004 ), name:i.toString());
  }
  ARKitNode? _foreheadPoint2(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.007, anchor.geometryVertices[20].z);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x-0.022, position1.y+y+0.005, position1.z-0.002), name:i.toString());
  }
  ARKitNode? _foreheadPoint3(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.01, anchor.geometryVertices[20].z);

   double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x-0.008, position1.y+y+0.005, position1.z), name:i.toString());
  }
  ARKitNode? _foreheadPoint4(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.01, anchor.geometryVertices[20].z);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x+0.008, position1.y+y+0.005, position1.z), name:i.toString());
  }
  ARKitNode? _foreheadPoint5(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.007, anchor.geometryVertices[20].z);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x+0.022, position1.y+y+0.005, position1.z-0.002), name:i.toString());
  }
  ARKitNode? _foreheadPoint6(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.004, anchor.geometryVertices[20].z);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x+0.036, position1.y+y+0.005, position1.z-0.004), name:i.toString());
  }
  ARKitNode? _foreheadPoint7(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[19];
    final position2 =  vector.Vector3(anchor.geometryVertices[20].x, anchor.geometryVertices[20].y+0.02, anchor.geometryVertices[20].z);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i<5){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x+0.05, position1.y+y+0.005, position1.z-0.004), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.05, position1.y+0.005, position1.z-0.004), name:0.toString());
    }


  }

  ARKitNode? _tearLeftPoint(ARKitAnchor anchor, int i) {
    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    List<vector.Vector3> position = [
    anchor.geometryVertices[1137],
    anchor.geometryVertices[1138],
    anchor.geometryVertices[1139],
    anchor.geometryVertices[1140],
    anchor.geometryVertices[1141],
    anchor.geometryVertices[1142],
    anchor.geometryVertices[1143],
    anchor.geometryVertices[1144],
    anchor.geometryVertices[1145],
    anchor.geometryVertices[1146]
    ];
    final sphere = ARKitBox(width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: position[i], name:i.toString());



  }
  ARKitNode? _tearRightPoint(ARKitAnchor anchor, int i) {
    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    List<vector.Vector3> position = [
      anchor.geometryVertices[1111],
      anchor.geometryVertices[1112],
      anchor.geometryVertices[1113],
      anchor.geometryVertices[1114],
      anchor.geometryVertices[1115],
      anchor.geometryVertices[1116],
      anchor.geometryVertices[1117],
      anchor.geometryVertices[1118],
      anchor.geometryVertices[1119],
      anchor.geometryVertices[1120]
    ];
    final sphere = ARKitBox(width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    return ARKitNode(geometry: sphere, position: position[i], name:i.toString());



  }

  ARKitNode? _crowLeftVerticalPoint(ARKitAnchor anchor, int j) {

    int i = j;
    j<5? i = j:i=j-5;

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[216];
    final position2 =  anchor.geometryVertices[214];

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/4;
    }else{
      x = x*i/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/4;
    }else{
      y = y*i/4;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/4;
    }else{
      z = z*i/4;
    }

    final sphere = ARKitBox(
        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x, position1.y+y, position1.z-0.004), name:i.toString());



  }
  ARKitNode? _crowRightVerticalPoint(ARKitAnchor anchor, int j) {
    int i = j;
    j<5? i = j:i=j-5;
    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[1013];
    final position2 =  anchor.geometryVertices[1011];

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/4;
    }else{
      x = x*i/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/4;
    }else{
      y = y*i/4;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/4;
    }else{
      z = z*i/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x, position1.y+y, position1.z-0.004), name:i.toString());



  }
  ARKitNode? _crowLeftHorizonPoint(ARKitAnchor anchor, int j) {
    int i = j;
    j<5? i = j:i=j-5;
    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[946];
    final position2 =  anchor.geometryVertices[234];

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/4;
    }else{
      x = x*i/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/4;
    }else{
      y = y*i/4;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/4;
    }else{
      z = z*i/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x, position1.y+y, position1.z+z-0.004), name:i.toString());



  }
  ARKitNode? _crowRightHorizonPoint(ARKitAnchor anchor, int j) {
    int i = j;
    j<5? i = j:i=j-5;
    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final position1 =  anchor.geometryVertices[669];
    final position2 =  anchor.geometryVertices[942];

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/4;
    }else{
      x = x*i/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/4;
    }else{
      y = y*i/4;
    }
    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/4;
    }else{
      z = z*i/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x, position1.y+y, position1.z+z-0.004), name:i.toString());



  }

  ARKitNode? _cheekLeftVerticalPoint0(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final basePosition1 =  anchor.geometryVertices[472];
    final basePosition2 =  anchor.geometryVertices[413];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

      return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x, point1.y+y-0.015+0.01, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekLeftVerticalPoint1(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }



    final basePosition1 =  anchor.geometryVertices[472];
    final basePosition2 =  anchor.geometryVertices[413];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (basePosition1.z- basePosition2.z).abs();
    z = z/3;

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x-0.01, point1.y+y-0.005+0.01, point1.z-z), name:i.toString());




  }
  ARKitNode? _cheekLeftVerticalPoint2(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }



    final basePosition1 =  anchor.geometryVertices[472];
    final basePosition2 =  anchor.geometryVertices[413];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (basePosition1.z- basePosition2.z).abs();
    z = z/3*2;

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x-0.02, point1.y+y+0.005+0.01, point1.z-z), name:i.toString());




  }
  ARKitNode? _cheekLeftVerticalPoint3(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }



    final basePosition1 =  anchor.geometryVertices[472];
    final basePosition2 =  anchor.geometryVertices[413];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (basePosition1.z- basePosition2.z).abs();


    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x-0.03, point1.y+y+0.015+0.01, point1.z-z), name:i.toString());




  }

  ARKitNode? _cheekRightVerticalPoint0(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final basePosition1 =  anchor.geometryVertices[627];
    final basePosition2 =  anchor.geometryVertices[842];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x, point1.y+y-0.015, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekRightVerticalPoint1(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }



    final basePosition1 =  anchor.geometryVertices[1046];
    final basePosition2 =  anchor.geometryVertices[843];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (basePosition1.z- basePosition2.z).abs();
    z = z/3;

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x+0.01, point1.y+y-0.005, point1.z-z), name:i.toString());




  }
  ARKitNode? _cheekRightVerticalPoint2(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }



    final basePosition1 =  anchor.geometryVertices[1046];
    final basePosition2 =  anchor.geometryVertices[843];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (basePosition1.z- basePosition2.z).abs();
    z = z/3*2;

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x+0.02, point1.y+y+0.005, point1.z-z), name:i.toString());




  }
  ARKitNode? _cheekRightVerticalPoint3(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }



    final basePosition1 =  anchor.geometryVertices[1046];
    final basePosition2 =  anchor.geometryVertices[843];

    final point1 =vector.Vector3(basePosition2.x, basePosition1.y, basePosition2.z);
    final point2 = vector.Vector3(basePosition2.x, basePosition2.y, basePosition2.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (basePosition1.z- basePosition2.z).abs();


    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x+0.03, point1.y+y+0.015, point1.z-z), name:i.toString());




  }

  ARKitNode? _cheekLeftHorizonPoint0(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final basePosition1 =  anchor.geometryVertices[353];
    final basePosition2 =  anchor.geometryVertices[411];

    final point1 =vector.Vector3(basePosition2.x+0.015, basePosition1.y-0.015, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x, point1.y+y, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekLeftHorizonPoint1(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final basePosition1 =  anchor.geometryVertices[353];
    final basePosition2 =  anchor.geometryVertices[411];

    final point1 =vector.Vector3(basePosition2.x+0.015, basePosition1.y-0.015, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }
    double baseY = (basePosition1.y- basePosition2.y).abs();
    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x-0.01, point1.y+y-baseY/3+0.005, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekLeftHorizonPoint2(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final basePosition1 =  anchor.geometryVertices[353];
    final basePosition2 =  anchor.geometryVertices[411];

    final point1 =vector.Vector3(basePosition2.x+0.015, basePosition1.y-0.015, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    double baseY = (basePosition1.y- basePosition2.y).abs();

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x-0.012, point1.y+y-baseY/3*2+0.008, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekLeftHorizonPoint3(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final basePosition1 =  anchor.geometryVertices[353];
    final basePosition2 =  anchor.geometryVertices[411];

    final point1 =vector.Vector3(basePosition2.x+0.015, basePosition1.y-0.015, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    double baseY = (basePosition1.y- basePosition2.y).abs();

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x-0.02, point1.y+y-baseY+0.015, point1.z+z), name:i.toString());




  }

  ARKitNode? _cheekRightHorizonPoint0(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final basePosition1 =  anchor.geometryVertices[784];
    final basePosition2 =  anchor.geometryVertices[841];

    final point1 =vector.Vector3(basePosition2.x-0.02, basePosition1.y-0.017, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y-0.008, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x, point1.y+y, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekRightHorizonPoint1(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }



    final basePosition1 =  anchor.geometryVertices[784];
    final basePosition2 =  anchor.geometryVertices[841];

    final point1 =vector.Vector3(basePosition2.x-0.02, basePosition1.y-0.017, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y-0.008, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }
    double baseY = (basePosition1.y- basePosition2.y).abs();
    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x, point1.y+y-baseY/3, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekRightHorizonPoint2(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final basePosition1 =  anchor.geometryVertices[784];
    final basePosition2 =  anchor.geometryVertices[841];

    final point1 =vector.Vector3(basePosition2.x-0.02, basePosition1.y-0.017, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y-0.008, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    double baseY = (basePosition1.y- basePosition2.y).abs();

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x, point1.y+y-baseY/3*2+0.002, point1.z+z), name:i.toString());




  }
  ARKitNode? _cheekRightHorizonPoint3(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }
    final basePosition1 =  anchor.geometryVertices[784];
    final basePosition2 =  anchor.geometryVertices[841];

    final point1 =vector.Vector3(basePosition2.x-0.02, basePosition1.y-0.017, basePosition2.z);
    final point2 = vector.Vector3(basePosition1.x, basePosition1.y-0.008, basePosition1.z);

    double x = (point1.x - point2.x).abs();
    if(point1.x > point2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (point1.y - point2.y).abs();
    if(point1.y > point2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }
    double z = (point1.z- point2.z).abs();
    if(point1.z > point2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    double baseY = (basePosition1.y- basePosition2.y).abs();

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);

    return ARKitNode(geometry: sphere, position: vector.Vector3(point1.x+x+0.01, point1.y+y-baseY+0.01, point1.z+z), name:i.toString());




  }

  ARKitNode? _nasolabialLeft0(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[320];
    final position2 = anchor.geometryVertices[60];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005, position1.y-gi*0.005+0.005, position1.z), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x, position1.y+0.005, position1.z), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005, position1.y+gi*0.005+0.005, position1.z), name:i.toString());
    }

  }
  ARKitNode? _nasolabialLeft1(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[320];
    final position2 = anchor.geometryVertices[60];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x, position1.y-gi*0.005+y+0.003, position1.z+z), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x, position1.y+y+0.003, position1.z+z), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x, position1.y+gi*0.005+y+0.003, position1.z+z), name:i.toString());
    }

  }
  ARKitNode? _nasolabialLeft2(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[320];
    final position2 = anchor.geometryVertices[60];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x*2, position1.y-gi*0.005+y*2, position1.z+z*2), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x*2, position1.y+y*2, position1.z+z*2), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x*2, position1.y+gi*0.005+y*2, position1.z+z*2), name:i.toString());
    }

  }
  ARKitNode? _nasolabialLeft3(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[320];
    final position2 = anchor.geometryVertices[60];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x*3, position1.y-gi*0.005+y*3-0.003, position1.z+z*3), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x*3, position1.y+y*3-0.003, position1.z+z*3), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x*3, position1.y+gi*0.005+y*3-0.003, position1.z+z*3), name:i.toString());
    }

  }
  ARKitNode? _nasolabialLeft4(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[320];
    final position2 = anchor.geometryVertices[60];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x*4+0.01, position1.y-gi*0.005+y*4-0.004, position1.z+z*4), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x*4+0.01, position1.y+y*4-0.004, position1.z+z*4), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x*4+0.01, position1.y+gi*0.005+y*4-0.004, position1.z+z*4), name:i.toString());
    }

  }

  ARKitNode? _nasolabialRight0(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[755];
    final position2 = anchor.geometryVertices[509];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x*i/9;
    }else{
      x = x*i/9;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y*i/9;
    }else{
      y = y*i/9;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z*i/9;
    }else{
      z = z*i/9;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+0.001, position1.y-gi*0.005, position1.z), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.001, position1.y, position1.z), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+0.001, position1.y+gi*0.005, position1.z), name:i.toString());
    }

  }
  ARKitNode? _nasolabialRight1(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[755];
    final position2 = anchor.geometryVertices[509];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x+0.001, position1.y-gi*0.005+y-0.002, position1.z+z), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x+0.001, position1.y+y-0.002, position1.z+z), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x+0.001, position1.y+gi*0.005+y-0.002, position1.z+z), name:i.toString());
    }

  }
  ARKitNode? _nasolabialRight2(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[755];
    final position2 = anchor.geometryVertices[509];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x*2-0.001, position1.y-gi*0.005+y*2-0.005, position1.z+z*2), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x*2-0.001, position1.y+y*2-0.005, position1.z+z*2), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x*2-0.001, position1.y+gi*0.005+y*2-0.005, position1.z+z*2), name:i.toString());
    }

  }
  ARKitNode? _nasolabialRight3(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[755];
    final position2 = anchor.geometryVertices[509];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x*3, position1.y-gi*0.005+y*3-0.01, position1.z+z*3), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x*3, position1.y+y*3-0.01, position1.z+z*3), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x*3, position1.y+gi*0.005+y*3-0.01, position1.z+z*3), name:i.toString());
    }

  }
  ARKitNode? _nasolabialRight4(ARKitAnchor anchor, int i) {

    if (anchor is! ARKitFaceAnchor) {
      return null;
    }

    final position1 =anchor.geometryVertices[755];
    final position2 = anchor.geometryVertices[509];
    double gi = -(position1.x-position2.x)/(position1.y-position2.y);

    double x = (position1.x - position2.x).abs();
    if(position1.x > position2.x){
      x = -x/4;
    }else{
      x = x/4;
    }
    double y = (position1.y - position2.y).abs();
    if(position1.y > position2.y){
      y = -y/4;
    }else{
      y = y/4;
    }



    double z = (position1.z- position2.z).abs();
    if(position1.z > position2.z){
      z = -z/4;
    }else{
      z = z/4;
    }

    final sphere = ARKitBox(

        width: 0.003, height: 0.003, length: 0.003, chamferRadius:100);
    if(i%3==0){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x-0.005+x*4-0.018, position1.y-gi*0.005+y*4-0.014, position1.z+z*4), name:i.toString());
    }else if(i%3==1){
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+x*4-0.018, position1.y+y*4-0.014, position1.z+z*4), name:i.toString());
    }else{
      return ARKitNode(geometry: sphere, position: vector.Vector3(position1.x+0.005+x*4-0.018, position1.y+gi*0.005+y*4-0.014, position1.z+z*4), name:i.toString());
    }

  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitFaceAnchor && mounted) {
      for(int i=0; i<10; i++){
        ARKitNode? position;
        if(wantPart == '3mm Forehead'){
          switch(wantLine){
            case 0:   position =  _foreheadPoint0( anchor, i); break;
            case 1:   position =  _foreheadPoint1( anchor, i); break;
            case 2:   position =  _foreheadPoint2( anchor, i); break;
            case 3:   position =  _foreheadPoint3( anchor, i); break;
            case 4:   position =  _foreheadPoint4( anchor, i); break;
            case 5:   position =  _foreheadPoint5( anchor, i); break;
            case 6:   position =  _foreheadPoint6( anchor, i); break;
            case 7:   position =  _foreheadPoint7( anchor, i); break;
          }
        }else if(wantPart == '3mm Left Tear'){
          position =  _tearLeftPoint( anchor, i);
        }else if(wantPart == '3mm Right Tear'){
          position =  _tearRightPoint( anchor, i);
        }else if(wantPart == '3mm Left Feet Vertical'){
          position =  _crowLeftVerticalPoint( anchor, i);
        }else if(wantPart == '3mm Right Feet Vertical'){
          position =  _crowRightVerticalPoint( anchor, i);
        }else if(wantPart == '3mm Left Feet Horizontal'){
          position =  _crowLeftHorizonPoint( anchor, i);
        }else if(wantPart == '3mm Right Feet Horizontal'){
          position =  _crowRightHorizonPoint( anchor, i);
        }else if(wantPart == '3mm Left Cheek A'){
          switch(wantLine){
            case 1:   position =  _cheekLeftVerticalPoint0( anchor, i); break;
            case 2:   position =  _cheekLeftVerticalPoint1( anchor, i); break;
            case 3:   position =  _cheekLeftVerticalPoint2( anchor, i); break;
            case 4:   position =  _cheekLeftVerticalPoint3( anchor, i); break;
          }
        }else if(wantPart == '3mm Right Cheek A'){
          switch(wantLine){
            case 1:   position =  _cheekRightVerticalPoint0( anchor, i); break;
            case 2:   position =  _cheekRightVerticalPoint1( anchor, i); break;
            case 3:   position =  _cheekRightVerticalPoint2( anchor, i); break;
            case 4:   position =  _cheekRightVerticalPoint3( anchor, i); break;
          }
        } else if(wantPart == '3mm Left Cheek Horizontal'){
          switch(wantLine){
            case 1:   position =  _cheekLeftHorizonPoint0( anchor, i); break;
            case 2:   position =  _cheekLeftHorizonPoint1( anchor, i); break;
            case 3:   position =  _cheekLeftHorizonPoint2( anchor, i); break;
            case 4:   position =  _cheekLeftHorizonPoint3( anchor, i); break;
          }
        }else if(wantPart == '3mm Right Cheek Horizontal'){
          switch(wantLine){
            case 1:   position =  _cheekRightHorizonPoint0( anchor, i); break;
            case 2:   position =  _cheekRightHorizonPoint1( anchor, i); break;
            case 3:   position =  _cheekRightHorizonPoint2( anchor, i); break;
            case 4:   position =  _cheekRightHorizonPoint3( anchor, i); break;
          }
        }else if(wantPart == '3mm Left Nasolabial'){
          switch(wantLine){
            case 1:   position =  _nasolabialLeft0( anchor, i); break;
            case 2:   position =  _nasolabialLeft1( anchor, i); break;
            case 3:   position =  _nasolabialLeft2( anchor, i); break;
            case 4:   position =  _nasolabialLeft3( anchor, i); break;
            case 5:   position =  _nasolabialLeft4( anchor, i); break;
          }
        }else if(wantPart == '3mm Right Nasolabial'){
          switch(wantLine){
            case 1:   position =  _nasolabialRight0( anchor, i); break;
            case 2:   position =  _nasolabialRight1( anchor, i); break;
            case 3:   position =  _nasolabialRight2( anchor, i); break;
            case 4:   position =  _nasolabialRight3( anchor, i); break;
            case 5:   position =  _nasolabialRight4( anchor, i); break;
          }
        }
        _updateNode(points[i], position!.position);
      }
    }
  }
  void _updateNode(ARKitNode node, vector.Vector3 pointsPosition) {
    final position = vector.Vector3(pointsPosition.x, pointsPosition.y , pointsPosition.z);
    node.position = position;
  }
}

class ARKitCurve extends ARKitNode {
  ARKitCurve({
    required List<vector.Vector3> points,
    required double radius,
    required Color color,
  }) : super(
    geometry: _buildCurveGeometry(points, radius),
    position: vector.Vector3(0, 0, 0), // Set the initial position of the curve
  );

  static ARKitGeometry _buildCurveGeometry(
      List<vector.Vector3> points, double radius) {
    return ARKitLine(fromVector: points[0], toVector: points[1]);
    // Build your custom curve geometry here based on the provided points and radius
    // You can use ARKitSphere or other geometries to create the desired curve
  }
}