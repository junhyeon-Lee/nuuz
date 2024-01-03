import 'package:flutter/material.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: CustomTextStyle.textStyle(fontSize: 14, color: CustomColor.dark),
      ),
    );
  }
}
