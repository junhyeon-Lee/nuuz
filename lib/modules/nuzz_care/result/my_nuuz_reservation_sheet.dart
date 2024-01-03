import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_nuuz/reservation_notice_model.dart';
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/rest_period_warning_bottom_sheet.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/notification_service.dart';

class MyNuuzReservationSheet extends ConsumerStatefulWidget {
  const MyNuuzReservationSheet({super.key, required this.programId, required this.reservationDate});

  final String programId;
  final String reservationDate;

  @override
  ConsumerState<MyNuuzReservationSheet> createState() => _MyNuuzReservationSheetState();
}

class _MyNuuzReservationSheetState extends ConsumerState<MyNuuzReservationSheet> {
  // final List<String> _daysChipsList = [
  //   "Prog_Rese_0010".tr(),
  //   "Prog_Rese_0011".tr(),
  //   "Prog_Rese_0012".tr(),
  //   "Prog_Rese_0013".tr(),
  //   "Prog_Rese_0014".tr(),
  //   "Prog_Rese_0015".tr(),
  //   "Prog_Rese_0016".tr(),
  // ];

  /* final List<String> _reservationChipsList = [
    "Prog_Rese_0021".tr(),
    "Prog_Rese_0022".tr(),
    "Prog_Rese_0023".tr(),
  ];*/

  List<String> _reservationFilterList = [];

  // int? _selectedDayIndex;
  // int? _selectedReservationIndex;
  // bool _setUpRoutine = false;
  bool _reservationNotice = true;
  bool _cheeringNotice = true;
  List<ReservationNoticeModel> _filters = [];
  String? userProgramId;

  LocalDB localDB = LocalDB();
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.watch(timeSelectorProvider.notifier).setDay(widget.reservationDate);

