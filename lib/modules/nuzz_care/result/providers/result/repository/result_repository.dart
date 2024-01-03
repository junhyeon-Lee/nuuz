import 'package:dio/dio.dart';
import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class ResultRepository {
  static final ResultRepository _repository = ResultRepository._intrnal();

  factory ResultRepository() => _repository;

  ResultRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Result>> getResults() async {
    try {
      final response = await dio.get(
        '/result/get',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["resultData"] as List).map((e) => Result.fromJson(e)).toList()
          ..sort((a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<Result?> getResultById(String id, String token) async {
    try {
      final response = await dio.get(APIConstants.getReview, queryParameters: {"resultId": id, "token": token});
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["resultData"] as List).map((e) => Result.fromJson(e)).toList().first;
      }
      // return Future.delayed(Duration(seconds: 1), () {
      //   return
      //     Result.fromJson({
      //       "id": "1",
      //       "title": "title 1",
      //       "description": "description 1",
      //       "imageUrl": "https://picsum.photos/id/237/200/300",
      //       "date": "2023-02-17 07:27:19"
      //     })
      //   ;
      // });
    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }

  Future postResult(Map<String, String> data) async {
    try {
      final response = await dio.post(
        'result/create',
        data: data,
      );
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

  Future deleteResult(String resultId) async {
    try {
      final response = await dio.delete(
        '/result/delete/$resultId',
      );
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
