import 'package:dio/dio.dart';
import 'package:nuuz/modules/product/model/product_model.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class ProductService {
  static final ProductService _repository = ProductService._intrnal();

  factory ProductService() => _repository;

  ProductService._intrnal();

  Dio dio = HttpService().to();

  Future<ProductModel?> getProgram() async {
    try {
      final response = await dio.get(APIConstants.getProduct);
      if (response.statusCode == 200) {
        final result = ProductModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }
}
