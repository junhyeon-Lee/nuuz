import 'package:dio/dio.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class CareProgramRepository {
  static final CareProgramRepository _repository = CareProgramRepository._intrnal();

  factory CareProgramRepository() => _repository;

  CareProgramRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Program>> getCareProgramData() async {
    try {
      final response = await dio.get(
        '/care-program/get',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["careProgram"] as List).map((e) => Program.fromJson(e)).toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<Program?> getCareProgramById(String id) async {
    try {
      final response = await dio.get('/care-program/get?careProgramId=$id');

      safePrint("getCareProgramById=====>$response-------------------------------->$id");
      safePrint("getCareProgramById=====>----------------------------->$id");
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["careProgram"] as List).map((e) => Program.fromJson(e)).toList().first;
      }
    } catch (e) {
      safePrint("getCareProgramById===error==>$e");
      return null;
    }
    return null;
  }

  Future<List<Program>> getFeaturedCareProgramData() async {
    try {
      final response = await dio.get(
        '/care-program/get',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["careProgram"] as List).where((element) => element['is_featured'] == 1).map((e) => Program.fromJson(e)).toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<List<Program>> getPopularCareProgramData() async {
    try {
      final response = await dio.get(
        '/user-care-program/popular',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["popularCareProgramData"] as List).map((e) => Program.fromJson(e)).toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<List<Program>> getFavoriteCareProgramData() async {
    try {
      final response = await dio.get(
        '/favourite/get',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint("favourtate ><><><><>  $response,");
        var body = response.data;
        safePrint("getFavoriteCareProgramData===$body");
        return (body["favouriteData"] as List).map((e) => Program.fromJson(e)).toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future toggleFavoriteCareProgram(String careProgramId, CancelToken cancelToken) async {
    try {
      // cancelToken.cancel();
      final response = await dio.post(
        '/favourite',
        cancelToken: cancelToken,
        data: {
          "careProgram": careProgramId
        },
      );
      if (response.statusCode == 200) {
        safePrint(response);
        return true;
      }
    } catch (e) {
      safePrint(e);
      if (CancelToken.isCancel(e as DioError)) {
        print('cancelled');
      } else {
        rethrow;
      }
    }
    return false;
  }
}
