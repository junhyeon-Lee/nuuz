import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_crop/image_crop.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/image_controller.dart';
import 'package:nuuz/ui/common_widget/custom_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/util/log_print.dart';

class CropImageScreen extends StatelessWidget {
  Function(File file) onUploadCropImage;
  File? cropImageFile;

  CropImageScreen({
    Key? key,
    this.cropImageFile,
    required this.onUploadCropImage,
  }) : super(key: key);

  final cropImageKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.close))
        ],
        backgroundColor: CustomColor.black,
      ),
      body: Container(
        color: CustomColor.black,
        child: Column(
          children: [
            Expanded(
              child: Crop.file(cropImageFile!, key: cropImageKey),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 25.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: button("Comm_Gene_0006", () {
                    context.pop();
                  }, false)),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      return Flexible(
                        child: button("Care_Resu_0009", () async {
                          final scale = cropImageKey.currentState!.scale;
                          final area = cropImageKey.currentState!.area;
                          if (area == null) {
                            // cannot crop, widget is not setup
                            return;
                          }
                          // scale up to use maximum possible number of pixels
                          // this will sample image in higher resolution to make cropped image larger
                          final sample = await ImageCrop.sampleImage(
                            file: cropImageFile!,
                            preferredSize: (2000 / scale).round(),
                          );
                          final file = await ImageCrop.cropImage(
                            file: sample,
                            area: area,
                          );
                          sample.delete();

                          ref.watch(imageController.notifier).updateImage(file.path);
                          safePrint("get _imageUrl===크롭>${file.path}");

                          onUploadCropImage(file);
                        }, true),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button(String title, VoidCallback onTap, bool isUpload) {
    return CustomButton(
      title: title.tr(),
      onTap: onTap,
      height: 46.h,
      bgColor: !isUpload ? CustomColor.white : CustomColor.primary,
      borderColor: !isUpload ? CustomColor.white : CustomColor.primary,
      textColor: !isUpload ? CustomColor.black : CustomColor.white,
    );
  }
}
