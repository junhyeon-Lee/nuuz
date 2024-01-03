import 'package:dio/dio.dart';
import 'package:nuuz/models/errormodel.dart';
import 'package:nuuz/models/product.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class ProductRepository {
  static final ProductRepository _repository = ProductRepository._intrnal();

  factory ProductRepository() => _repository;

  ProductRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Product>> getProductData() async {
    try {
      final response = await dio.get(
        '/product/get',
      );

      print('===-------->${response.data.toString()}');
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        print('===-------->${(body["product"] as List).map((e) => Product.fromJson(e)).toList().length}');
        return (body["product"] as List).map((e) => Product.fromJson(e)).toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<Product?> getProductById(String id) async {
    try {
      final response = await dio.get(APIConstants.getProduct, queryParameters: {
        "productId": id,
      });
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["product"] as List).map((e) => Product.fromJson(e)).toList().first;
      }
    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }
}
