import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

final userProductRepositoryProvider = Provider<UserProductRepository>((ref) {
  return UserProductRepository();
});

class UserProductRepository {
  static final UserProductRepository _repository = UserProductRepository._intrnal();

  factory UserProductRepository() => _repository;

  UserProductRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Product>> getUserProductData() async {
    try {
      final response = await dio.get(
        '/user-product/get',
      );
      safePrint("getUserProductData----->$response");
      if (response.statusCode == 200) {
        safePrint("getUserProductData----->$response");
        var body = response.data;
        return (body["userProduct"] as List).map((e) => Product.fromJson(e["product"])).toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<bool> postUserProductData(String productId, String? productCode) async {
    try {
      Response response;
      if (productCode == null) {
        response = await dio.post('/user-product/create', data: {'productId': productId});
      } else {
        response = await dio.post('/user-product/create', data: {'productId': productId, 'productCode': productCode});
      }

      if (response.statusCode == 200) {
        safePrint(response);
        return true;
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
    return false;
  }
}
