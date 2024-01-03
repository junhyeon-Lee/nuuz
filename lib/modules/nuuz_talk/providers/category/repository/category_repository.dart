import 'package:dio/dio.dart';
import 'package:nuuz/models/nuuz_talk/category.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class CategoryRepository {
  static final CategoryRepository _repository =
      CategoryRepository._intrnal();

  factory CategoryRepository() => _repository;

  CategoryRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get(
        '/category/get',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["categoryData"] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }
}
