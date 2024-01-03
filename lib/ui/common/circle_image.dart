import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///사이즈, 색상, 라운딩, 테두리, 그림자 설정 가능
class CircleImage extends Container {
  final double size;
  final String image;

  CircleImage({super.key, required this.size, required this.image, super.child})
      : super(
          width: size.w,
          height: size.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        );
}
