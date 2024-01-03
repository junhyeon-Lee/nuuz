// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:nuuz/modules/nuzz_care/care_program/user_care_program_controller.dart';
// import 'package:nuuz/ui/common/nuuz_container.dart';
// import 'package:nuuz/ui/common/padding_sizedbox.dart';
// import 'package:nuuz/ui/common_widget/common_message_bottom_sheet.dart';
// import 'package:nuuz/ui/common_widget/common_button.dart';
// import 'package:nuuz/ui/common_widget/rest_period_warning_bottom_sheet.dart';
// import 'package:nuuz/ui/theme/color_style.dart';
// import 'package:nuuz/ui/theme/icon_path.dart';
// import 'package:nuuz/ui/theme/text_style.dart';

// class ReservationSheet extends ConsumerStatefulWidget {
//   const ReservationSheet({super.key, required this.programId});

//   final String programId;

//   @override
//   ConsumerState<ReservationSheet> createState() => _ReservationSheetState();
// }

// class _ReservationSheetState extends ConsumerState<ReservationSheet> {
//   final List<String> _daysChipsList = [
//     "Prog_Rese_0010".tr(),
//     "Prog_Rese_0011".tr(),
//     "Prog_Rese_0012".tr(),
//     "Prog_Rese_0013".tr(),
//     "Prog_Rese_0014".tr(),
//     "Prog_Rese_0015".tr(),
//     "Prog_Rese_0016".tr(),
//   ];
//   final List<String> _reservationChipsList = [
//     "Prog_Rese_0021".tr(),
//     "Prog_Rese_0022".tr(),
//     "Prog_Rese_0023".tr(),
//   ];

