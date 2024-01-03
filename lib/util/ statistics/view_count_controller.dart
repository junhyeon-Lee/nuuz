import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/errormodel.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class ViewCountRepository {
  static final ViewCountRepository _repository = ViewCountRepository._intrnal();

  factory ViewCountRepository() => _repository;

  ViewCountRepository._intrnal();

  Dio dio = HttpService().to();
  LocalDB localDB = LocalDB();

  Future<void> increaseViewCount(String? postId, String? eventId, String? trendId, String? noticeId, String? bannerId) async {
    try {
      if(postId!=null){
        final response = await dio.post('/user/view-count', queryParameters: {
          "postId" : postId
        });
        if (response.statusCode == 200) {
          final result = ErrorModel.fromJson(response.data);
          safePrint('view count 상승');
          safePrint(result.message);
        }
      }else if(eventId!=null){
        final response = await dio.post('/user/view-count', queryParameters: {
          "eventId" : eventId
        });
        if (response.statusCode == 200) {
          final result = ErrorModel.fromJson(response.data);
          safePrint('view count 상승');
          safePrint(result.message);
        }
      }else if(trendId!=null){
        final response = await dio.post('/user/view-count', queryParameters: {
          "trendId" : trendId
        });
        if (response.statusCode == 200) {
          final result = ErrorModel.fromJson(response.data);
          safePrint('view count 상승');
          safePrint(result.message);
        }
      }else if(noticeId!=null){
        final response = await dio.post('/user/view-count', queryParameters: {
          "noticeId" : noticeId
        });
        if (response.statusCode == 200) {
          final result = ErrorModel.fromJson(response.data);
          safePrint('view count 상승');
          safePrint(result.message);
        }
      }else if(bannerId != null){
        final response = await dio.post('/user/view-count', queryParameters: {
          "bannerId" : bannerId
        });
        if (response.statusCode == 200) {
          final result = ErrorModel.fromJson(response.data);
          safePrint('view count 상승');
          safePrint(result.message);
        }
      }else{
        safePrint('뷰카운트 파라미터 이상있음');
      }



    } catch (e) {
      safePrint('뷰카운트 상승 실패');
      safePrint(e);
    }
  }
}
