import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class CommonMessageBottomSheet extends StatefulWidget {
  const CommonMessageBottomSheet({
    super.key,
    required this.headerText,
    required this.descriptionText,
    this.primaryButtonText,
    this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
  });

  final String headerText;
  final String descriptionText;
  final Function? onPrimaryButtonPressed;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final Function? onSecondaryButtonPressed;

  @override
  State<CommonMessageBottomSheet> createState() => _CommonMessageBottomSheetState();
}

class _CommonMessageBottomSheetState extends State<CommonMessageBottomSheet> {
  bool isLoadingPrimary = false;
  bool isLoadingSecondary = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: CustomColor.white,
                leading: Container(),
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: InkWell(
                //     onTap: () => context.pop(),
                //     child: SvgPicture.asset(
                //       IconPath.close,
                //     ),
                //   ),
                // ),
                title: Text(
                  widget.headerText,
                  style: CustomTextStyle.headerL,
                ),
              ),
              Divider(
                height: 10.h,
                thickness: 1.h,
              ),
              Text(
                widget.descriptionText,
                textAlign: TextAlign.center,
                style: CustomTextStyle.descriptionL,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: widget.secondaryButtonText != null
                          ? CommonOutlinedButton(
                              onPressed: () async {
                                setState(() {
                                  isLoadingPrimary = true;
                                });
                                if (widget.onPrimaryButtonPressed != null) {
                                  await widget.onPrimaryButtonPressed!.call();
                                }
                                setState(() {
                                  isLoadingPrimary = false;
                                });
                                if (mounted) context.pop();
                              },
                              child: Text(widget.primaryButtonText ?? 'Ok'),
                            )
                          : CommonButton(
                              onPressed: () async {
                                setState(() {
                                  isLoadingPrimary = true;
                                });
                                if (widget.onPrimaryButtonPressed != null) {
                                  await widget.onPrimaryButtonPressed!.call();
                                }
                                setState(() {
                                  isLoadingPrimary = false;
                                });
                                if (mounted) context.pop();
                              },
                              text: widget.primaryButtonText ?? 'Ok',
                            ),
                    ),
                    if (widget.secondaryButtonText != null) ...[
                      wSize(12),
                      Expanded(
                        child: CommonButton(
                          onPressed: () async {
                            setState(() {
                              isLoadingSecondary = true;
                            });
                            if (widget.onSecondaryButtonPressed != null) {
                              await widget.onSecondaryButtonPressed!.call();
                            }
                            setState(() {
                              isLoadingSecondary = false;
                            });
                            if (mounted) context.pop();
                          },
                          text: widget.secondaryButtonText!,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              if (Platform.isIOS) hSize(20)
            ],
          ),
        ),
      ),
    );
  }
}