      _filters = await localDB.getReservationNoticeList();
      safePrint('끌어오기');
      safePrint(_filters);
      for (int i = 0; i < _filters.length; i++) {
        safePrint(_filters[i].title);
      }
      _reservationNotice = await localDB.getReservationNoticeSwitch();
      _cheeringNotice = await localDB.getCheeringNoticeInfo();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final notiTime = ref.watch(timeSelectorProvider);
    return SingleChildScrollView(
      child: NuuzContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: CustomColor.white,
                leading: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(
                      IconPath.close,
                    ),
                  ),
                ),
                title: Text(
                  "Prog_Rese_0007".tr(),
                  style: CustomTextStyle.textStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Divider(height: 16.h),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Prog_Rese_0008".tr(),
                    //   style: CustomTextStyle.headerXS,
                    // ),
                    // SizedBox(height: 4.h),자자자
                    // Text(
                    //   "Prog_Rese_0009".tr(),
                    //   style: CustomTextStyle.descriptionS,
                    // ),
                    // SizedBox(height: 4.h),
                    // Wrap(
                    //   spacing: 0,
                    //   runSpacing: 4,
                    //   direction: Axis.horizontal,
                    //   children: daysChips(),
                    // ),
                    // SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Prog_Rese_0019".tr(), //reservation notice
                                style: CustomTextStyle.headerXS,
                              ),
                              hSize(14),
                              Text(
                                "Prog_Rese_0020".tr(),
                                style: CustomTextStyle.descriptionM,
                              ),
                            ],
                          ),
                        ),
                        wSize(20),
                        CupertinoSwitch(
                          activeColor: CustomColor.primary,
                          value: _reservationNotice,
                          onChanged: (value) {
                            setState(() {
                              _reservationNotice = value;
                              localDB.setReservationNoticeSwitch(value);
                            });
                          },
                        )
                      ],
                    ),
                    hSize(12),
                    if (_reservationNotice) timeSelector(),

                    hSize(14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Prog_Rese_0024".tr(),
                                style: CustomTextStyle.headerXS,
                              ),
                              hSize(14),
                              Text(
                                "Prog_Rese_0025".tr(),
                                style: CustomTextStyle.descriptionM,
                              ),
                            ],
                          ),
                        ),
                        wSize(20),
                        CupertinoSwitch(
                          activeColor: CustomColor.primary,
                          value: _cheeringNotice,
                          onChanged: (value) {
                            setState(() {
                              _cheeringNotice = value;
                              localDB.updateCheeringNoticeInfo(value);
                            });
                          },
                        )
                      ],
                    ),
                    hSize(50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: CommonOutlinedButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text('Comm_Gene_0006'.tr()),
                            ),
                          ),
                          wSize(13),
                          Consumer(builder: (context, ref, _) {
                            final notiTime = ref.watch(timeSelectorProvider);
                            return Expanded(
                              child: CommonButton(
                                onPressed: () async {
                                  Map<String, dynamic> userCareProgramData = {
                                    "program_id": widget.programId,
                                    // "start_day": _daysChipsList[_selectedDayIndex ?? 0],
                                    "start_date": widget.reservationDate,
                                    "reservation_notice": {
                                      "send_reminder": _reservationNotice ? 1 : 0,
                                      "reminder_time": [
                                        DateTime(notiTime.year, notiTime.month, notiTime.day, notiTime.hour, notiTime.minute).toString()
                                      ]
                                    },
                                    "cheering_notice": _cheeringNotice ? 1 : 0,
                                    "status": "created",
                                    // "force": true,
                                  };

                                  try {
                                    userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
                                  } catch (e) {
                                    await showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => _errorBottomSheet(e, userCareProgramData),
                                    );
                                  }
                                  if (userProgramId != null) {
                                    ref.invalidate(userCareProgramProvider);
                                    ref.invalidate(userCareProgramForDateRangeProvider);
                                    if (mounted) {
                                      context.pop();
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return CommonMessageBottomSheet(
                                            headerText: "Comm_Gene_0028".tr(),
                                            descriptionText: "Prog_Rese_0027".tr(),
                                            onPrimaryButtonPressed: () => context.go('/main'),
                                          );
                                        },
                                      );
                                    }
                                  }

                                  // await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
                                  // ref.invalidate(userCareProgramProvider);
                                  // ref.invalidate(userCareProgramForDateRangeProvider);
                                  // if (mounted) {
                                  //   context.pop();
                                  //   showModalBottomSheet(
                                  //     context: context,
                                  //     backgroundColor: Colors.transparent,
                                  //     builder: (context) {
                                  //       return CommonMessageBottomSheet(
                                  //         headerText: "Comm_Gene_0028".tr(),
                                  //         descriptionText: "Prog_Rese_0027".tr(),
                                  //         onPrimaryButtonPressed: () => context.go('/main'),
                                  //       );
                                  //     },
                                  //   );
                                  // }
                                },
                                text: "Comm_Gene_0016".tr(), //reservation
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _errorBottomSheet(e, Map userCareProgramData) {
    if ((e as DioError).response?.data['response'] != null) {
      if (e.response?.data['response'] == 'restPeriod in progress') {
        return RestPeriodWarningBottomSheet(
          onSecondaryButtonTap: () async {
            userCareProgramData.addAll(<String, dynamic>{"force": true});
            userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
          },
        );
      } else if (e.response?.data['response'] == 'moreThan2Bookings') {
        return CommonMessageBottomSheet(
          headerText: 'Comm_Gene_0005'.tr(),
          descriptionText: 'Prog_Rese_0001'.tr(),
          primaryButtonText: 'Comm_Gene_0006'.tr(),
          onPrimaryButtonPressed: () async {
            context.pop();
          },
          secondaryButtonText: 'Prog_Rese_0002'.tr(),
          onSecondaryButtonPressed: () async {
            userCareProgramData.addAll(<String, dynamic>{"force": true});
            userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
          },
        );
      } else {
        return CommonMessageBottomSheet(
          headerText: 'Comm_Gene_0005'.tr(),
          descriptionText: e.response!.data['response'],
        );
      }
    } else {
      return const SizedBox();
    }
  }

  // List<Widget> daysChips() {
  //   List<Widget> chips = [];
  //   for (int i = 0; i < _daysChipsList.length; i++) {
  //     Widget item = Padding(
  //       padding: const EdgeInsets.only(left: 2, right: 2),
  //       child: ChoiceChip(
  //         shape: RoundedRectangleBorder(side: _selectedDayIndex == i ? BorderSide.none : BorderSide(color: CustomColor.lightDark.withOpacity(0.7)), borderRadius: BorderRadius.circular(14)),
  //         label: SizedBox(
  //           width: 55.w,
  //           height: 36.h,
  //           child: Center(
  //             child: Text(
  //               _daysChipsList[i],
  //               style: TextStyle(
  //                 color: _selectedDayIndex == i ? CustomColor.white : CustomColor.dark,
  //               ),
  //             ),
  //           ),
  //         ),
  //         // labelStyle: TextStyle(color: CustomColor.dark),
  //         labelStyle: CustomTextStyle.nicknameM,
  //         backgroundColor: CustomColor.white,
  //         selected: _selectedDayIndex == i,
  //         selectedColor: CustomColor.primary,
  //         onSelected: (bool value) {
  //           setState(() {
  //             _selectedDayIndex = i;
  //           });
  //         },
  //       ),
  //     );
  //     chips.add(item);
  //   }
  //   return chips;
  // }

  Widget timeSelector() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final selectedTime = ref.watch(timeSelectorProvider);
        final controller = ref.watch(timeSelectorProvider.notifier);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.subtract30min();
                },
                child: CustomContainer(
                  width: 60.w,
                  height: 40.h,
                  radius: 13,
                  borderColor: CustomColor.dark,
                  child: Center(
                      child: Text(
                    '-',
                    style: CustomTextStyle.buttonM,
                  )),
                ),
              ),
              CustomContainer(
                width: 160.w,
                height: 40.h,
                radius: 13,
                containerColor: CustomColor.darkGray,
                child: Center(
                    child: Text(
                  '${selectedTime.hour.toString()} : ${selectedTime.minute == 0 ? '00' : selectedTime.minute.toString()}',
                  style: CustomTextStyle.buttonM.copyWith(color: CustomColor.primary),
                )),
              ),
              GestureDetector(
                onTap: () {
                  controller.add30min();
                },
                child: CustomContainer(
                  width: 60.w,
                  height: 40.h,
                  radius: 13,
                  borderColor: CustomColor.dark,
                  child: Center(
                      child: Text(
                    '+',
                    style: CustomTextStyle.buttonM,
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final timeSelectorProvider = StateNotifierProvider<TimeSelectorProvider, DateTime>((ref) {
  return TimeSelectorProvider();
});

class TimeSelectorProvider extends StateNotifier<DateTime> {
  TimeSelectorProvider() : super(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 30));

  setDay(String reservationDay) {
    DateTime getReservation = DateTime.parse(reservationDay);
    state = DateTime(getReservation.year, getReservation.month, getReservation.day, 17, 30);
  }

  add30min() {
    if (state.hour == 23 && state.minute == 30) {
      safePrint('뒤로 끝');
    } else {
      state = state.add(const Duration(minutes: 30));
    }
  }

  subtract30min() {
    if (state.hour == 0 && state.minute == 0) {
      safePrint('앞으로 끝');
    } else {
      state = state.subtract(const Duration(minutes: 30));
    }
  }
}
