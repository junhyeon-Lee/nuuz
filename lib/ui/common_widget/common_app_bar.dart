import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common_widget/common_text_widget.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({
    Key? key,
    required BuildContext context,
    required String title,
    List<Widget>? trailing,
    Widget? backIcon,
  }) : super(
            key: key,
            centerTitle: true,
            elevation: 0,
            backgroundColor: CustomColor.background,
            leading: GestureDetector(
              onTap: context.pop,
              child: backIcon ??
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      IconPath.close,
                    ),
                  ),
            ),
            title: LargeHeaderText(text: title),
            actions: trailing);
}
