// import 'package:nuuz/models/nuuz_talk/userpost.dart';
// import 'package:nuuz/models/usercareprogram.dart';
// import 'package:nuuz/modules/nuzz_care/care_program/service/user_care_program_service.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'my_data_provider.g.dart';

// @riverpod
// Future<List<UserCareProgram>?> userPostForDate(
//   UserPostForDateRef ref, {
//   required DateTime startDate,
//   required DateTime endDate,
// }) async {
//   final userCareProgramRepository = UserCareProgramRepository();
//   final list = userCareProgramRepository.getUserCareProgramForDateRange(startDate.toIso8601String(), endDate.toIso8601String());
//   List<UserCareProgram> listSuggestion = [];
//   if (list != null) {
//     listSuggestion = (list as List).map((element) {
//       var data = UserCareProgram.fromJson(element).copyWith(startDate: startDate.toIso8601String());
//       return data;
//     }).toList();
//     return listSuggestion;
//   } else {
//     return [];
//   }
// }
