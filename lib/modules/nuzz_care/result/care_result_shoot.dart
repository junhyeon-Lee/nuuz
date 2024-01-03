import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuuz/modules/drawer/bottomsheet/change_image_bottom_sheet.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_controller.dart' as result_date;
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/image_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/repository/image_repository.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/ui/common/crop_image.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

class CareResultShoot extends ConsumerStatefulWidget {
  const CareResultShoot({
    super.key,
    required this.careProgramId,
    required this.userCareProgramId,
  });

  final int careProgramId;
  final String userCareProgramId;

  @override
  ConsumerState<CareResultShoot> createState() => _CareResultShootState();
}

String? _imageUrl = "";
File? imageFile;

class _CareResultShootState extends ConsumerState<CareResultShoot> {
  getResultImage({required File? file, required BuildContext context}) async {
    context.pop();
    context.pop();

    if (file != null) {
      final imageRepository = ImageRepository();
      try {
        var data = await imageRepository.uploadImage(file.path);
        safePrint("get _imageUrl==uploaded=>$data");
        _imageUrl = data;

        // ref.watch(imageController.notifier).updateImage(data);
      } on Exception catch (e) {
        safePrint(e);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  final _imagePicker = ImagePicker();
  bool isLoading = false;
  var imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          NuuzContainer(
            containerColor: CustomColor.background,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: CustomColor.lightWhite,
                    leading: Container(),
                    // leading: Consumer(builder: (context, ref, _) {
                    //   return GestureDetector(
                    //     onTap: () {
                    //       // ref.invalidate(imageController);
                    //       // context.pop();
                    //       context.go('/main');
                    //     },
                    //     child: Padding(
                    //         padding: const EdgeInsets.all(12.0),
                    //         child: Icon(
                    //           CupertinoIcons.clear,
                    //           color: CustomColor.dark,
                    //         )),
                    //   );
                    // }),
                    title: Text(
                      'Care_Resu_0000'.tr(),
                      style: CustomTextStyle.headerL,
                    ),
                    actions: [
                      Consumer(builder: (context, ref, _) {
                        return TextButton(
                          onPressed: () async {
                            setState(() {
                              ref.watch(loadingProvider.notifier).isLoadingTrue();
                              isLoading = true;
                            });
                            final result = {
                              "programId": widget.careProgramId.toString(),
                              "date": DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String()
                            };
                            await ref.read(resultProvider.notifier).postResult(result);
                            safePrint(widget.userCareProgramId);
                            await ref.read(userCareProgramProvider.notifier).updateUserCarePrograms(
                              userCareProgramId: widget.userCareProgramId,
                              data: {"status": "completed"},
                            );
                            ref.invalidate(resultProvider);
                            ref.invalidate(imageController);
                            ref.invalidate(userCareProgramProvider);
                            ref.invalidate(userCareProgramForDateRangeProvider);
                            ref.invalidate(result_date.resultsForDateRangeProvider);
                            ref.watch(loadingProvider.notifier).isLoadingFalse();
                            isLoading = false;
                            context.pushNamed('result-home', queryParams: {"care_program_id": widget.careProgramId.toString(), "image": null});
                          },
                          child: Text(
                            'Comm_Gene_0031'.tr(),
                            style: TextStyle(color: CustomColor.dark, decoration: TextDecoration.underline),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  LargeDescriptionText(text: "Care_Resu_0001".tr()),
                  SizedBox(height: 12.h),
                  Container(
                    height: 350.w,
                    width: 350.w,
                    decoration: BoxDecoration(color: CustomColor.grayVariant1),
                    child: Consumer(
                      builder: (context, ref, child) {
                        var image = ref.watch(imageController);
                        return image != null
                            ? Center(
                                child: Image.file(image),
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SmallHeaderText(textAlign: TextAlign.center, text: "Care_Resu_0002".tr()),
                                ),
                              );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 60.h,
                    child: CommonOutlinedButton(
                      onPressed:
                          //_showBottomSheet,
                          () {
                        changeImageBottomSheet(
                            context: context,
                            onCameraTap: () async {
                              await getImageFile(
                                ImageSource.camera,
                              );
                              if (imageFile != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CropImageScreen(
                                        cropImageFile: File(imageFile!.path),
                                        onUploadCropImage: (file) => getResultImage(file: file, context: context),
                                      ),
                                    ));
                              }
                            },
                            onDeleteProfilePicTap: () async {},
                            onGalleryTap: () async {
                              await getImageFile(ImageSource.gallery);
                              if (imageFile != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CropImageScreen(
                                        cropImageFile: File(imageFile!.path),
                                        onUploadCropImage: (file) => getResultImage(file: file, context: context),
                                      ),
                                    ));
                              }
                              //   getImage(source: ImageSource.gallery, context: context);
                            },
                            deleteShow: false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.camera),
                          SizedBox(width: 6.w),
                          Consumer(builder: (context, ref, child) {
                            var image = ref.watch(imageController);
                            return image != null ? Text("Care_Resu_0010".tr()) : Text("Care_Resu_0003".tr());
                          })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  MediumHeaderText(text: "Comm_Gene_0005".tr()),
                  SizedBox(height: 12.h),
                  LargeDescriptionText(text: "Care_Resu_0004".tr()),
                  const Spacer(),
                  Consumer(
                    builder: (context, ref, child) {
                      var image = ref.watch(imageController);
                      return image != null
                          ? CommonButton(
                              onPressed: () async {
                                ref.watch(loadingProvider.notifier).isLoadingTrue();
                                final imageUrl = await ref.read(imageController.notifier).uploadImage();
                                final result = {
                                  "programId": widget.careProgramId.toString(),
                                  "resultImage": imageUrl,
                                  "date": DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String()
                                };
                                await ref.read(resultProvider.notifier).postResult(result);
                                await ref.read(userCareProgramProvider.notifier).updateUserCarePrograms(
                                  userCareProgramId: widget.userCareProgramId,
                                  data: {"status": "completed"},
                                );
                                ref.invalidate(resultProvider);
                                ref.invalidate(imageController);
                                ref.invalidate(userCareProgramProvider);
                                ref.invalidate(userCareProgramForDateRangeProvider);
                                ref.invalidate(result_date.resultsForDateRangeProvider);
                                ref.watch(loadingProvider.notifier).isLoadingFalse();
                                context
                                    .pushNamed('result-home', queryParams: {"care_program_id": widget.careProgramId.toString(), "image": image.path});
                              },
                              text: "Care_Resu_0011".tr())
                          : const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
          loadingScreen()
        ],
      ),
    );
  }

  getImageFile(ImageSource source) async {
    XFile? file = await imagePicker.pickImage(source: source, imageQuality: 25, preferredCameraDevice: CameraDevice.front);
    setState(() {
      imageFile = File(file!.path);
    });
  }
}
