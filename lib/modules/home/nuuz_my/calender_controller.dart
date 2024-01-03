// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nuuz/models/my_nuuz/days.dart';
// import 'package:nuuz/util/log_print.dart';

// final calenderProvider = StateNotifierProvider<CalenderProvider, List<Days>>((ref) {
//   return CalenderProvider();
// });

// class CalenderProvider extends StateNotifier<List<Days>> {
//   CalenderProvider() : super([]);

//   var week = ["일", "월", "화", "수", "목", "금", "토"];
//   static DateTime now = DateTime.now();

//   int year = 0;
//   int month = 0;

//   Days? selectedDay;
//   Days? beforeSelectedDay;
//   int beforeSelectedIndex = 0;
//   bool isNext = true;

//   setFirst(int setYear, int setMonth) {
//     year = setYear;
//     month = setMonth;
//     _insertDays(year, month);
//   }

//   _insertDays(int year, int month) {
//     state.clear();
//     int lastDay = DateTime(now.year, now.month + 1, 0).day;
//     for (var i = 1; i <= lastDay; i++) {
//       if (DateTime(now.year, now.month, now.day + 15).compareTo(DateTime(year, month, i)) < 0) {
//         if (i == 0) {
//           break;
//         } else {
//           state.add(Days(year: year, month: month, day: i, inMonth: true, picked: true, after: true, result: false));
//         }
//       } else {
//         if (month == now.month && i == now.day) {
//           beforeSelectedDay = Days(year: year, month: month, day: i, inMonth: true, picked: true, after: false, result: false);
//           selectedDay = Days(year: year, month: month, day: i, inMonth: true, picked: true, after: false, result: false);
//           beforeSelectedIndex += i - 1;
//           state.add(Days(year: year, month: month, day: i, inMonth: true, picked: true, after: false, result: false));
//           safePrint('이니셜  $beforeSelectedIndex');
//         } else {
//           state.add(Days(year: year, month: month, day: i, inMonth: true, picked: false, after: false, result: false));
//         }
//       }
//     }
//     if (DateTime(year, month, 1).weekday != 7) {
//       List<Days> temp = [];
//       int prevLastDay = DateTime(year, month, 0).day;
//       for (var i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
//         beforeSelectedIndex++;
//         temp.add(Days(year: year, month: month - 1, day: 0, inMonth: false, picked: false, after: false, result: false));
//       }
//       state = [...temp, ...state];
//     }
//   }

//   previousMonth() {
//     if (year != 23 && month != 1) {
//       if (month == 1) {
//         month = 12;
//         year -= 1;
//       } else {
//         month -= 1;
//       }
//       _insertDays(year, month);
//     }
//     for (int i = 0; i < state.length; i++) {
//       if (state[i].after) {
//         isNext = false;
//       } else {
//         isNext = true;
//       }
//     }
//   }

//   nextMonth() {
//     if (month == 12) {
//       month = 1;
//       year += 1;
//     } else {
//       month += 1;
//     }
//     _insertDays(year, month);
//     for (int i = 0; i < state.length; i++) {
//       if (state[i].after) {
//         isNext = false;
//       } else {
//         isNext = true;
//       }
//     }
//   }

//   selectDay(
//     Days day,
//     int index,
//   ) {
//     safePrint('마이뉴즈 $beforeSelectedIndex');
//     safePrint('마이뉴즈 ${state[beforeSelectedIndex!].month}');
//     safePrint('마이뉴즈 ${state[beforeSelectedIndex!].day}');
//     safePrint('마이뉴즈 ${state[beforeSelectedIndex!].picked}');
//     safePrint('마이뉴즈 ${state[3].month}');
//     safePrint('마이뉴즈 ${state[3].day}');

//     // if (beforeSelectedDay == null) {
//     //   selectedDay = day.copyWith(picked: true);
//     //   beforeSelectedDay = day;
//     //   beforeSelectedIndex = index;
//     //   state[index] = selectedDay!;
//     // } else {
//     //   beforeSelectedDay = state[beforeSelectedIndex!].copyWith(picked: false);
//     //   state[beforeSelectedIndex!] = beforeSelectedDay!;
//     //   selectedDay = day.copyWith(picked: true);
//     //   beforeSelectedDay = day;
//     //   beforeSelectedIndex = index;
//     //   state[index] = selectedDay!;
//     // }

//     state[beforeSelectedIndex!] = state[beforeSelectedIndex!].copyWith(picked: false);
//     //state[beforeSelectedIndex!] = beforeSelectedDay!;
//     selectedDay = day.copyWith(picked: true);
//     beforeSelectedDay = day;
//     beforeSelectedIndex = index;
//     state[index] = selectedDay!;
//   }

//   isToday(int year, int month, int day) {
//     if (year == DateTime.now().year && month == DateTime.now().month && day == DateTime.now().day) {
//       return true;
//     }
//     return false;
//   }
// }

// final selectedDayProvider = StateNotifierProvider<SelectedDayProvider, bool>((ref) {
//   return SelectedDayProvider();
// });

// class SelectedDayProvider extends StateNotifier<bool> {
//   SelectedDayProvider() : super(true);

//   DateTime date = DateTime.now();

//   selectDay(int year, int month, int day) {
//     date = DateTime(year, month, day);
//     if (DateTime.now().year == year) {
//       if (DateTime.now().month == month) {
//         if (DateTime.now().day == day) {
//           state = true;
//         } else {
//           state = false;
//         }
//       } else {
//         state = false;
//       }
//     } else {
//       state = false;
//     }
//   }
// }
