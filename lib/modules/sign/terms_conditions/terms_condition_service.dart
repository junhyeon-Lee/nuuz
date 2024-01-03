import 'package:dio/dio.dart';
import 'package:nuuz/models/user_info/formlist.dart';
import 'package:nuuz/models/user_info/termslist.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class TermsRepository {
  static final TermsRepository _repository = TermsRepository._intrnal();

  factory TermsRepository() => _repository;

  TermsRepository._intrnal();

  Dio dio = HttpService().to();
  LocalDB localDB = LocalDB();

  Future<TermsList?> getForm() async {
    try {
      final response = await dio.get(
        'form/get',
      );
      if (response.statusCode == 200) {
        safePrint('코드 200');
        final result = FormList.fromJson(response.data);
        return result.resultData;
      }
    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }
}
