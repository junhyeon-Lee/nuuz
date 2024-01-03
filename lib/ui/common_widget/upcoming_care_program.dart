import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/user_product_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/rest_period_warning_bottom_sheet.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../modules/nuzz_care/care_program/care_program_controller.dart';
import 'common_button.dart';

class UpcomingCareProgram extends ConsumerStatefulWidget {
  const UpcomingCareProgram({
    super.key,
    required this.userCareProgram,
    this.trailingAdd,
    this.trailingDelete,
    this.onTrailingButtonTap,
    this.onOutlineButtonTap,
  });

  final UserCareProgram userCareProgram;
  final bool? trailingAdd;
  final bool? trailingDelete;
  final Function? onTrailingButtonTap;
  final Function? onOutlineButtonTap;

  @override
  ConsumerState<UpcomingCareProgram> createState() => _UpcomingCareProgramState();
}

class _UpcomingCareProgramState extends ConsumerState<UpcomingCareProgram> {
  @override
  Widget build(BuildContext context) {
    var programDate = DateTime.tryParse(widget.userCareProgram.startDate);
    String? buttonText;
    bool isToday = false;
    if (programDate != null) {
      var date = DateTime(programDate.year, programDate.month, programDate.day);
      var now = DateTime.now();
      var today = DateTime(now.year, now.month, now.day);
      if (isSameDay(date, today)) {
        buttonText = "Comm_Gene_0008".tr();
        isToday = true;
      } else {
        buttonText = DateFormat.MMMMd().format(date).toString();
      }
    }
    final userProduct = ref.watch(userProductController);
    return NuuzContainer(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          CareProgramListItem(
            name: widget.userCareProgram.program.name,
            description: widget.userCareProgram.program.description,
            imageUrl: widget.userCareProgram.program.image,
            trailingDelete: widget.trailingDelete,
            trailingAdd: widget.trailingAdd,
            onTrailingButtonTap: widget.onTrailingButtonTap,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: isToday
                      ? CommonButton(
                          onPressed: userProduct.isNotEmpty
                              ? () async {
                                  var results = await ref.read(resultProvider.future);
                                  var now = DateTime.now();
                                  var today = DateTime(now.year, now.month, now.day);
                                  var restPeriodOn =
                                      results.any((element) => DateTime.tryParse(element.date!)?.isAfter(today.subtract(Duration(days: 7))) ?? false);
                                  if (restPeriodOn && context.mounted) {
                                    showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
                                      ),
                                      context: context,
                                      builder: (context) => RestPeriodWarningBottomSheet(
                                        onPrimaryButtonTap: () async {
                                          await _startProgram();
                                        },
                                      ),
                                    );
                                  } else {
                                    await _startProgram();
                                  }
                                }
                              : () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => CommonMessageBottomSheet(
                                      headerText: "Comm_Gene_0002".tr(),
                                      descriptionText: "Care_Main_0000".tr(),
                                      primaryButtonText: "Comm_Gene_0035".tr(),
                                      secondaryButtonText: "Comm_Gene_0015".tr(),
                                      onSecondaryButtonPressed: () {
                                        context.goNamed('/DeviceScreenHome');
                                      },
                                    ),
                                  );
                                },
                          text: buttonText ?? '',
                        )
                      : CommonOutlinedButton(
                          onPressed: buttonText == null
                              ? null
                              : () async {
                                  widget.onOutlineButtonTap?.call();
                                },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(text: TextSpan(text: buttonText ?? '', style: CustomTextStyle.buttonM)),
                            ],
                          ),
                        ),
                ),
                // wSize(12),
                // GestureDetector(
                //   onTap: () async {
                //     context.pushNamed('program-details', queryParams: {"care_program_id": widget.userCareProgram.program.id.toString()});
                //   },
                //   child: Container(
                //     width: 44.w,
                //     height: 44.h,
                //     decoration: BoxDecoration(
                //       borderRadius: const BorderRadius.all(Radius.circular(13)),
                //       color: CustomColor.dark,
                //     ),
                //     child: Center(child: SvgPicture.asset(IconPath.question)),
                //   ),
                // )
              ],
            ),
          ),
          hSize(12),
        ],
      ),
    );
  }

  Future<void> _startProgram() async {
    safePrint('겟바이 프로그램');
    var selectProgram = await ref.read(programController.notifier).getProgramByID(widget.userCareProgram.program.id.toString());
    await ref.watch(careProgramProvider.notifier).setProgramData(selectProgram!);

    safePrint('여기라고 여기라고');
    safePrint(widget.userCareProgram.program.id);
    safePrint(widget.userCareProgram.userCareProgramId);
    if (context.mounted) {
      context.pushNamed('video-guide', queryParams: {
        "care_program_id": widget.userCareProgram.program.id.toString(),
        "user_care_program_id": widget.userCareProgram.userCareProgramId,
        "is_created": "true"
      });
    }
  }
}
