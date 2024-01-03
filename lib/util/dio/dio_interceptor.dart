import 'package:dio/dio.dart';
import 'package:nuuz/modules/sign/sign_service.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

int productRegister = 0;

class DioCustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    safePrint('### REQUEST [method: ${options.method}] PATH: ${options.path}');
    safePrint('@@@header@@@:${options.headers}');
    safePrint('@@@bbodyy@@@:${options.data}');
    safePrint('@@@queryy@@@:${options.queryParameters}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    safePrint('get error');
    safePrint('${err.response?.statusCode} ${err.response?.data['message']}' ?? '');
    // AppToast.toastMessage(
    //     message: '${err.response?.statusCode} ${err.response?.data['message']}'?? '');
    if (err.response?.statusCode == 500 && err.response!.data['message'] == 'jwt expired') {
      var loginResponse = await LocalDB().findAuthInfo();
      await SignRepository().refreshToken(token: loginResponse!.refreshToken);
      var loginResp = await LocalDB().findAuthInfo();
      var reqOptions = err.requestOptions.copyWith(headers: {'token': loginResp!.accessToken});
      handler.resolve(await _retry(reqOptions));
    }
    if (err.response?.statusCode == 502) {
      safePrint('에러코드 502');
      var loginResponse = await LocalDB().findAuthInfo();
      await SignRepository().refreshToken(token: loginResponse!.refreshToken);
      var loginResp = await LocalDB().findAuthInfo();
      var reqOptions = err.requestOptions.copyWith(headers: {'token': loginResp!.accessToken});
      handler.resolve(await _retry(reqOptions));
    } else {
      handler.next(err);
    }

    if (err.response!.data['message'] == "Product code already used") {
      productRegister = 1;
    } else if (err.response!.data['message'] == "Product code not found") {
      productRegister = 2;
    }

    safePrint(err.requestOptions.method + err.requestOptions.path);
    safePrint('api에러==>${err.response?.statusCode}');
    safePrint(err.response?.statusMessage);
    safePrint(err.response?.data['message'] ?? '');
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    safePrint('api retry');
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return await HttpService()
        .to()
        .request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }
}
