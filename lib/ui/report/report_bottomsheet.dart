import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';

import 'report_controller.dart';
import 'report_write_reason.dart';

Future<void> showReport({
  required BuildContext context,
  required bool isUserReport,
  required bool isPostReport,
  String? userId,
  String? postId,
  String? commentId,
}) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      hSize(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: SvgPicture.asset(IconPath.close)),
                          Text(
                            'Comm_Gene_0041'.tr(),
                            style: CustomTextStyle.headerL,
                          ),
                          wSize(24),
                        ],
                      ),
                      hSize(20),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xffebeae9),
                      ),
                      hSize(12)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Text(
                    'Talk_Repo_0004'.tr(),
                    style: CustomTextStyle.descriptionM,
                    textAlign: TextAlign.center,
                  ),
                ),
                hSize(30),
                Text(
                  'Talk_Repo_0005'.tr(),
                  style: CustomTextStyle.headerXS,
                ),
                hSize(10),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return reportCategory(index);
                  },
                  itemCount: 6,
                ),
                hSize(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: CustomContainer(
                        width: 120.w,
                        height: 46.h,
                        radius: 13,
                        containerColor: CustomColor.white,
                        borderColor: CustomColor.dark,
                        child: Center(
                          child: Text(
                            'Comm_Gene_0006'.tr(),
                            style: CustomTextStyle.buttonM,
                          ),
                        ),
                      ),
                    ),
                    wSize(12),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                        showWriteReason(
                            context: context,
                            isUserReport: isUserReport,
                            isPostReport: isPostReport,
                            commentId: commentId,
                            postId: postId,
                            userId: userId);
                      },
                      child: CustomContainer(
                        width: 120.w,
                        height: 46.h,
                        radius: 13,
                        containerColor: CustomColor.primary,
                        child: Center(
                          child: Text(
                            'Comm_Gene_0004'.tr(),
                            style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                hSize(
                  30,
                )
              ],
            );
          },
        );
      });
}

Widget reportCategory(int index) {
  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final category = ref.watch(reportCategoryProvider);
      final value = ref.watch(reportDropdownProvider);
      final valueList = ref.watch(reportDropdownProvider.notifier).valueList;
      final dropdownController = ref.watch(reportDropdownProvider.notifier);
      return Row(
        children: [
          wSize(36),
          IconButton(
              onPressed: () async {
                safePrint('ontpa');
                await ref.watch(reportCategoryProvider.notifier).tapCategory(index);
                await ref.watch(reportDropdownProvider.notifier).setValueInt(index);
              },
              icon: Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    border: Border.all(color: CustomColor.dark, width: 1.w)),
                child: Center(
                  child: category == index
                      ? Container(
                          width: 16.w,
                          height: 16.w,
                          decoration: BoxDecoration(color: CustomColor.primary, borderRadius: const BorderRadius.all(Radius.circular(24))),
                        )
                      : Container(),
                ),
              )),
          wSize(4),
          Text(
            valueList[index].tr(),
            style: CustomTextStyle.textStyle(fontWeight: FontWeight.w400, fontSize: 16),
          )
        ],
      );
    },
  );
}
