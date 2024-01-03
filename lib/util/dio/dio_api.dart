import 'package:dio/dio.dart';
import 'package:nuuz/util/dio/api_constants.dart';

import 'dio_interceptor.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  static Dio _dio = Dio();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
    BaseOptions options = BaseOptions(baseUrl: APIConstants.baseUrl, headers: {
      'token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJlNzhjMjM0My0yZjE4LTRlNjAtOWRhNi0wMjFlYjMwODM1ZDIiLCJlbWFpbCI6Im51dXoxMjNAZ21haWwuY29tIiwibG9naW5fdHlwZSI6Imtha2FvIiwicm9sZSI6InVzZXIiLCJpYXQiOjE2NzcxNTI1MTYsImV4cCI6MTY3Nzc1NzMxNn0.zR9ZLMVtADKObdj8sVaVbnDW9z5klrrmL6K40rAf6Kk'
    });

    _dio = Dio(options);
    _dio.interceptors.add(DioCustomInterceptor());
  }

  Future<void> init({
    String baseUrl = APIConstants.baseUrl,
    int connectTimeout = 8000,
    int receiveTimeout = 8000,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) async {
    _dio.options = _dio.options.copyWith(baseUrl: baseUrl, connectTimeout: connectTimeout, receiveTimeout: receiveTimeout, headers: headers);

    if (interceptors != null && interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  void setAccessToken(String accessToken) {
    init(headers: {
      'token': accessToken,
    });
  }

  void deleteAccessToken() {
    init(headers: {});
  }

  Dio to() {
    return _dio;
  }
}
