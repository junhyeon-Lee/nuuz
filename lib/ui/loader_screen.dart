import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class LoaderScreen extends StatefulWidget {
  LoaderScreen(this.context, {Key? key}) : super(key: key);
  BuildContext context;

  @override
  State<LoaderScreen> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<LoaderScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: Colors.black.withOpacity(0.55),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: CustomIndicator(
                  'Comm_Gene_0001'.tr(),
                  textStyle: CustomTextStyle.textStyle(fontSize: 16, fontWeight: FontWeight.w600, color: CustomColor.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
