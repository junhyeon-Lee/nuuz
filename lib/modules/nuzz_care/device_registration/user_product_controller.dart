import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/service/user_product_service.dart';

// final userProductController = AsyncNotifierProvider.autoDispose<UserProductProvider, List<Product>>(() {
//   return UserProductProvider();
// });
//
// class UserProductProvider extends AutoDisposeAsyncNotifier<List<Product>> {
//   final userProductRepository = UserProductRepository();
//
//   @override
//   FutureOr<List<Product>> build() {
//     return _fetchUserProducts();
//   }
//
//   Future<List<Product>> _fetchUserProducts() {
//     return userProductRepository.getUserProductData();
//   }
//
//   Future<List<Product>> reFetchUserProducts() {
//     return userProductRepository.getUserProductData();
//   }
//
//   Future<void> updateUserProduct(String productId, String productCode) async {
//     state = const AsyncValue.loading();
//     try {
//       await userProductRepository.postUserProductData(productId, productCode);
//       state = AsyncValue.data(await _fetchUserProducts());
//     } catch (err, stack) {
//       state = AsyncValue.error(err, stack);
//       rethrow;
//     }
//   }
// }

final userProductController = StateNotifierProvider.autoDispose<UserProductProvider, List<Product>>((ref) {
  return UserProductProvider();
});

class UserProductProvider extends StateNotifier<List<Product>> {
  UserProductProvider() : super([]);
  final userProductRepository = UserProductRepository();

  fetchUserProducts() async {
    state = await userProductRepository.getUserProductData();
  }

  Future<List<Product>> reFetchUserProducts() {
    return userProductRepository.getUserProductData();
  }

  Future<void> updateUserProduct(String productId, String? productCode) async {
    state = await userProductRepository.getUserProductData();
    try {
      await userProductRepository.postUserProductData(productId, productCode);
      state = await userProductRepository.getUserProductData();
    } catch (err, stack) {
      state = await userProductRepository.getUserProductData();
      rethrow;
    }
  }
}
