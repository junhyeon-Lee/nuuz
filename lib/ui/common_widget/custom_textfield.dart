import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/text_style.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? title;
  final String? errorMsg;
  final FormFieldValidator<String>? validator;
  bool? obscureText;
  final Color? fillColor;
  ValueChanged<String>? onChanged;
  int? maxLength;
  int? maxLine;
  double? borderRadius;
  final String? hintText;
  final bool? showBottomErrorMsg;
  final bool? autoFocus;
  final TextStyle? hintStyle;
  final TextInputType? inputType;

  CustomTextField({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.validator,
    this.title,
    this.errorMsg,
    this.obscureText,
    this.inputType,
    this.showBottomErrorMsg,
    this.fillColor,
    this.onChanged,
    this.maxLength,
    this.autoFocus,
    this.hintText,
    this.maxLine,
    this.hintStyle,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? const SizedBox()
            : Text(
                (title ?? "").tr(),
                style: CustomTextStyle.textStyle(color: CustomColor.dark, fontWeight: FontWeight.w700, fontSize: 15.sp),
              ),

        /*  (showBottomErrorMsg ?? false) ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              errorMsg ?? "",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'MontserratItalic',
                color: AppColor.errorTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 11.sp,
              ),
            ),
          ],
        ) : SizedBox(),*/

        ((title == null) && (errorMsg == null)) ? const SizedBox() : hSize(8.2),
        SizedBox(
          child: TextFormField(
            // scrollPadding: EdgeInsets.only(
            //   bottom: 100.h,
            // ),
            maxLines: maxLine ?? 1,
            maxLength: maxLength,
            onChanged: onChanged,
            textAlign: TextAlign.start,
            obscuringCharacter: '*',
            obscureText: obscureText ?? false,
            validator: validator,
            controller: controller,
            autofocus: autoFocus ?? false,
            keyboardType: inputType ?? TextInputType.text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
            decoration: InputDecoration(
              hintStyle: hintStyle,
              hintText: (hintText ?? '').tr(),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(
                10,
                12.7,
                10,
                12.7,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffixIcon: suffixIcon,
              suffixIconConstraints: BoxConstraints(
                maxHeight: 35.h,
              ),
              fillColor: fillColor ?? CustomColor.darkWhite,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 10,
                  ),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 10,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 10,
                  ),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    borderRadius ?? 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
