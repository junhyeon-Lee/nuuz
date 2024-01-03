import 'dart:convert';

import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nuuz/models/my_nuuz/reservation_notice_model.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/socialinfo.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  static const _userInfoKey = '_userInfoKey';

  void updateSocialInfo(SocialInfo socialInfo) async {
    var pref = await _pref;
    pref.setString('social_info', jsonEncode(socialInfo));
  }

  Future<SocialInfo?> findSocialInfo() async {
    var pref = await _pref;
    var json = pref.getString('social_info');
    if (json == null) return null;
    return SocialInfo.fromJson(jsonDecode(json));
  }

  void updateAuthInfo(LoginResponse loginResponse) async {
    var pref = await _pref;
    pref.setString('auth_info', jsonEncode(loginResponse));
  }

  Future<LoginResponse?> findAuthInfo() async {
    var pref = await _pref;
    var json = pref.getString('auth_info');
    safePrint("findAuthInfo====${jsonDecode(json!)}");
    //if (json == null) return null;
    return LoginResponse.fromJson(jsonDecode(json!));
  }

  void updateUserInfo(UserData? getUserData) async {
    safePrint("updateUserInfo----->${jsonEncode(getUserData)}");
    var pref = await _pref;
    pref.setString('user_info', jsonEncode(getUserData));
  }

  Future<UserData?> findUserInfo() async {
    var pref = await _pref;
    var json = pref.getString('user_info');
    if (json == null) return null;
    return UserData.fromJson(jsonDecode(json));
  }

  Future<void> logout() async {
    var pref = await _pref;
    await pref.remove('social_info');
    await pref.remove('auth_info');
    await pref.remove('user_info');
    await pref.clear();
    safePrint('db청소');
    FlutterNaverLogin.logOut();
    safePrint('네이버 로그아웃');
    UserApi.instance.logout();
    safePrint('카카오 로그아웃');
    safePrint('로그아웃 성공');
  }

  updateRecent(var recentSearch) async {
    var pref = await _pref;
    if (recentSearch.runtimeType == List<String>) {
      pref.setStringList('recent_search', recentSearch);
    } else {
      var list = pref.getStringList('recent_search');
      if (list != null) {
        if (!list.contains(recentSearch)) {
          list.add(recentSearch);
          pref.setStringList('recent_search', list);
        }
      } else {
        pref.setStringList('recent_search', [recentSearch]);
      }
    }
  }

  Future<List> getRecentSearches() async {
    var pref = await _pref;
    var recentSearch = pref.getStringList('recent_search');
    if (recentSearch == null) {
      return [];
    } else {
      return recentSearch;
    }
  }

  void setReservationNoticeList(List<ReservationNoticeModel> list) async {
    List<String> jsonList = list.map((user) => user.toJson()).toList();
    var pref = await _pref;
    pref.setStringList('ReservationNoticeList', jsonList);
  }

  Future<List<ReservationNoticeModel>> getReservationNoticeList() async {
    var pref = await _pref;
    var json = pref.getStringList('ReservationNoticeList') ?? [];

    // return UserData.fromJson(jsonDecode(json));

    return json.map((json) => ReservationNoticeModel.fromJson(json)).toList();
/*    return (jsonDecode(json) as List<dynamic>)
        .map<ReservationNoticeModel>((item) => ReservationNoticeModel.fromJson(item))
        .toList();*/
  }

  void setReservationNoticeSwitch(bool value) async {
    var pref = await _pref;
    pref.setBool('ReservationNoticeSwitch', value);
  }

  Future<bool> getReservationNoticeSwitch() async {
    var pref = await _pref;
    return pref.getBool('ReservationNoticeSwitch') ?? true;
  }

  // ///업데이트 정보 저장
  // void updateUpdateInfo(UserData updateInfo) async {
  //   var pref = await _pref;
  //   pref.setString('update_info', jsonEncode(updateInfo));
  // }
  // ///업데이트 정보 불러오기
  // Future<UserData?> findUpdateInfo() async {
  //   var pref = await _pref;
  //   var json = pref.getString('update_info');
  //   if (json == null) return null;
  //   return UserData.fromJson(jsonDecode(json));
  // }

  // ///User information inquiry
  // Future<UserInfo?> findUserInfo() async {
  //   var pref = await _pref;
  //   var json = pref.getString(_userInfoKey);
  //   if (json == null) return null;
  //   return UserInfo.fromJson(jsonDecode(json));
  // }
  // void updateUserInfo(UserInfo userInfo) async {
  //   var pref = await _pref;
  //   pref.setString(_userInfoKey, jsonEncode(userInfo));
  // }
  // Future<String?> findMemberAccessToken() async {
  //   var userInfo = await findUserInfo();
  //   if (userInfo?.token != null) {
  //     return "Bearer ${userInfo!.token}";
  //   } else {
  //     return '';
  //   }
  // }

  // void changeUserEmail(UserInfo memberInfo, String? email) async {
  //   var memberInfo = await findUserInfo();
  //   if (email != null) {
  //     memberInfo = memberInfo!.copyWith(email: email);
  //   }
  //   updateUserInfo(memberInfo!);
  // }
  // void changeUserNickname(UserInfo memberInfo, String? nickname) async {
  //   var memberInfo = await findUserInfo();
  //   if (nickname != null) {
  //     memberInfo = memberInfo!.copyWith(nickname: nickname);
  //   }
  //   updateUserInfo(memberInfo!);
  // }
  // void changeUserGender(UserInfo memberInfo, String? gender) async {
  //   var memberInfo = await findUserInfo();
  //   if (gender != null) {
  //     memberInfo = memberInfo!.copyWith(gender: gender);
  //   }
  //   updateUserInfo(memberInfo!);
  // }
  // void changeUserProfileImage(UserInfo memberInfo, String? image) async {
  //   var memberInfo = await findUserInfo();
  //   if (image != null) {
  //     memberInfo = memberInfo!.copyWith(profileImage: image);
  //   }
  //   updateUserInfo(memberInfo!);
  // }
  // void changeUserBirth(UserInfo memberInfo, DateTime? birthday) async {
  //   var memberInfo = await findUserInfo();
  //   if (birthday != null) {
  //     memberInfo = memberInfo!.copyWith(birthday: birthday);
  //   }
  //   updateUserInfo(memberInfo!);
  // }
  //
  Future userLogout() async {
    var pref = await _pref;
    pref.clear();
  }

  void updateCheeringNoticeInfo(bool value) async {
    var pref = await _pref;
    pref.setBool('cheering_notice', value);
  }

  Future<bool> getCheeringNoticeInfo() async {
    var pref = await _pref;
    var value = pref.getBool('cheering_notice') ?? true;
    safePrint("findCheeringNoticeInfo====$value}");
    //if (json == null) return null;
    return value;
  }
}
