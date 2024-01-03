import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nuuz/models/my_nuuz/calendar_event.dart';
import 'package:nuuz/models/my_nuuz/programlist.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_controller.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_widgets.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/care_program_result_list_item.dart';
import 'package:nuuz/modules/nuzz_care/care_program/program_controller.dart';
import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/result_provider.dart';
import 'package:nuuz/ui/common/customContainer.dart';
import 'package:nuuz/ui/common/nuuz_container.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/common_widget/common_button.dart';
import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
import 'package:nuuz/ui/common_widget/reserve_care_program.dart';
import 'package:nuuz/ui/common_widget/upcoming_care_program.dart';
import 'package:nuuz/ui/indicator/indicator.dart';
import 'package:nuuz/ui/indicator/loading_screen.dart';
import 'package:nuuz/ui/theme/color_style.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:table_calendar/table_calendar.dart';

final myNuuzStartDateProvider = StateProvider<String>((ref) {
  return DateTime.utc(DateTime.now().year, DateTime.now().month, 1).toIso8601String();
});

final myNuuzEndDateProvider = StateProvider<String>((ref) {
  return DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0).toIso8601String();
});

final selectedDateProvider = StateProvider<String>((ref) {
  return DateTime.now().toIso8601String();
});

class NuuzMyScreen extends ConsumerStatefulWidget {
  const NuuzMyScreen({super.key});

  @override
  ConsumerState<NuuzMyScreen> createState() => _NuuzMyScreenState();
}

class _NuuzMyScreenState extends ConsumerState<NuuzMyScreen> with AutomaticKeepAliveClientMixin<NuuzMyScreen> {
  // final focusDay = ref.watch(focusProvider);
  // final selectDay = ref.watch(selectedProvider);

