import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Widget commonButton(BuildContext context, String text, bool state) {
  return Container(
    height: 44.h,
    decoration: BoxDecoration(color: state ? CustomColor.primary : CustomColor.gray, borderRadius: const BorderRadius.all(Radius.circular(13))),
    child: Center(
      child: Text(
        text,
        style: CustomTextStyle.buttonM.copyWith(color: CustomColor.white),
      ),
    ),
  );
}

class CommonButton extends StatefulWidget {
  final Function? onPressed;
  final String text;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return ElevatedButton(
          onPressed: widget.onPressed == null
              ? null
              : () async {
                  ref.watch(loadingProvider.notifier).isLoadingTrue();
                  await widget.onPressed?.call();
                  ref.watch(loadingProvider.notifier).isLoadingFalse();
                  // if (mounted) context.pop();
                },
          child: SizedBox(
            height: 44.h,
            child: Center(
              child: Text(
                widget.text,
                style: CustomTextStyle.buttonM.copyWith(color: CustomColor.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CommonOutlinedButton extends StatefulWidget {
  final Function? onPressed;
  final Widget child;

  const CommonOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  State<CommonOutlinedButton> createState() => _CommonOutlinedButtonState();
}

class _CommonOutlinedButtonState extends State<CommonOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return OutlinedButton(
          onPressed: widget.onPressed == null
              ? null
              : () async {
                  ref.watch(loadingProvider.notifier).isLoadingTrue();
                  await widget.onPressed?.call();
                  ref.watch(loadingProvider.notifier).isLoadingFalse();
                  // if (mounted) context.pop();
                },
          child: SizedBox(
            height: 44.h,
            child: Center(
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
