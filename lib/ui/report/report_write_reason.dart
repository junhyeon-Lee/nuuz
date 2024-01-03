import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/report/report_controller.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

import 'report_preview.dart';

Future<void> showWriteReason(
    {required BuildContext context,
    required bool isUserReport,
    required bool isPostReport,
    String? postId,
    String? commentId,
    String? userId}) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        bool isBody = false;
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final controller = ref.watch(reportBodyProvider);
            var selectedValue = ref.watch(reportDropdownProvider);
            final dropdownController = ref.watch(reportDropdownProvider.notifier);
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
                    'Talk_Repo_0012'.tr(),
                    style: CustomTextStyle.descriptionM,
                    textAlign: TextAlign.center,
                  ),
                ),
                // hSize(30),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 35.w),
                //   child: CustomContainer(
                //     width: double.infinity,
                //     height: 48.h,
                //     containerColor: CustomColor.darkWhite,
                //     child: SizedBox(
                //       height: 50.h,
                //       child: Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 20.w),
                //         child: DropdownButton(
                //           borderRadius: const BorderRadius.all(Radius.circular(13)),
                //           elevation: 0,
                //           underline: Container(),
                //           style: CustomTextStyle.descriptionM.copyWith(color:CustomColor.dark),
                //           icon: SvgPicture.asset(IconPath.expanded),
                //           isExpanded: true,
                //           value: selectedValue,
                //           items: dropdownController.valueList.map((value) {
                //             return DropdownMenuItem(
                //               value: value,
                //               child: Text(value.tr()),
                //             );
                //           }).toList(),
                //           onChanged: (value) {
                //             dropdownController.setValue(value!);
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                hSize(
                  16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w),
                  child: CustomContainer(
                    width: double.infinity,
                    height: 185.h,
                    containerColor: CustomColor.darkWhite,
                    radius: 13,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25.w, 12.h, 25.w, 12.h),
                      child: SizedBox(
                        child: TextField(
                          onChanged: (text) {
                            ref.watch(reportBodyProvider.notifier).checkController();
                          },
                          controller: ref.watch(reportBodyProvider.notifier).controller,
                          style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Talk_Repo_0013'.tr(),
                            hintStyle: CustomTextStyle.descriptionM,
                            hintMaxLines: 4,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                hSize(
                  20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
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
                      onTap: controller
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              context.pop();
                              showReportPreview(
                                  context: context,
                                  isUserReport: isUserReport,
                                  isPostReport: isPostReport,
                                  userId: userId,
                                  postId: postId,
                                  commentId: commentId);
                            },
                      child: CustomContainer(
                        width: 120.w,
                        height: 46.h,
                        radius: 13,
                        containerColor: controller ? CustomColor.gray : CustomColor.primary,
                        child: Center(
                          child: Text(
                            'Self_Diag_0040'.tr(),
                            style: CustomTextStyle.buttonM.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                hSize(
                  30,
                ),
                hSize(MediaQuery.of(context).viewInsets.bottom),
              ],
            );
          },
        );
      });
}
