import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/modules/nuuz_talk/providers/comment/report_provider.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/report/report_complete.dart';
import 'package:nuuz/ui/report/report_controller.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';

Future<void> showReportPreview(
    {required BuildContext context,
    required bool isUserReport,
    required bool isPostReport,
    String? commentId,
    String? postId,
    String? userId}) async {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return ReportPreviewScreen(
          isUserReport: isUserReport,
          commentId: commentId,
          postId: postId,
          userId: userId,
          isPostReport: isPostReport,
        );
      });
}

class ReportPreviewScreen extends ConsumerStatefulWidget {
  const ReportPreviewScreen({Key? key, required this.isUserReport, required this.isPostReport, this.commentId, this.postId, this.userId})
      : super(key: key);

  @override
  ConsumerState<ReportPreviewScreen> createState() => _ReportPreviewScreenState();
  final bool isUserReport;
  final bool isPostReport;
  final String? commentId;
  final String? postId;
  final String? userId;
}

class _ReportPreviewScreenState extends ConsumerState<ReportPreviewScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var selectedValue = ref.watch(reportDropdownProvider);

      Map<String, dynamic> body = {
        'status': 'reported',
        'description':
            'reason : ${ref.watch(reportDropdownProvider)}, description : ${ref.watch(reportBodyProvider.notifier).controller.text.toString()}'
      };

      if (widget.userId != null) {
        body['reportedUserId'] = widget.userId;
      } else if (widget.commentId != null) {
        body['commentId'] = widget.commentId;
      } else {
        body['postId'] = widget.postId;
      }

      CommentSuccessModel? model = await ref.watch(reportNotifier.notifier).createReport(body: body, context: context);

      if (model?.status ?? false) {
        ref.watch(reportBodyProvider.notifier).controller.text = '';
        //context.pop();
        // ignore: use_build_context_synchronously
        showReportComplete(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final textController = ref.watch(reportBodyProvider.notifier).controller;
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
                'Talk_Repo_0014'.tr(),
                style: CustomTextStyle.descriptionM,
                textAlign: TextAlign.center,
              ),
            ),
            hSize(30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: CustomContainer(
                width: double.infinity,
                height: 48.h,
                containerColor: CustomColor.darkWhite,
                child: SizedBox(
                  height: 50.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Text(
                          selectedValue.tr(),
                          style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                    child: Text(
                      textController.text,
                      style: CustomTextStyle.descriptionM.copyWith(color: CustomColor.dark),
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
                  onTap: () async {
                    Map<String, dynamic> body = {
                      'status': 'reported',
                      'description':
                          'reason : ${ref.watch(reportDropdownProvider)}, description : ${ref.watch(reportBodyProvider.notifier).controller.text.toString()}'
                    };

                    if (widget.userId != null) {
                      body['reportedUserId'] = widget.userId;
                    } else if (widget.commentId != null) {
                      body['commentId'] = widget.commentId;
                    } else {
                      body['postId'] = widget.postId;
                    }

                    CommentSuccessModel? model = await ref.watch(reportNotifier.notifier).createReport(body: body, context: context);

                    if (model?.status ?? false) {
                      ref.watch(reportBodyProvider.notifier).controller.text = '';
                      //context.pop();
                      // ignore: use_build_context_synchronously
                      showReportComplete(context);
                    }
                  },
                  child: CustomContainer(
                    width: 320.w,
                    height: 46.h,
                    radius: 13,
                    containerColor: CustomColor.primary,
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
  }
}
