import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/modules/nuzz_care/care_program/service/care_program_service.dart';

class FeaturedProgramNotifier extends AsyncNotifier<List<Program>> {
  final careProgramRepository = CareProgramRepository();
  @override
  FutureOr<List<Program>> build() {
    return _fetchFeaturedPrograms();
  }

  _fetchFeaturedPrograms() {
    return careProgramRepository.getFeaturedCareProgramData();
  }
}

final featuredCareProgramProvider = AsyncNotifierProvider<FeaturedProgramNotifier, List<Program>>(
    () => FeaturedProgramNotifier());
