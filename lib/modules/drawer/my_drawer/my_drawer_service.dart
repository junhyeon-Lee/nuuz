import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nuuz/models/errormodel.dart';
import 'package:nuuz/models/my_drawer/eventlist.dart';
import 'package:nuuz/models/my_drawer/eventresult.dart';
import 'package:nuuz/models/my_drawer/noticeresult.dart';
import 'package:nuuz/models/my_drawer/userproductlist.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/models/user_info/withdraw.dart';
import 'package:nuuz/modules/drawer/my_drawer/favoriteprograms/model/favprogramlist.dart';

import 'package:nuuz/modules/drawer/my_drawer/notice/model/notice.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/model/noticelist.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/model/selfdiagnosislist.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/toast_helper.dart';

import '../../../models/product.dart';
import '../../../models/user_info/loginresponse.dart';
import 'faqs/model/faqlist.dart';

class MyDrawerRepository {
  static final MyDrawerRepository _repository = MyDrawerRepository._intrnal();

  factory MyDrawerRepository() => _repository;

  MyDrawerRepository._intrnal();

  Dio dio = HttpService().to();
  LocalDB localDB = LocalDB();

  Future<UserProductList?> getUserProduct() async {
    try {
      final response = await dio.get(APIConstants.getUserProduct);
      if (response.statusCode == 200) {
        safePrint('유저 기기 api 호출');
        safePrint(response);
        final result = UserProductList.fromJson(response.data);
        return result;
      }
    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }

  Future<UserData?> getUserProfileData() async {
    try {
      final response = await dio.get(
        APIConstants.userGet,
      );
      if (response.statusCode == 200) {
        safePrint('사용자 프로필 데이터 API 호출');
        safePrint("사용자 프로필 데이터 API 호출 ----> $response");
        final result = UserData.fromJson(response.data["userData"]);
        return result;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<EventList?> getEvent(String? id) async {
    try {
      final response = await dio.get(APIConstants.getEvent,queryParameters: id==null?null:{
        'id': id,
      },);

      if (response.statusCode == 200) {
        safePrint('이벤트 api 호출');
        safePrint(response);
        final result = EventResult.fromJson(response.data);
        return result.eventData;
      }
    } catch (e) {
      safePrint('이벤트 api 실패');
      safePrint(e);
      return null;
    }
    return null;
  }




  Future<NoticeList?> getNotice({required BuildContext context}) async {
    try {
      final response = await dio.get(APIConstants.getNotice);
      if (response.statusCode == 200) {
        safePrint('call getNotice API 호출');
        safePrint(response);

        final result = NoticeResult.fromJson(response.data);

        // List<Notice> result = List<Notice>.from(response.data["noticeData"].map((model)=> Notice.fromJson(model)));
        return result.noticeData;
      }else{
        AppToast.showSnackBar(message: response.data?['message'] ?? '', context: context);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Response?> editProfile({required Map<String, dynamic> updateProfileData}) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      final response = await dio.put(APIConstants.getEditProfile, data: updateProfileData,options: Options(headers: {"token":loginResponse!.accessToken}));
      safePrint("call editProfile  ===>${response.data}");
      if (response.statusCode == 200) {
        safePrint('알림 API 호출');
        safePrint("call editProfile  200===>${response.data}");
        safePrint(response);

        return response;
      }
    } catch (e) {
      safePrint("call editProfile error ===>$e");
      return null;
    }
    return null;
  }

  Future<FaqList?> getFaq(String token) async {
    try {
      final response = await dio.get(APIConstants.getFaq, options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        safePrint('알림 API 호출');
        safePrint("call getFaq  200===>${response.data}");
        safePrint(response);
        final result = FaqList.fromJson(response.data);
        return result;
      }
    } catch (e) {
      safePrint("call getFaq error ===>$e");
      return null;
    }
    return null;
  }

  Future<FavProgramList?> getFavProgram(String token) async {
    try {
      final response = await dio.get(APIConstants.getFavProgram, options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        safePrint("call getFavProgram  200===>${response.data}");
        safePrint(response);
        final result = FavProgramList.fromJson(response.data);
        return result;
      }
    } catch (e) {
      safePrint("call getFavProgram error ===>$e");
      return null;
    }
    return null;
  }

  Future<Response?> deleteFavProgram(String token, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(APIConstants.getDeleteProgram, options: Options(headers: {"token": token}),data: data );
      safePrint("call deleteFavProgram  ===>${response}");
      if (response.statusCode == 200) {
        safePrint("call deleteFavProgram  200===>${response.data}");

        return response;
      }
    } catch (e) {
      safePrint("call deleteFavProgram error ===>$e");
      return null;
    }
    return null;
  }

  Future<bool?> getWithdraw(String token, String reason, String inconvenience) async {
    try {
      final response = await dio.delete(APIConstants.getWithdraw,
          data: {"reason":"$inconvenience:$reason"},

          options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        safePrint("call getWithdraw  200===>${response.data}");
        safePrint(response);

        return true;
      }
    } catch (e) {
      safePrint("call getWithdraw error ===>$e");
      return false;
    }
    return false;
  }
  Future<SelfDiagnosisList?> getSelfDiagnosis(String token) async {
    try {
      final response = await dio.get(APIConstants.getSelfDiagnosis, options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        safePrint("call getSelfDiagnosis  200===>${response.data}");
        safePrint(response);
        final result = SelfDiagnosisList.fromJson(response.data);
        return result;
      }
    } catch (e) {
      safePrint("call getSelfDiagnosis error ===>$e");
      return null;
    }
    return null;
  }
 Future<bool> deleteUserProduct({required String token,required String productId}) async {
    try {
      safePrint("call deleteUserProduct  ===>$token  product id----$productId ");
      final response = await dio.delete('${APIConstants.getUserProductDelete}/$productId', options: Options(headers: {"token": token}),data: {});

      if (response.statusCode == 200) {
        safePrint("call deleteUserProduct  200===>${response.data}");
        safePrint(response);

        return true;
      }
    } catch (e) {
      safePrint("call deleteUserProduct error ===>$e");
      return false;
    }
    return false;
  }

 }
