// import 'dart:async';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nuuz/models/nuuz_talk/result.dart';
// import 'package:nuuz/modules/nuuz_talk/providers/review/repository/reviews_repository.dart';

// final resultProvider = AsyncNotifierProvider<ResultNotifier, List<Result>>(() {
//   return ResultNotifier();
// });

// class ResultNotifier extends AsyncNotifier<List<Result>> {
//   final reviewsRepository = ResultRepository();

//   @override
//   FutureOr<List<Result>> build() {
//     return _fetchResults();
//   }

//   Future<List<Result>> _fetchResults() {
//     return reviewsRepository.getResults();
//   }

//   Future<Result?> fetchReviewById(String id) {
//     return reviewsRepository.getResultById(id);
//   }

//   // Future<void> updateUserCarePrograms(Category category) async {
//   //   state = const AsyncValue.loading();
//   //   state = await AsyncValue.guard(() async {
//   //     await categoryRepository.postCategory(category);
//   //     return _fetchUserCarePrograms();
//   //   });
//   // }
// }
