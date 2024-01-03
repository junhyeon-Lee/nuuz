import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/modules/nuzz_care/device_registration/service/product_service.dart';

class ProductProvider extends AsyncNotifier<List<Product>> {
  // final productsList = [
  //   {
  //     "name": "NUUZ ME1",
  //     "description":
  //         "You can preview the product description.Up to ? characters are shown in the pre...",
  //     "image_url": "https://text.com",
  //   },
  //   {
  //     "name": "NUUZ ME2",
  //     "description":
  //         "You can preview the product description.Up to ? characters are shown in the pre...",
  //     "image_url": "https://text.com",
  //   },
  //   {
  //     "name": "NUUZ ME3",
  //     "description":
  //         " You can preview the product description.Up to ? characters are shown in the pre...",
  //     "image_url": "https://text.com",
  //   },
  // ];
  final productRepository = ProductRepository();

  @override
  FutureOr<List<Product>> build() {
    return _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() {
    return productRepository.getProductData();
    // return Future.delayed(const Duration(milliseconds: 500),
    //     () => productsList.map((e) => Product.fromJson(e)).toList());
  }

  Future<Product?> fetchProductById(String id) {
    return productRepository.getProductById(id);
    // return Future.delayed(const Duration(milliseconds: 500),
    //     () => productsList.map((e) => Product.fromJson(e)).toList());
  }
}

final productController = AsyncNotifierProvider<ProductProvider, List<Product>>(() => ProductProvider());
