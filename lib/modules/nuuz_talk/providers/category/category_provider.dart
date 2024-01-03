import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/category.dart';
import 'package:nuuz/modules/nuuz_talk/providers/category/repository/category_repository.dart';

final categoryProvider =
    AsyncNotifierProvider<CategoryNotifier, List<Category>>(() {
  return CategoryNotifier();
});

class CategoryNotifier extends AsyncNotifier<List<Category>> {
  final categoryRepository = CategoryRepository();

  @override
  FutureOr<List<Category>> build() {
    return _fetchUserCarePrograms();
  }

  Future<List<Category>> _fetchUserCarePrograms() {
    return categoryRepository.getCategories();
  }

  // Future<void> updateUserCarePrograms(Category category) async {
  //   state = const AsyncValue.loading();
  //   state = await AsyncValue.guard(() async {
  //     await categoryRepository.postCategory(category);
  //     return _fetchUserCarePrograms();
  //   });
  // }
}
