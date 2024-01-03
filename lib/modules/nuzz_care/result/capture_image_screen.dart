import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/image_controller.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class CaptureImageScreen extends ConsumerStatefulWidget {
  // final Function(File) onSendVideoMsgCallback;

  const CaptureImageScreen({
    Key? key,
    // required this.onSendVideoMsgCallback,
  }) : super(key: key);

  @override
  ConsumerState<CaptureImageScreen> createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends ConsumerState<CaptureImageScreen> with WidgetsBindingObserver {
  CameraController? controller;
  List<CameraDescription> _cameras = <CameraDescription>[];

  // File? imageFile;
  // Timer? _timer;
  bool isLoading = false;
  bool _showFaceGuide = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _cameras = await availableCameras();
      var frontCamera = _cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.front);
      controller = CameraController(frontCamera, ResolutionPreset.high);

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              print('access denied');
              break;
            default:
              print('some error occured ${e.code}');
              break;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) {
      return Container();
    }
    // var camera = controller!.value;
    // final size = MediaQuery.of(context).size;
    // var scale = size.aspectRatio * camera.aspectRatio;
    // if (scale < 1) scale = 1 / scale;

    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: CameraPreview(
                controller!,
              ),
            ),
            if (_showFaceGuide) _renderFaceGuideOverlay(),
            _renderAppBar(),
            _recordControlWidget(),
            if (isLoading)
              Container(
                color: CustomColor.dark,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _renderFaceGuideOverlay() {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(IconPath.cameraFaceGuide),
    );
  }

  // Widget _renderHeaderOverlay() {
  //   return _renderAppBar();
  // }

  Widget _renderAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: CustomColor.black,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_renderBackButton()],
          ),
        ),
      ),
    );
  }

  Widget _renderBackButton() {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColor.dark.withOpacity(0.4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            CupertinoIcons.clear,
            size: 20,
            color: CustomColor.white,
          ),
        ),
      ),
    );
  }

  Widget _recordControlWidget() {
    final CameraController? cameraController = controller;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(color: CustomColor.black),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _renderFaceGuideButton(),
              _renderCaptureButton(),
              _renderCameraSwitchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderFaceGuideButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showFaceGuide = !_showFaceGuide;
        });
      },
      child: Container(
          decoration: BoxDecoration(
            color: CustomColor.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: _showFaceGuide
                ? Image.asset(
                    IconPath.faceGuideOff,
                    scale: 2,
                  )
                : Image.asset(
                    IconPath.faceGuideOn,
                    scale: 2,
                  ),
          )),
    );
  }

  Widget _renderCaptureButton() {
    return GestureDetector(
      onTap: _onStopButtonPressed,
      child: Container(
        height: 82,
        width: 82,
        decoration: BoxDecoration(shape: BoxShape.circle, color: CustomColor.dark),
        child: Container(
          height: 68,
          width: 68,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColor.red,
              border: Border.all(
                color: CustomColor.white,
                width: 2,
              )),
        ),
      ),
    );
  }

  Widget _renderCameraSwitchButton() {
    return GestureDetector(
      onTap: () {
        CameraDescription newCameraDescription;
        if (controller?.description.lensDirection == CameraLensDirection.front) {
          newCameraDescription = _cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.back);
        } else {
          newCameraDescription = _cameras.firstWhere((element) => element.lensDirection == CameraLensDirection.front);
        }

        _onNewCameraSelected(newCameraDescription);
      },
      child: Container(
          decoration: BoxDecoration(
            color: CustomColor.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(IconPath.cameraFlip),
          )),
    );
  }

  void _onStopButtonPressed() {
    setState(() {
      isLoading = true;
    });
    _captureImage().then((File? file) {
      if (file != null) {
        var imageProvider = ref.read(imageController.notifier);
        imageProvider.updateImage(file.path);
        context.pop();
      }
      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<File?> _captureImage() async {
    final CameraController? cameraController = controller;

    if (cameraController == null) {
      return null;
    }

    try {
      XFile image = await cameraController.takePicture();
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: CustomColor.black,
            toolbarWidgetColor: CustomColor.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'title',
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
            aspectRatioLockDimensionSwapEnabled: false,
            aspectRatioPickerButtonHidden: true,
          ),
        ],
      );

      if (croppedFile == null) {
        return null;
      }
      return File(croppedFile.path);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> _onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = controller;
    if (oldController != null) {
      controller = null;
      await oldController.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );

    controller = cameraController;

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        _showInSnackBar('Camera error ${cameraController.value.errorDescription}');
      }
    });
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          _showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          _showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          _showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          _showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          _showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          _showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    _showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
// =======
// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:nuuz/modules/nuzz_care/result/providers/image/image_controller.dart';
// import 'package:nuuz/ui/theme/color_style.dart';
// import 'package:nuuz/ui/theme/icon_path.dart';
// import 'package:nuuz/util/log_print.dart';

