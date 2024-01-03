import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nuuz/main.dart';
import 'package:nuuz/models/user_info/getuserdata.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/privacy_notification.dart';
import 'package:nuuz/models/user_info/socialinfo.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class SignRepository {
  static final SignRepository _repository = SignRepository._intrnal();

  factory SignRepository() => _repository;

  SignRepository._intrnal();

  Dio dio = HttpService().to();
  LocalDB localDB = LocalDB();

  Future<LoginResponse?> signInWithAccessToken({required SocialInfo socialInfo}) async {
    try {
      HttpService().deleteAccessToken();
      safePrint('문제가 있는 로그인');
      final response = await dio.post('/user/login',
          data: {
            "loginType": socialInfo.loginType,
            "socialToken": socialInfo.socialToken,
            "email": socialInfo.email,
            "deviceType": Platform.isAndroid ? "android" : "ios",
            "deviceToken": fcmToken
          },
          options: Options(headers: null));

      if (response.statusCode == 200) {
        final result = LoginResponse.fromJson(response.data);
        localDB.updateSocialInfo(socialInfo);
        HttpService().setAccessToken(result.accessToken);
        safePrint('로그인 직후 데이터');
        safePrint(result);
        return result;
      }
    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }

  Future<GetUserData?> getUserData() async {
    try {
      final response = await dio.get(
        '/user/get',
      );
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint('사용자 프로필 데이터 API 호출');
        safePrint("사용자 프로필 데이터 API 호출 ----> $response");
        safePrint(GetUserData.fromJson(response.data).userData?.privacy_settings);
        return GetUserData.fromJson(response.data);
      }
    } catch (e) {
      safePrint(e);
      return null;
    }
    return null;
  }

  Future<bool> updateUserInfo(UserData userData) async {
    try {
      final response = await dio.put('/user/update', data: {
        "name": 'true',
        "birthday": userData.birth_date,
        "gender": userData.gender,
        "email": userData.email,
        "profileImage": userData.profile_image ?? "https://nuuz-image-storage.s3.amazonaws.com/profile/def/NoProfile.png",
        "isDeleted": 0,
        "nickName": userData.nick_name,
        "introduction": userData?.introduction ?? "pending",
        "privacy_settings": userData.privacy_settings ?? PrivacySettingsModel(posts: "public", comments: "public").toJson(),
        "notification_settings": userData.notification_settings ??
            NotificationSettingsModel(cheeringNotice: "enabled", events: "enabled", reservationNotice: "enabled").toJson()
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        safePrint(response.statusMessage);
      }
    } catch (e) {
      safePrint(e);
      return false;
    }
    return false;
  }

  Future<void> refreshToken({required String token}) async {
    try {
      final response = await dio.post(
        '/user/refresh_token',
        data: {"refreshToken": token},
      );
      if (response.statusCode == 200) {
        final result = LoginResponse.fromJson(response.data);
        safePrint('로그인 직후 데이터');
        safePrint(result);
        HttpService().setAccessToken(result.accessToken);
        localDB.updateAuthInfo(result);
      }
    } catch (e) {
      safePrint(e);
    }
  }
}
