import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/result/repository/result_repository.dart';

class ResultNotifier extends AsyncNotifier<List<Result>> {
  final resultRepository = ResultRepository();

  @override
  FutureOr<List<Result>> build() {
    return _fetchResults();
  }

  Future<List<Result>> _fetchResults() {
    return resultRepository.getResults();
  }

  Future<void> postResult(Map<String, String> data) async {
    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async {
    await resultRepository.postResult(data);
    // return _fetchResults();
    // });
  }

  Future<Result?> fetchResultById(String id, String token) {
    return resultRepository.getResultById(id, token);
  }

  Future<void> deleteResult(String resultId) async {
    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async {
    await resultRepository.deleteResult(resultId);
    // return _fetchResults();
    // });
    // await resultRepository.deleteResult(resultId);
    // await getResult();
  }
}

final resultProvider = AsyncNotifierProvider<ResultNotifier, List<Result>>(() {
  return ResultNotifier();
});