// class CaptureImageScreen extends ConsumerStatefulWidget {
//   // final Function(File) onSendVideoMsgCallback;

//   const CaptureImageScreen({
//     Key? key,
//     // required this.onSendVideoMsgCallback,
//   }) : super(key: key);

//   @override
//   ConsumerState<CaptureImageScreen> createState() => _CaptureImageScreenState();
// }

// class _CaptureImageScreenState extends ConsumerState<CaptureImageScreen>
//     with WidgetsBindingObserver {
//   CameraController? controller;
//   List<CameraDescription> _cameras = <CameraDescription>[];
//   // File? imageFile;
//   // Timer? _timer;
//   bool isLoading = false;
//   bool _showFaceGuide = true;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       _cameras = await availableCameras();
//       safePrint('카메라 리스트');
//       safePrint(_cameras);
//       var frontCamera = _cameras.firstWhere(
//           (element) => element.lensDirection == CameraLensDirection.front);
//       controller = CameraController(frontCamera, ResolutionPreset.low);

//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       }).catchError((Object e) {
//         if (e is CameraException) {
//           switch (e.code) {
//             case 'CameraAccessDenied':
//               print('access denied');
//               break;
//             default:
//               print('some error occured ${e.code}');
//               break;
//           }
//         }
//       });

//     });
//   }

//   @override
//   void dispose() {
//     controller!.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = controller;

//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }

