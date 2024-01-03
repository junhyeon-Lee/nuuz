import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

class RestPeriodWarningBottomSheet extends StatefulWidget {
  const RestPeriodWarningBottomSheet({super.key, this.onPrimaryButtonTap, this.onSecondaryButtonTap});

  final Function? onPrimaryButtonTap;
  final Function? onSecondaryButtonTap;

  @override
  State<RestPeriodWarningBottomSheet> createState() => _RestPeriodWarningBottomSheetState();
}

class _RestPeriodWarningBottomSheetState extends State<RestPeriodWarningBottomSheet> {
  bool isLoadingPrimary = false;
  bool isLoadingSecondary = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      child: NuuzContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: CustomColor.white,
                leading: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(
                      IconPath.close,
                    ),
                  ),
                ),
                title: Text(
                  "${'Prog_Rese_0003'.tr()}!",
                  style: CustomTextStyle.headerM.copyWith(color: CustomColor.red),
                ),
              ),
              Divider(
                height: 10.h,
                thickness: 1.h,
              ),
              hSize(20),
              Text(
                "Prog_Rese_0004".tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.descriptionL,
              ),
              hSize(12),
              Text(
                "Prog_Rese_0005".tr(),
                textAlign: TextAlign.center,
                style: CustomTextStyle.descriptionL.copyWith(color: CustomColor.red),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: CommonButton(
                      onPressed: () async {
                        setState(() {
                          isLoadingPrimary = true;
                        });
                        if (widget.onPrimaryButtonTap != null) {
                          await widget.onPrimaryButtonTap!.call();
                        }
                        setState(() {
                          isLoadingPrimary = false;
                        });
                        if (mounted) context.pop();
                      },
                      text: 'Comm_Gene_0034'.tr(),
                      // child: Text('Comm_Gene_0006'.tr()),
                    )),
                    // wSize(12),
                    // Expanded(
                    //   child: CommonButton(
                    //     onPressed: () async {
                    //       setState(() {
                    //         isLoadingSecondary = true;
                    //       });
                    //       if (widget.onSecondaryButtonTap != null) {
                    //         await widget.onSecondaryButtonTap!.call();
                    //       }
                    //       setState(() {
                    //         isLoadingSecondary = false;
                    //       });
                    //       if (mounted) context.pop();
                    //     },
                    //     text: 'Prog_Rese_0002'.tr(),
                    //   ),
                    // ),
                  ],
                ),
              ),
              hSize(30.h)
            ],
          ),
        ),
      ),
    );
  }
}
