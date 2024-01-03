// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:nuuz/ui/common/customContainer.dart';
// import 'package:nuuz/ui/common/padding_sizedbox.dart';
// import 'package:nuuz/ui/theme/color_style.dart';
// import 'package:nuuz/ui/theme/icon_path.dart';
// import 'package:nuuz/ui/theme/text_style.dart';
// import 'package:nuuz/util/log_print.dart';

// import 'calender_controller.dart';
// import 'nuuz_my_controller.dart';

// class MyNuuzCalender extends ConsumerStatefulWidget {
//   const MyNuuzCalender({Key? key}) : super(key: key);

//   @override
//   ConsumerState<MyNuuzCalender> createState() => _MyNuuzCalenderState();
// }

// class _MyNuuzCalenderState extends ConsumerState<MyNuuzCalender> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final controller = ref.watch(calenderProvider.notifier);
//       await controller.setFirst(CalenderProvider.now.year, CalenderProvider.now.month);
//       final days = ref.watch(calenderProvider);
//       for (int i = 0; i < days.length; i++) {
//         if (days[i].after) {
//           controller.isNext = false;
//         } else {
//           controller.isNext = true;
//         }
//       }

//       // final resultDate = ref.watch(resultProvider);
//       // for(int i=0; i<resultDate!.length; i++) {
//       //   for (int j = 0; j < days.length; j++) {
//       //     String year = days[j].year.toString();
//       //     String month = days[j].month.toString();
//       //     if (days[j].month < 10) {month = '0$month';}
//       //     String day = days[j].day.toString();
//       //     if (days[j].day < 10) {month = '0$day';}
//       //     String historyYear = resultDate[i].date.toString().substring(0, 4);
//       //     String historyMonth = resultDate[i].date.toString().substring(5, 7);
//       //     String historyDay = resultDate[i].date.toString().substring(8, 10);
//       //     if (year == historyYear) {
//       //       if (month == historyMonth) {
//       //         if (day == historyDay) {
//       //           safePrint('$historyYear $historyMonth $historyDay  기록있음');
//       //           days[j] = days[j].copyWith(result: true);
//       //         }
//       //       }
//       //     }
//       //   }
//       // }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext context, WidgetRef ref, Widget? child) {
//         final controller = ref.watch(calenderProvider.notifier);
//         final days = ref.watch(calenderProvider);
//         final resultList = ref.watch(resultProvider);
//         return Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Container(
//                 decoration: BoxDecoration(color: CustomColor.white, borderRadius: const BorderRadius.all(Radius.circular(10))),
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(0, 0, 0, 8.h),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             controller.month != 01 && controller.year != 23
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         controller.previousMonth();
//                                       });
//                                     },
//                                     child: SvgPicture.asset(IconPath.calenderPrevious))
//                                 : wSize(24),
//                             Text(
//                               '${controller.year} ${controller.month}월',
//                               style: CustomTextStyle.headerS,
//                             ),
//                             controller.isNext
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         controller.nextMonth();
//                                       });
//                                     },
//                                     child: SvgPicture.asset(IconPath.calenderNext))
//                                 : wSize(24),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           for (var i = 0; i < controller.week.length; i++)
//                             Container(
//                               width: 34.w,
//                               margin: EdgeInsets.symmetric(horizontal: 6.w),
//                               child: Text(
//                                 controller.week[i],
//                                 style: CustomTextStyle.descriptionM,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                         ],
//                       ),
//                       hSize(19),
//                       Wrap(
//                         children: [
//                           for (var i = 0; i < days.length; i++)
//                             GestureDetector(
//                               onTap: days[i].after
//                                   ? null
//                                   : () {
//                                       setState(() {
//                                         controller.selectDay(days[i], i);
//                                         ref.watch(selectedDayProvider.notifier).selectDay(days[i].year, days[i].month, days[i].day);
//                                       });
//                                     },
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
//                                 width: days[i].result ? 50.w : 34.w,
//                                 height: 34.h,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: days[i].picked ? Colors.red : Colors.transparent,
//                                 ),
//                                 child: CustomContainer(
//                                   radius: 100,
//                                   containerColor: days[i].picked ? const Color(0xfff0f0f0) : Colors.transparent,
//                                   child: Column(
//                                     children: [
//                                       hSize(2),
//                                       Text(
//                                         days[i].day.toString(),
//                                         style: CustomTextStyle.headerXS.copyWith(
//                                           color: days[i].day == 0
//                                               ? Colors.transparent
//                                               : controller.isToday(days[i].year, days[i].month, days[i].day)
//                                                   ? CustomColor.red
//                                                   : days[i].after
//                                                       ? CustomColor.gray
//                                                       : CustomColor.dark,
//                                         ),
//                                       ),
//                                       Visibility(
//                                           visible: days[i].picked,
//                                           child: CustomContainer(
//                                             width: 6.w,
//                                             height: 6.h,
//                                             radius: 100,
//                                             containerColor: CustomColor.blue,
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