//   int? _selectedDayIndex;
//   // int? _selectedReservationIndex;
//   // bool _setUpRoutine = false;
//   bool _reservationNotice = false;
//   bool _cheeringNotice = false;
//   final List<String> _filters = [];
//   String? userProgramId;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: NuuzContainer(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               AppBar(
//                 centerTitle: true,
//                 elevation: 0,
//                 backgroundColor: CustomColor.white,
//                 leading: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: InkWell(
//                     onTap: () => context.pop(),
//                     child: SvgPicture.asset(
//                       IconPath.close,
//                     ),
//                   ),
//                 ),
//                 title: Text(
//                   "Prog_Rese_0007".tr(),
//                   style: CustomTextStyle.headerL,
//                 ),
//               ),
//               Divider(height: 16.h),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Prog_Rese_0008".tr(),
//                       style: CustomTextStyle.headerXS,
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       "Prog_Rese_0009".tr(),
//                       style: CustomTextStyle.descriptionS,
//                     ),
//                     SizedBox(height: 4.h),
//                     Wrap(
//                       spacing: 0,
//                       runSpacing: 4,
//                       direction: Axis.horizontal,
//                       children: daysChips(),
//                     ),
//                     SizedBox(height: 4.h),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Prog_Rese_0019".tr(),
//                                 style: CustomTextStyle.headerXS,
//                               ),
//                               hSize(14),
//                               Text(
//                                 "Prog_Rese_0020".tr(),
//                                 style: CustomTextStyle.descriptionM,
//                               ),
//                             ],
//                           ),
//                         ),
//                         wSize(20),
//                         CupertinoSwitch(
//                           activeColor: CustomColor.primary,
//                           value: _reservationNotice,
//                           onChanged: (value) {
//                             setState(() {
//                               _reservationNotice = value;
//                             });
//                           },
//                         )
//                       ],
//                     ),
//                     hSize(12),
//                     Wrap(
//                       spacing: 6,
//                       direction: Axis.horizontal,
//                       children: reservationTimeChips(),
//                     ),
//                     hSize(12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Prog_Rese_0024".tr(),
//                                 style: CustomTextStyle.headerXS,
//                               ),
//                               hSize(14),
//                               Text(
//                                 "Prog_Rese_0025".tr(),
//                                 style: CustomTextStyle.descriptionM,
//                               ),
//                             ],
//                           ),
//                         ),
//                         wSize(20),
//                         CupertinoSwitch(
//                           activeColor: CustomColor.primary,
//                           value: _cheeringNotice,
//                           onChanged: (value) {
//                             setState(() {
//                               _cheeringNotice = value;
//                             });
//                           },
//                         )
//                       ],
//                     ),
//                     hSize(50),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Expanded(child: CommonOutlinedButton(onPressed: () => context.pop(), child: Text('Comm_Gene_0006'.tr()))),
//                           wSize(16),
//                           Consumer(builder: (context, ref, _) {
//                             return Expanded(
//                               child: CommonButton(
//                                   onPressed: () async {
//                                     var todayDay = DateFormat.E().format(DateTime.now());
//                                     var dayIndex = _daysChipsList.indexOf(todayDay);
//                                     DateTime startDate;
//                                     if (_selectedDayIndex! < dayIndex) {
//                                       startDate = DateTime.now().add(Duration(days: 7 - (dayIndex - _selectedDayIndex!)));
//                                     } else {
//                                       startDate = DateTime.now().add(Duration(days: _selectedDayIndex! - dayIndex));
//                                     }
//                                     var userCareProgramData = {
//                                       "program_id": widget.programId,
//                                       "start_day": _daysChipsList[_selectedDayIndex ?? 0],
//                                       "start_date": startDate.toUtc().toIso8601String(),
//                                       "reservation_notice": {
//                                         "send_reminder": _reservationNotice ? 1 : 0,
//                                         "reminder_time": _filters
//                                       },
//                                       "cheering_notice": _cheeringNotice ? 1 : 0,
//                                       "status": "created",
//                                       // "force": true,
//                                     };
//                                     try {
//                                       userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
//                                     } catch (e) {
//                                       await showModalBottomSheet(
//                                         context: context,
//                                         backgroundColor: Colors.transparent,
//                                         builder: (context) => _errorBottomSheet(e, userCareProgramData),
//                                       );
//                                     }
//                                     if (userProgramId != null) {
//                                       ref.invalidate(userCareProgramProvider);
//                                       ref.invalidate(userCareProgramForDateRangeProvider);
//                                       if (mounted) {
//                                         context.pop();
//                                         showModalBottomSheet(
//                                           context: context,
//                                           backgroundColor: Colors.transparent,
//                                           builder: (context) {
//                                             return CommonMessageBottomSheet(
//                                               headerText: "Comm_Gene_0028".tr(),
//                                               descriptionText: "Prog_Rese_0027".tr(),
//                                               onPrimaryButtonPressed: () => context.go('/main'),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     }
//                                     // await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
//                                     // ref.invalidate(userCareProgramProvider);
//                                     // ref.invalidate(userCareProgramForDateRangeProvider);
//                                     // if (mounted) {
//                                     //   context.pop();
//                                     //   showModalBottomSheet(
//                                     //     context: context,
//                                     //     backgroundColor: Colors.transparent,
//                                     //     builder: (context) {
//                                     //       return CommonMessageBottomSheet(
//                                     //         headerText: "Comm_Gene_0028".tr(),
//                                     //         descriptionText: "Prog_Rese_0027".tr(),
//                                     //         onPrimaryButtonPressed: () => context.go('/main'),
//                                     //       );
//                                     //     },
//                                     //   );
//                                     // }
//                                   },
//                                   text: "Comm_Gene_0016".tr()),
//                             );
//                           })
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _errorBottomSheet(e, Map userCareProgramData) {
//     if ((e as DioError).response?.data['response'] != null) {
//       if (e.response?.data['response'] == 'restPeriod in progress') {
//         return RestPeriodWarningBottomSheet(
//           onSecondaryButtonTap: () async {
//             userCareProgramData.addAll(<String, dynamic>{
//               "force": true
//             });
//             userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
//           },
//         );
//       } else if (e.response?.data['response'] == 'moreThan2Bookings') {
//         return CommonMessageBottomSheet(
//           headerText: 'Comm_Gene_0005'.tr(),
//           descriptionText: 'Prog_Rese_0001'.tr(),
//           primaryButtonText: 'Comm_Gene_0006'.tr(),
//           onPrimaryButtonPressed: () async {
//             context.pop();
//           },
//           secondaryButtonText: 'Prog_Rese_0002'.tr(),
//           onSecondaryButtonPressed: () async {
//             userCareProgramData.addAll(<String, dynamic>{
//               "force": true
//             });
//             userProgramId = await ref.read(userCareProgramProvider.notifier).createUserCarePrograms(userCareProgramData);
//           },
//         );
//       } else {
//         return CommonMessageBottomSheet(
//           headerText: 'Comm_Gene_0005'.tr(),
//           descriptionText: e.response!.data['response'],
//         );
//       }
//     } else {
//       return const SizedBox();
//     }
//   }

//   List<Widget> daysChips() {
//     List<Widget> chips = [];
//     for (int i = 0; i < _daysChipsList.length; i++) {
//       Widget item = Padding(
//         padding: const EdgeInsets.only(left: 2, right: 2),
//         child: ChoiceChip(
//           shape: RoundedRectangleBorder(side: _selectedDayIndex == i ? BorderSide.none : BorderSide(color: CustomColor.lightDark.withOpacity(0.7)), borderRadius: BorderRadius.circular(14)),
//           label: SizedBox(
//             width: 55.w,
//             height: 36.h,
//             child: Center(
//               child: Text(
//                 _daysChipsList[i],
//                 style: TextStyle(
//                   color: _selectedDayIndex == i ? CustomColor.white : CustomColor.dark,
//                 ),
//               ),
//             ),
//           ),
//           // labelStyle: TextStyle(color: CustomColor.dark),
//           labelStyle: CustomTextStyle.nicknameM,
//           backgroundColor: CustomColor.white,
//           selected: _selectedDayIndex == i,
//           selectedColor: CustomColor.primary,
//           onSelected: (bool value) {
//             setState(() {
//               _selectedDayIndex = i;
//             });
//           },
//         ),
//       );
//       chips.add(item);
//     }
//     return chips;
//   }

//   List<Widget> reservationTimeChips() {
//     List<Widget> chips = [];
//     for (int i = 0; i < _reservationChipsList.length; i++) {
//       Widget item = Padding(
//         padding: const EdgeInsets.only(left: 2, right: 2),
//         child: ChoiceChip(
//           shape: RoundedRectangleBorder(side: _filters.contains(_reservationChipsList[i]) ? BorderSide.none : BorderSide(color: CustomColor.lightDark.withOpacity(0.7)), borderRadius: BorderRadius.circular(14)),
//           label: SizedBox(
//             width: 80.w,
//             height: 36.h,
//             child: Center(
//               child: Text(
//                 _reservationChipsList[i],
//                 style: TextStyle(
//                   color: _filters.contains(_reservationChipsList[i]) ? CustomColor.white : CustomColor.dark,
//                 ),
//               ),
//             ),
//           ),
//           // labelStyle: TextStyle(color: CustomColor.dark),
//           labelStyle: CustomTextStyle.nicknameM,
//           backgroundColor: CustomColor.white,
//           selected: _filters.contains(_reservationChipsList[i]),
//           selectedColor: CustomColor.primary,
//           onSelected: (bool value) {
//             setState(() {
//               if (value) {
//                 _filters.add(_reservationChipsList[i]);
//               } else {
//                 _filters.removeWhere((String name) {
//                   return name == _reservationChipsList[i];
//                 });
//               }
//             });
//           },
//         ),
//       );
//       chips.add(item);
//     }
//     return chips;
//   }
// }
