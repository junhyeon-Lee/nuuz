import 'package:dio/dio.dart';
import 'package:nuuz/models/nuuz_talk/article.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class ArticleRepository {
  static final ArticleRepository _repository =
      ArticleRepository._intrnal();

  factory ArticleRepository() => _repository;

  ArticleRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Article>> getArticles() async {
    try {
      // final response = await dio.get(
      //   '/article/get',
      // );
      // if (response.statusCode == 200) {
      //   safePrint(response);
      //   var body = response.data;
      //   return (body["articles"] as List)
      //       .map((e) => Article.fromJson(e))
      //       .toList();
      // }
        return ([
    {
        "imageUrl": "https://picsum.photos/id/1/300",
        "description": "some description 1"
    },
    {
        "imageUrl": "https://picsum.photos/id/2/300",
        "description": "some description2"
    },
    {
        "imageUrl": "https://picsum.photos/id/3/300",
        "description": "some description 3"
    }
])
            .map((e) => Article.fromJson(e))
            .toList();
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }
}
