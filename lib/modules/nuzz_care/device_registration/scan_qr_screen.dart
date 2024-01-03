import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key, required this.productId});

  final String productId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  final MobileScannerController _mobileScannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
              controller: _mobileScannerController,
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  debugPrint('Failed to scan Barcode');
                } else {
                  final String code = barcode.rawValue!;
                  debugPrint('Barcode found! $code');
                  context.goNamed("product-registration", queryParams: {"productId": widget.productId, "productCode": code});
                }
              }),
          CustomPaint(
            painter: ScannerOverlay(scanWindow),
          ),
          Positioned.fromRect(
            rect: scanWindow,
            child: Align(
              alignment: Alignment.topLeft,
              child: Transform.rotate(
                angle: 0,
                child: SvgPicture.asset(IconPath.leftTopNotch),
              ),
            ),
          ),
          Positioned.fromRect(
            rect: scanWindow,
            child: Align(
              alignment: Alignment.topRight,
              child: Transform.rotate(
                angle: pi / 2,
                child: SvgPicture.asset(IconPath.leftTopNotch),
              ),
            ),
          ),
          Positioned.fromRect(
            rect: scanWindow,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Transform.rotate(
                angle: pi,
                child: SvgPicture.asset(IconPath.leftTopNotch),
              ),
            ),
          ),
          Positioned.fromRect(
            rect: scanWindow,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Transform.rotate(
                angle: pi * 3 / 2,
                child: SvgPicture.asset(IconPath.leftTopNotch),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  IconPath.close,
                  color: CustomColor.white,
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NuuzContainer(
                    containerColor: CustomColor.white.withOpacity(0.6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        hSize(16),
                        SvgPicture.asset(IconPath.qrImage),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
                          child: Text(
                            "Devi_Regi_0007".tr(),
                            style: CustomTextStyle.descriptionM,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => context.goNamed("product-registration", queryParams: {'productId': widget.productId, 'productCode': ''}),

                        // productId: state.queryParams["productId"]!,
                        // productCode: state.queryParams["productCode"],

                        child: Column(
                          children: [
                            CustomContainer(
                                containerColor: CustomColor.white.withOpacity(0.6),
                                radius: 24,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                                  child: Text(
                                    "Devi_Regi_0008".tr(),
                                    style: CustomTextStyle.buttonM,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  hSize(6),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
