import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/modules/product/model/product_model.dart';
import 'package:nuuz/modules/product/service/product_service.dart';
import 'package:nuuz/util/log_print.dart';

final getProductProvider = StateNotifierProvider<GetProductProvider, ProductModel?>((ref) {
  return GetProductProvider();
});

class GetProductProvider extends StateNotifier<ProductModel?> {
  GetProductProvider() : super(null);
  final productService = ProductService();

  List<String> relatedProductId = [];

  void setRelatedProduct(List<String> list) {
    relatedProduct = ProductModel(status: true, product: []);

    relatedProductId = list;
    if (state != null) {
      for (int i = 0; i < state!.product!.length; i++) {
        for (int j = 0; j < relatedProductId.length; j++) {
          if (state!.product![i].productId == relatedProductId[j]) {
            relatedProduct.product?.add(state!.product![i]);
          }
        }
      }
    }
  }

  ProductModel relatedProduct = ProductModel(status: true, product: []);

  Future<void> getProgram() async {
    try {
      state = await productService.getProgram();
    } catch (e) {
      safePrint(e);
    }
  }
}

final getRelatedProductProvider = StateNotifierProvider<GetRelatedProductProvider, ProductModel?>((ref) {
  return GetRelatedProductProvider();
});

class GetRelatedProductProvider extends StateNotifier<ProductModel> {
  GetRelatedProductProvider() : super(ProductModel(status: true, product: []));

  // List<String> relatedProductId = [];
  // ProductModel

  void setRelatedProduct(List<String> list, ProductModel product) {
    ProductModel productModel = ProductModel(status: true, product: []);
    if (state.product != null) {
      state.product!.clear();
    }
    for (int i = 0; i < product!.product!.length; i++) {
      for (int j = 0; j < list.length; j++) {
        if (product!.product![i].productId == list[j]) {
          productModel.product?.add(product!.product![i]);
        }
      }
    }

    state = productModel;
  }
}
