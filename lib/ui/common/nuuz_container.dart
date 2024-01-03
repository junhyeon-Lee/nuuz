import 'package:flutter/material.dart';
import 'package:nuuz/ui/theme/color_style.dart';

class NuuzContainer extends Container {
  final Color? containerColor;
  final Color? borderColor;
  BorderRadius? borderRadius;

  NuuzContainer({super.key, this.containerColor, this.borderColor, this.borderRadius, super.child})
      : super(
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            color: containerColor ?? CustomColor.white,
            border: Border.all(color: borderColor ?? CustomColor.white),
          ),
          clipBehavior: Clip.antiAlias,
        );
}
