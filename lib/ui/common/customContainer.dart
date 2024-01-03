import 'package:flutter/material.dart';
import 'package:nuuz/ui/theme/color_style.dart';

///사이즈, 색상, 라운딩, 테두리, 그림자 설정 가능
class CustomContainer extends Container {
  final double? width;
  final double? height;
  final double? radius;
  final Color? containerColor;
  final Color? borderColor;

  CustomContainer({super.key, this.width, this.height, this.radius, this.containerColor, this.borderColor, super.child})
      : super(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 12),
            color: containerColor ?? CustomColor.white,
            border: Border.all(color: borderColor ?? Colors.transparent),
          ),
        );
}
