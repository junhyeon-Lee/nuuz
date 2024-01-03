import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/my_nuuz/resultlist.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nuuz_my_controller.g.dart';

@Riverpod(keepAlive: true)
Future<ResultList?> resultsForDateRange(Ref ref, String startDate, String endDate) {
  final myNuuzRepository = MyNuuzRepository();
  // final startDate = ref.watch(myNuuzStartDateProvider);
  // final endDate = ref.watch(myNuuzEndDateProvider);
  return myNuuzRepository.getResultForDateRange(startDate: startDate, endDate: endDate);
}
