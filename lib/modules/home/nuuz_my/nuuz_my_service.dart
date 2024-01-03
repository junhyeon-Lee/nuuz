
import 'package:dio/dio.dart';
import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/models/my_nuuz/resultlist.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class MyNuuzRepository {
  static final MyNuuzRepository _repository = MyNuuzRepository._intrnal();

  factory MyNuuzRepository() => _repository;

  MyNuuzRepository._intrnal();

  Dio dio = HttpService().to();
  LocalDB localDB = LocalDB();

  Future<ResultList?> getResultForDateRange({required String startDate, required String endDate}) async {
    try {
      final response = await dio.get(
        'result/get',
        queryParameters: {
          'start_date': startDate,
          'end_date': endDate,
        },
      );
      if (response.statusCode == 200) {
        safePrint('아 여기 있습니다.');
        // final result = ResultList.fromJson(response.data);
        final result = (response.data['resultData'] as List).map((e) => Result.fromJson(e)).toList();
        return ResultList(status: true, resultData: result);
      }
      // return ResultList(status: true, resultData: [Result(result_id: '1', user_id: '123', product_id: "03da0589-92fe-4bb5-8a8a-5b014a107e5c", result_image: "https://nuuz-image-storage.s3.amazonaws.com/product/Product_Branding_Shot.jpg", date: DateTime.now().toUtc().toIso8601String(), created_at: "2023-02-10 04:49:03", updated_at: "2023-02-10 04:49:03", is_deleted: 0, program: ResultProgram(description: 'description', progaram_id: 1, care_program_name: 'care_program_name'))]);

    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }
}