//     if (state == AppLifecycleState.inactive) {
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       _onNewCameraSelected(cameraController.description);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!(controller?.value.isInitialized ?? false)) {
//       return Container();
//     }
//     // var camera = controller!.value;
//     // final size = MediaQuery.of(context).size;
//     // var scale = size.aspectRatio * camera.aspectRatio;
//     // if (scale < 1) scale = 1 / scale;

//     return Material(
//       child: SafeArea(
//         child: Stack(
//           children: [
//             Center(
//               child: CameraPreview(
//                 controller!,
//               ),
//             ),
//             if (_showFaceGuide) _renderFaceGuideOverlay(),
//             _renderAppBar(),
//             _recordControlWidget(),
//             if (isLoading)
//               Container(
//                 color: CustomColor.dark,
//                 child: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _renderFaceGuideOverlay() {
//     return Align(
//       alignment: Alignment.center,
//       child: SvgPicture.asset(IconPath.cameraFaceGuide),
//     );
//   }
//   // Widget _renderHeaderOverlay() {
//   //   return _renderAppBar();
//   // }

//   Widget _renderAppBar() {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: Container(
//         height: 200.h,
//         decoration: BoxDecoration(
//           color: CustomColor.black,
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [_renderBackButton()],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _renderBackButton() {
//     return InkWell(
//       onTap: () => Navigator.of(context).pop(),
//       child: Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: CustomColor.dark.withOpacity(0.4),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             CupertinoIcons.clear,
//             size: 20,
//             color: CustomColor.white,
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _renderTimerProgressBar() {
//   //   return _timer != null && _timer!.isActive
//   //       ? Column(
//   //           children: [
//   //             Text('00:${_timer!.tick}'),
//   //             Padding(
//   //               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//   //               child: Container(
//   //                 decoration: BoxDecoration(
//   //                   borderRadius: BorderRadius.circular(12.0),
//   //                 ),
//   //                 clipBehavior: Clip.antiAlias,
//   //                 child: LinearProgressIndicator(
//   //                   value: _timer!.tick / 60,
//   //                   minHeight: 10,
//   //                   backgroundColor: Colors.grey,
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         )
//   //       : SizedBox(height: 10);
//   // }

//   // Widget _renderJourneyQuestion() {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
//   //     child: Text(
//   //       widget.journeyQuestion,
//   //       style: context.textTheme.headlineSmall,
//   //     ),
//   //   );
//   // }

//   Widget _recordControlWidget() {
//     final CameraController? cameraController = controller;

//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         height: 200.h,
//         decoration: BoxDecoration(color: CustomColor.black),
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 40),
//           child: Row(
//             // mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               _renderFaceGuideButton(),
//               _renderCaptureButton(),
//               _renderCameraSwitchButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _renderFaceGuideButton() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _showFaceGuide = !_showFaceGuide;
//         });
//       },
//       child: Container(
//           decoration: BoxDecoration(
//             color: CustomColor.white,
//             shape: BoxShape.circle,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: _showFaceGuide
//                 ? Image.asset(
//                     IconPath.faceGuideOff,
//                     scale: 2,
//                   )
//                 : Image.asset(
//                     IconPath.faceGuideOn,
//                     scale: 2,
//                   ),
//           )),
//     );
//   }

//   Widget _renderCaptureButton() {
//     return GestureDetector(
//       onTap: _onStopButtonPressed,
//       child: Container(
//         height: 82,
//         width: 82,
//         decoration:
//             BoxDecoration(shape: BoxShape.circle, color: CustomColor.dark),
//         child: Container(
//           height: 68,
//           width: 68,
//           decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: CustomColor.red,
//               border: Border.all(
//                 color: CustomColor.white,
//                 width: 2,
//               )),
//         ),
//       ),
//     );
//   }

//   Widget _renderCameraSwitchButton() {
//     return GestureDetector(
//       onTap: () {
//         CameraDescription newCameraDescription;
//         if (controller?.description.lensDirection ==
//             CameraLensDirection.front) {
//           newCameraDescription = _cameras.firstWhere(
//               (element) => element.lensDirection == CameraLensDirection.back);
//         } else {
//           newCameraDescription = _cameras.firstWhere(
//               (element) => element.lensDirection == CameraLensDirection.front);
//         }

//         _onNewCameraSelected(newCameraDescription);
//       },
//       child: Container(
//           decoration: BoxDecoration(
//             color: CustomColor.white,
//             shape: BoxShape.circle,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: SvgPicture.asset(IconPath.cameraFlip),
//           )),
//     );
//   }

//   void _onStopButtonPressed() {
//     setState(() {
//       isLoading = true;
//     });
//     _captureImage().then((File? file) {
//       if (file != null) {
//         var imageProvider = ref.read(imageController.notifier);
//         imageProvider.updateImage(file.path);
//         context.pop();
//       }
//       isLoading = false;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   Future<File?> _captureImage() async {
//     final CameraController? cameraController = controller;

//     if (cameraController == null) {
//       return null;
//     }

//     try {
//       XFile image = await cameraController.takePicture();
//       var croppedFile = await ImageCropper().cropImage(
//         sourcePath: image.path,
//         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//         aspectRatioPresets: [
//           CropAspectRatioPreset.square,
//         ],
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarColor: CustomColor.black,
//             toolbarWidgetColor: CustomColor.white,
//             initAspectRatio: CropAspectRatioPreset.square,
//             lockAspectRatio: false,
//             hideBottomControls: true,
//           ),
//           IOSUiSettings(
//             title: 'title',
//             rotateButtonsHidden: true,
//             rotateClockwiseButtonHidden: true,
//             aspectRatioLockDimensionSwapEnabled: false,
//             aspectRatioPickerButtonHidden: true,
//           ),
//         ],
//       );

//       if (croppedFile == null) {
//         return null;
//       }
//       return File(croppedFile.path);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//   }

//   Future<void> _onNewCameraSelected(CameraDescription cameraDescription) async {
//     final CameraController? oldController = controller;
//     if (oldController != null) {
//       controller = null;
//       await oldController.dispose();
//     }

//     final CameraController cameraController = CameraController(
//       cameraDescription,
//       ResolutionPreset.max,
//     );

//     controller = cameraController;

//     cameraController.addListener(() {
//       if (mounted) {
//         setState(() {});
//       }
//       if (cameraController.value.hasError) {
//         _showInSnackBar(
//             'Camera error ${cameraController.value.errorDescription}');
//       }
//     });
//     try {
//       await cameraController.initialize();
//     } on CameraException catch (e) {
//       switch (e.code) {
//         case 'CameraAccessDenied':
//           _showInSnackBar('You have denied camera access.');
//           break;
//         case 'CameraAccessDeniedWithoutPrompt':
//           _showInSnackBar('Please go to Settings app to enable camera access.');
//           break;
//         case 'CameraAccessRestricted':
//           _showInSnackBar('Camera access is restricted.');
//           break;
//         case 'AudioAccessDenied':
//           _showInSnackBar('You have denied audio access.');
//           break;
//         case 'AudioAccessDeniedWithoutPrompt':
//           _showInSnackBar('Please go to Settings app to enable audio access.');
//           break;
//         case 'AudioAccessRestricted':
//           _showInSnackBar('Audio access is restricted.');
//           break;
//         default:
//           _showCameraException(e);
//           break;
//       }
//     }

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void _showInSnackBar(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   void _showCameraException(CameraException e) {
//     _showInSnackBar('Error: ${e.code}\n${e.description}');
//   }
// }