  // late DateTime _focusedDay;
  // DateTime? _selectedDay;
  late DateTime today;
  // late String startDate;
  // late String endDate;
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    // _focusedDay = now;
    // _selectedDay = now;
    today = DateTime(now.year, now.month, now.day);
    // startDate = DateTime.utc(today.year, today.month, 1).toIso8601String();
    // endDate = DateTime.utc(today.year, today.month + 1, 0).toIso8601String();
  }

  Widget _pastCareProgramNotice(UserCareProgram program) {
    return NuuzContainer(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: CustomColor.white,
              title: Text(
                "Comm_Gene_0002".tr(),
                style: CustomTextStyle.headerL,
              ),
            ),
            Divider(
              height: 40.h,
              thickness: 1.h,
            ),
            Text(
              "Mynu_Cale_0001".tr(),
              textAlign: TextAlign.center,
              style: CustomTextStyle.descriptionL,
            ),
            hSize(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              decoration: BoxDecoration(color: CustomColor.lightWhite, border: Border.all(color: CustomColor.dark), borderRadius: BorderRadius.circular(20)),
              child: Text(
                DateFormat('MMMM d, yyyy').format(DateTime.parse(program.startDate)),
                style: CustomTextStyle.headerXS,
              ),
            ),
            hSize(16),
            CareProgramListItem(
              name: program.program.name.tr(),
              description: program.program.description!.tr(),
              imageUrl: program.program.image,
            ),
            hSize(20),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    onPressed: () async {
                      var result = await ref.read(userCareProgramProvider.notifier).deleteUserCarePrograms(program.userCareProgramId);
                      if (result.hasError) {
                        if (mounted) {
                          await showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => CommonMessageBottomSheet(headerText: 'Prog_Rese_0003'.tr(), descriptionText: (result.error as DioError).response!.data['message']),
                          );
                          if (mounted) context.pop();
                        }
                      } else {
                        if (mounted) {
                          context.pop();
                        }
                        ref.invalidate(userCareProgramForDateRangeProvider);
                        ref.invalidate(userCareProgramProvider);
                      }
                    },
                    text: "Comm_Gene_0034".tr(),
                    // child: Text("Comm_Gene_0034".tr()),
                  ),
                ),
                // wSize(12),
                // Expanded(
                //   child: CommonButton(
                //     onPressed: () async {
                //       await ref.read(userCareProgramProvider.notifier).deleteUserCarePrograms(program.userCareProgramId);
                //       ref.invalidate(userCareProgramProvider);
                //       ref.invalidate(userCareProgramForDateRangeProvider);
                //       if (mounted) {
                //         context.pop();
                //         setState(() {
                //           _selectedDay = today;
                //           _focusedDay = today;
                //         });
                //         // context.pushNamed('program-list',);
                //       }
                //     },
                //     text: "Comm_Gene_0016".tr(),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final startDate = ref.watch(myNuuzStartDateProvider);
    final endDate = ref.watch(myNuuzEndDateProvider);
    final selectedDay = ref.watch(selectedDateProvider);
    final userCareProgramsForDateRange = ref.watch(UserCareProgramForDateRangeProvider(startDate, endDate));
    final resultsForDateRange = ref.watch(resultsForDateRangeProvider(startDate, endDate));
    ref.listen(UserCareProgramForDateRangeProvider(startDate, endDate), (previous, next) {
      if (!next.isLoading) {
        next
            .whenData(
          (value) => value!.where(
            (element) => DateTime.tryParse(element.startDate) != null
                ? (DateTime.parse(element.startDate).isBefore(today) && element.status != 'completed')
                    ? true
                    : false
                : false,
          ),
        )
            .whenOrNull(
          data: (data) {
            if (data.isNotEmpty) {
              return showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => _pastCareProgramNotice(data.last),
              );
            }
          },
        );
      }
    });
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {

        return RefreshIndicator(
          color: CustomColor.dark,
          onRefresh: () async {
            ref.watch(loadingProvider.notifier).isLoadingTrue();
           ref.invalidate(userCareProgramForDateRangeProvider);
            ref.invalidate(resultsForDateRangeProvider);
           await Future.delayed(const Duration(seconds: 1),(){});
            ref.watch(loadingProvider.notifier).isLoadingFalse();
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                hSize(6),
                // const MyNuuzCalender(),
                // hSize(20),
                resultsForDateRange.when(
                  data: (resultList) {
                    // hSize(12),
                    return userCareProgramsForDateRange.when(
                      data: (userCareProgramsList) {
                        userCareProgramsList!.removeWhere((element) => element.status == 'completed');
                        final List<MyEvent> calenderEvents = resultList?.resultData != null ? resultList!.resultData!.map((e) => MyEvent.fromResult(e)).toList() : [];
                        calenderEvents.addAll(userCareProgramsList.map((e) => MyEvent.fromUserCareProgram(e)).toList());
                        var count = 0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              NuuzContainer(
                                child: TableCalendar<MyEvent>(
                                  rowHeight: 40,
                                  availableGestures: AvailableGestures.none,
                                  headerStyle: HeaderStyle(
                                    titleCentered: true,
                                    formatButtonVisible: false,
                                    titleTextStyle: CustomTextStyle.headerS,
                                    leftChevronPadding: EdgeInsets.zero,
                                    rightChevronPadding: EdgeInsets.zero,
                                  ),
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                    weekdayStyle: CustomTextStyle.descriptionM,
                                    weekendStyle: CustomTextStyle.descriptionM,
                                  ),
                                  calendarStyle: CalendarStyle(
                                    cellMargin: EdgeInsets.zero,
                                    outsideDaysVisible: false,
                                    selectedTextStyle: CustomTextStyle.headerXS.copyWith(color: isSameDay(DateTime.parse(selectedDay), today) ? CustomColor.red : CustomColor.black),
                                    selectedDecoration: BoxDecoration(color: CustomColor.gray, shape: BoxShape.circle),
                                    todayDecoration: const BoxDecoration(),
                                    todayTextStyle: CustomTextStyle.headerXS.copyWith(color: CustomColor.red),
                                    defaultTextStyle: CustomTextStyle.headerXS,
                                    weekendTextStyle: CustomTextStyle.headerXS,
                                    disabledTextStyle: CustomTextStyle.headerXS.copyWith(color: CustomColor.gray),
                                  ),
                                  calendarBuilders: CalendarBuilders(
                                    markerBuilder: (context, day, events) {
                                      if (day.isBefore(today)) {
                                        return Container(
                                          height: 8.0,
                                          width: 8.0,
                                          margin: const EdgeInsets.all(0.5),
                                          decoration: BoxDecoration(
                                            // provide your own condition here
                                            color: events.isNotEmpty ? CustomColor.dark : Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                        );
                                      } else if (isSameDay(day, today)) {
                                        return Container(
                                          height: 8.0,
                                          width: 8.0,
                                          margin: const EdgeInsets.all(0.5),
                                          decoration: BoxDecoration(
                                            // provide your own condition here
                                            color: events.isNotEmpty ? CustomColor.red : Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          height: 8.0,
                                          width: 8.0,
                                          margin: const EdgeInsets.all(0.5),
                                          decoration: BoxDecoration(
                                            // provide your own condition here
                                            color: events.isNotEmpty ? CustomColor.blue : Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  focusedDay: DateTime.parse(selectedDay),
                                  // locale: 'ko',
                                  firstDay: DateTime(2000),
                                  lastDay: now.add(
                                    const Duration(days: 30),
                                  ),
                                  eventLoader: (day) {
                                    return calenderEvents.where((element) => isSameDay(DateTime.parse(element.eventDate), day)).toList();
                                  },
                                  selectedDayPredicate: (day) => isSameDay(DateTime.parse(selectedDay), day),
                                  onDaySelected: (selectionDay, focusedDay) {
                                    if (!isSameDay(DateTime.parse(selectedDay), selectionDay)) {
                                      // setState(() {
                                      // _selectedDay = selectionDay;
                                      // _focusedDay = focusedDay;
                                      // });
                                      ref.read(selectedDateProvider.notifier).state = selectionDay.toIso8601String();
                                    }
                                  },
                                  onPageChanged: (focusedDay) {
                                    ref.read(selectedDateProvider.notifier).state = focusedDay.toIso8601String();
                                    // _focusedDay = focusedDay;
                                    ref.read(myNuuzStartDateProvider.notifier).update((state) => DateTime.utc(focusedDay.year, focusedDay.month, 1).toIso8601String());
                                    ref.read(myNuuzEndDateProvider.notifier).update((state) => DateTime.utc(focusedDay.year, focusedDay.month + 1, 0).toIso8601String());
                                    // ref.read(ResultsForDateRangeProvider(startDate, endDate));
                                    // ref.read(UserCareProgramForDateRangeProvider(startDate, endDate));
                                    // setState(() {});
                                  },
                                ),
                              ),
                              hSize(12),
                              ...resultList!.resultData!.map((e) {
                                var date = DateTime.tryParse(e.date!);
                                if (isSameDay(date, DateTime.parse(selectedDay))) {
                                  // if (date!.year == selectDay!.year && date.month == selectDay.month && date.day == selectDay.day) {
                                  count++;
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          e.result_image != null
                                              ? context.pushNamed('/detailGallery', queryParams: {
                                            "selectedId": e.result_id
                                          })
                                              : context.pushNamed('/oneResult', queryParams: {
                                            "selectedId": e.result_id
                                          });
                                        },
                                        child: CareProgramResultListItem(
                                          name: e.program!.care_program_name!,
                                          description: e.program!.description,
                                          imageUrl: e.result_image,
                                          trailingDelete: true,
                                          onTrailingButtonTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) => CommonMessageBottomSheet(
                                                headerText: "Comm_Gene_0005".tr(),
                                                descriptionText: "Mynu_Cale_0003".tr(),
                                                primaryButtonText: "Comm_Gene_0006".tr(),
                                                secondaryButtonText: "Comm_Gene_0017".tr(),
                                                onSecondaryButtonPressed: () async {
                                                  if (e.result_image != null) {
                                                    //TODO delete the image
                                                  }
                                                  await ref.read(resultProvider.notifier).deleteResult(e.result_id!);
                                                  ref.invalidate(resultsForDateRangeProvider);
                                                },
                                              ),
                                            );
                                          },
                                          date: e.date!,
                                        ),
                                      ),
                                      hSize(12),
                                    ],
                                  );
                                }
                                return const SizedBox();
                              }).toList(),
                              ...userCareProgramsList.map((e) {
                                var date = DateTime.tryParse(e.startDate);
                                if (isSameDay(date, DateTime.parse(selectedDay))) {
                                  // if (date!.year == selectDay!.year && date.month == selectDay.month && date.day == selectDay.day) {
                                  count++;
                                  return Column(
                                    children: [
                                      UpcomingCareProgram(
                                        userCareProgram: e,
                                        trailingDelete: true,
                                        onTrailingButtonTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => CommonMessageBottomSheet(
                                              headerText: "Comm_Gene_0052".tr(),
                                              descriptionText: "Mynu_Cale_0002".tr(),
                                              primaryButtonText: "Comm_Gene_0006".tr(),
                                              secondaryButtonText: "Comm_Gene_0017".tr(),
                                              onSecondaryButtonPressed: () async {
                                                await ref.read(userCareProgramProvider.notifier).deleteUserCarePrograms(e.userCareProgramId);
                                                ref.invalidate(userCareProgramProvider);
                                                ref.invalidate(userCareProgramForDateRangeProvider);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      hSize(8)
                                    ],
                                  );
                                }
                                return const SizedBox();
                              }).toList(),
                              selectedDay == null
                                  ? const SizedBox()
                                  : DateTime.parse(selectedDay).isBefore(today)
                                  ? count < 2
                                  ? Column(
                                children: List.filled(
                                  2,
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () async {
                                      programBottomSheet(context, DateTime.parse(selectedDay));
                                    },
                                    child: defaultItem(),
                                  ),
                                ),
                              )
                                  : count < 3
                                  ? GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  programBottomSheet(context, DateTime.parse(selectedDay));
                                },
                                child: defaultItem(),
                              )
                                  : const SizedBox()
                                  : count < 3
                                  ? ReserveCareProgram(
                                titleVisible: false,
                                reservationDate: selectedDay,
                              )
                                  : const SizedBox(),
                            ],
                          ),
                        );
                      },
                      error: (error, stackTrace) => const Text('error'),
                      loading: () => loadingScreen(),
                    );
                  },
                  error: (error, stackTrace) => const Text('err'),
                  loading: () => loadingScreen()),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> programBottomSheet(context, /* ProgramList programList,*/ DateTime selectedDate) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        backgroundColor: CustomColor.background,
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: EdgeInsets.all(20.h),
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
                          'Comm_Gene_0038'.tr(),
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
                    Expanded(
                      child: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          // final date = ref.watch(selectedDayProvider.notifier).date;
                          final programList = ref.watch(programController.future);
                          final date = selectedDate;
                          return FutureBuilder<List<Program>>(
                            future: programList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return const Center(
                                  child: CustomIndicator(''),
                                );
                              }
                              final programs = ProgramList(status: true, careProgram: snapshot.data);
                              return ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      OverlayLoadingProgress.start(
                                        context,
                                        barrierDismissible: false,
                                        widget: const CustomIndicator(''),
                                      );
                                      final result = {
                                        "programId": programs.careProgram![index].id.toString(),
                                        "date": date.toIso8601String()
                                      };
                                      await ref.read(resultProvider.notifier).postResult(result);
                                      ref.invalidate(resultProvider);
                                      ref.invalidate(resultsForDateRangeProvider);
                                      OverlayLoadingProgress.stop();
                                      if (mounted) {
                                        context.pop();
                                      }
                                    },
                                    child: programItem(programs.careProgram![index]),
                                    // child: CareProgramListItem(
                                    //   name: snapshot.data!.careProgram![index].care_program_name!,
                                    //   description: snapshot.data!.careProgram![index].description,
                                    //   imageUrl: snapshot.data!.careProgram![index].,
                                    //   ),
                                  );
                                },
                                itemCount: programs.careProgram!.length,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget programItem(Program program) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Stack(
        children: [
          CustomContainer(
            width: double.infinity,
            radius: 12,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomContainer(
                    width: 96.h,
                    height: 96.h,
                    radius: 8,
                    borderColor: CustomColor.lightGray,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: program.image != null
                          ? CachedNetworkImage(imageUrl: program.image!)
                          : const Center(
                              child: Text('No image'),
                            ),
                    ),
                  ),
                  wSize(14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          hSize(6),
                          SizedBox(
                            width: 200.w,
                            child: RichText(
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: program.name.tr(),
                                  style: CustomTextStyle.buttonM,
                                ),
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 205.w,
                            child: RichText(
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: program.description?.tr(),
                                  style: CustomTextStyle.descriptionM,
                                ),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      hSize(17),
                      CustomContainer(
                        radius: 18,
                        containerColor: CustomColor.dark,
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: SvgPicture.asset(IconPath.nuuzMe),
                        ),
                      )
                    ],
                  ),
                  //  SvgPicture.asset(IconPath.plus),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10.w,
            top: 14.h,
            child: CustomContainer(
                width: 16.w,
                height: 16.h,
                containerColor: CustomColor.primary,
                child: CustomContainer(
                    width: 8.w,
                    height: 8.h,
                    containerColor: CustomColor.primary,
                    child: SvgPicture.asset(
                      IconPath.plus,
                      color: Colors.white,
                    ))),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

final focusProvider = StateNotifierProvider<FocusProvider, DateTime>((ref) {
  return FocusProvider();
});

class FocusProvider extends StateNotifier<DateTime> {
  FocusProvider() : super(DateTime.now());

  setFocus(DateTime date) {
    state = date;
  }
}

final selectedProvider = StateNotifierProvider<SelectedProvider, DateTime>((ref) {
  return SelectedProvider();
});

class SelectedProvider extends StateNotifier<DateTime> {
  SelectedProvider() : super(DateTime.now());

  setFocus(DateTime date) {
    state = date;
  }
}
