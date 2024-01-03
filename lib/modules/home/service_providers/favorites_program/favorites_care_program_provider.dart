import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/modules/nuzz_care/care_program/service/care_program_service.dart';

class FavoriteCareProgramNotifier extends AsyncNotifier<List<Program>> {
  final careProgramRepository = CareProgramRepository();
  @override
  FutureOr<List<Program>> build() {
    return _fetchFavoriteCarePrograms();
  }

  _fetchFavoriteCarePrograms() {
    return careProgramRepository.getFavoriteCareProgramData();
  }

  updateFavoriteCarePrograms() {
    return careProgramRepository.getFavoriteCareProgramData();
  }

  Future toggleFavorite(Program careProgram, CancelToken cancelToken) async {
    // state = const AsyncLoading();
    careProgramRepository.toggleFavoriteCareProgram(careProgram.id.toString(), cancelToken);
    var favs = state.value;
    var ids = favs!.map((e) => e.id).toList();
    if (ids.contains(careProgram.id)) {
      favs.removeWhere((element) => element.id == careProgram.id);
    } else {
      favs.add(careProgram);
    }
    state = AsyncData(favs);
  }
}

final favoriteCareProgramProvider = AsyncNotifierProvider<FavoriteCareProgramNotifier, List<Program>>(() => FavoriteCareProgramNotifier());
