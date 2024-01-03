import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class SelfDiagnosisAppbar extends AppBar implements PreferredSizeWidget {
  SelfDiagnosisAppbar({super.key, required BuildContext context, required String title})
      : super(
          title: Text(title, style: CustomTextStyle.headerL),
          centerTitle: true,
        );

  @override
  Size get preferredSize => Size.fromHeight(Platform.isAndroid ? 58.h : 44.h);
// Size get preferredSize =>   Size.fromHeight(44.h);
}
