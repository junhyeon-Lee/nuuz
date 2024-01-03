import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class UserCareProgramRepository {
  static final UserCareProgramRepository _repository = UserCareProgramRepository._intrnal();

  factory UserCareProgramRepository() => _repository;

  UserCareProgramRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<UserCareProgram>> getUserCareProgram() async {
    try {
      final response = await dio.get(
        '/user-care-program/get',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        var tempList = (body["userCareProgram"] as List).map((e) => UserCareProgram.fromJson(e)).toList();
        return tempList..sort((a, b) => DateTime.parse(a.startDate).compareTo(DateTime.parse(b.startDate)));
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<String> postUserCareProgramData(userCareProgramData) async {
    try {
      final response = await dio.post('/user-care-program/create', data: jsonEncode(userCareProgramData));
      if (response.statusCode == 200) {
        safePrint(response);
        return response.data['data']['user_care_program_id'];
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
    return '';
  }

  Future<List<UserCareProgram>> getUserCareProgramForDateRange(String startDate, String endDate) async {
    try {
      final response = await dio.get('/user-care-program/get', queryParameters: {
        'start_date': startDate,
        'end_date': endDate,
      });
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        return (body["userCareProgram"] as List).map((e) => UserCareProgram.fromJson(e)).toList();
      }
    } catch (e) {
      safePrint(e);
      return [];
    }
    return [];
  }

  Future<bool> deleteUserCareProgramData(String userCareProgramId) async {
    try {
      final response = await dio.delete('/user-care-program/delete/$userCareProgramId');
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

  Future<bool> updateUserCareProgramData(String userCareProgramId, Map<String, dynamic> data) async {
    try {
      final response = await dio.put(
        '/user-care-program/update/$userCareProgramId',
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
}
