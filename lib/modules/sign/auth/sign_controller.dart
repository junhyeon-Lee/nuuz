import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nuuz/main.dart';
import 'package:nuuz/models/user_info/getuserdata.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/privacy_notification.dart';
import 'package:nuuz/models/user_info/socialinfo.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/sign/sign_service.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/toast_helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final signProvider = StateNotifierProvider<SignProvider, bool?>((ref) {
  return SignProvider();
});

class SignProvider extends StateNotifier<bool?> {
  SignProvider() : super(null);

  LocalDB localDB = LocalDB();
  late SocialInfo socialInfo;
  late UserData? updateInfo;
  final signRepository = SignRepository();

  signWithKakao() async {
    state = null;
    try {
      OAuthToken accessToken;
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token =
          isInstalled ? accessToken = await UserApi.instance.loginWithKakaoTalk() : accessToken = await UserApi.instance.loginWithKakaoAccount();

      try {
        User user = await UserApi.instance.me();
        socialInfo = SocialInfo(
          loginType: 'kakao',
          socialToken: token.idToken,
          email: user.kakaoAccount?.email.toString(),
          deviceType: Platform.isAndroid ? "android" : "ios",
          deviceToken: fcmToken,
        );
        LoginResponse? kakaoResponse = await signRepository.signInWithAccessToken(socialInfo: socialInfo);

        if (kakaoResponse != null) {
          localDB.updateAuthInfo(kakaoResponse);

          //combine api respone and social data
          GetUserData? userData = await signRepository.getUserData();
          UserData? updateInfoKaKao = UserData(
            user_id: userData?.userData?.user_id,
            name: userData?.userData?.name,
            birth_date: user.kakaoAccount!.birthyear.toString() + user.kakaoAccount!.birthday.toString(),
            gender: user.kakaoAccount?.gender.toString(),
            email: user.kakaoAccount?.email.toString(),
            profile_image: userData?.userData?.profile_image ?? user.kakaoAccount?.profile?.profileImageUrl.toString(),
            nick_name: user.kakaoAccount?.profile?.nickname.toString(),
            social_token: token.idToken.toString(),
            created_at: userData?.userData?.created_at,
            updated_at: userData?.userData?.updated_at,
            is_deleted: userData?.userData?.is_deleted,
            login_type: userData?.userData?.login_type,
            password: userData?.userData?.password,
            comment: userData?.userData?.comment,
            introduction: userData?.userData?.introduction ?? "pending",
            post: userData?.userData?.post,
            role: userData?.userData?.role,
            shipping: userData?.userData?.shipping,
            privacy_settings: userData?.userData?.privacy_settings ?? PrivacySettingsModel(posts: "public", comments: "public"),
            notification_settings: userData?.userData?.notification_settings ??
                NotificationSettingsModel(cheeringNotice: "enabled", events: "enabled", reservationNotice: "enabled"),
          );
          updateInfo = updateInfoKaKao;

          //kakaoResponse updateInfo 이 두개를 저장을 합시다.
          localDB.updateAuthInfo(kakaoResponse);
          localDB.updateUserInfo(updateInfo);

          if (updateInfoKaKao.name == null) {
            state = false;
          } else {
            state = true;
          }
        }
      } catch (error) {
        safePrint(error);
        safePrint('사용자 정보 요청 실패 $error');
      }
    } catch (e) {
      safePrint('카카오 에러');
      safePrint(e);
      AppToast.toastMessage(message: '$e');
    }
  }

  signWithNaver() async {
    state = null;
    try {
      await FlutterNaverLogin.logOut();

      NaverLoginResult result = await FlutterNaverLogin.logIn();

      final account = await FlutterNaverLogin.currentAccount();

      final naverToken = JWT(
        {'nickname': account.nickname.toString(), 'email': account.email.toString(), 'picture': account.profileImage.toString()},
        issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
      );
      String token = naverToken.sign(SecretKey('secret passphrase'));

      socialInfo = SocialInfo(
        loginType: 'naver',
        socialToken: token,
        email: account.email.toString(),
        deviceType: Platform.isAndroid ? "android" : "ios",
        deviceToken: fcmToken,
      );
      LoginResponse? naverResponse = await signRepository.signInWithAccessToken(socialInfo: socialInfo);

      if (naverResponse != null) {
        localDB.updateAuthInfo(naverResponse);
        GetUserData? userData = await signRepository.getUserData();
        UserData? updateInfoNaver = UserData(
          user_id: userData?.userData?.user_id,
          name: userData?.userData?.name,
          birth_date: account.birthyear + account.birthday.toString().replaceAll(RegExp('[^a-zA-Z0-9가-힣\\s]'), ""),
          gender: account.gender.toString(),
          email: account.email.toString(),
          profile_image: userData?.userData?.profile_image ?? account.profileImage.toString(),
          nick_name: account.nickname.toString(),
          social_token: token,
          created_at: userData?.userData?.created_at,
          updated_at: userData?.userData?.user_id,
          is_deleted: userData?.userData?.is_deleted,
          login_type: userData?.userData?.login_type,
          password: userData?.userData?.password,
          comment: userData?.userData?.comment,
          introduction: userData?.userData?.introduction ?? "pending",
          post: userData?.userData?.post,
          role: userData?.userData?.role,
          shipping: userData?.userData?.shipping,
          privacy_settings: userData?.userData?.privacy_settings ?? PrivacySettingsModel(posts: "public", comments: "public"),
          notification_settings: userData?.userData?.notification_settings ??
              NotificationSettingsModel(cheeringNotice: "enabled", events: "enabled", reservationNotice: "enabled"),
        );
        updateInfo = updateInfoNaver;

        //kakaoResponse updateInfo 이 두개를 저장을 합시다.
        localDB.updateAuthInfo(naverResponse);
        localDB.updateUserInfo(updateInfo);
        safePrint('이름이 없을텐데');
        safePrint(account.name);
        safePrint(userData?.userData?.name);
        safePrint(userData?.userData?.name);
        if (updateInfoNaver.name == null) {
          state = false;
        } else {
          state = true;
        }
      }
    } catch (error) {
      safePrint('네이버 로그인 실패 $error');
    }
  }

  signWithApple() async {
    safePrint('애플 로그인');
    state = null;
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      safePrint('계정정보 둘러보기');
      safePrint(credential.identityToken); // 토큰
      safePrint(credential.givenName); //이름
      safePrint(credential.email);
      safePrint(credential.familyName); //성

      List<String> jwt = credential.identityToken?.split('.') ?? [];
      String payload = jwt[1];
      payload = base64.normalize(payload);

      final List<int> jsonData = base64.decode(payload);
      final userInfo = jsonDecode(utf8.decode(jsonData));
      String email = userInfo['email'];

      safePrint(email);

      socialInfo = SocialInfo(
        loginType: 'apple',
        socialToken: credential.identityToken,
        email: email.toString(),
        deviceType: Platform.isAndroid ? "android" : "ios",
        deviceToken: fcmToken,
      );
      LoginResponse? appleResponse = await signRepository.signInWithAccessToken(socialInfo: socialInfo);

      if (appleResponse != null) {
        localDB.updateAuthInfo(appleResponse);
        GetUserData? userData = await signRepository.getUserData();
        UserData? updateInfoApple = UserData(
          user_id: userData?.userData?.user_id,
          name: userData?.userData?.name,
          birth_date: "",
          gender: "F",
          email: email.toString(),
          profile_image: null,
          nick_name: credential.familyName.toString() + credential.givenName.toString() ?? "",
          social_token: credential.identityToken,
          created_at: userData?.userData?.created_at,
          updated_at: userData?.userData?.user_id,
          is_deleted: userData?.userData?.is_deleted,
          login_type: userData?.userData?.login_type,
          password: userData?.userData?.password,
          comment: userData?.userData?.comment,
          introduction: userData?.userData?.introduction ?? "pending",
          post: userData?.userData?.post,
          role: userData?.userData?.role,
          shipping: userData?.userData?.shipping,
          privacy_settings: userData?.userData?.privacy_settings ?? PrivacySettingsModel(posts: "public", comments: "public"),
          notification_settings: userData?.userData?.notification_settings ??
              NotificationSettingsModel(cheeringNotice: "enabled", events: "enabled", reservationNotice: "enabled"),
        );
        updateInfo = updateInfoApple;

        //kakaoResponse updateInfo 이 두개를 저장을 합시다.
        localDB.updateAuthInfo(appleResponse);
        localDB.updateUserInfo(updateInfo);
        safePrint(userData?.userData?.name);
        if (updateInfoApple.name == null) {
          state = false;
        } else {
          state = true;
        }
      }
    } catch (e) {
      safePrint('애플로그인 에러 $e');
    }
  }

  signWithGoogle() async {
    state = null;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      safePrint('구글 로그인 정보');
      safePrint(googleAuth?.idToken); //소셜 토큰
      safePrint(googleUser?.email ?? "");
      safePrint(googleUser?.displayName ?? "");

      socialInfo = SocialInfo(
        loginType: 'google',
        socialToken: googleAuth?.idToken,
        email: googleUser?.email ?? "",
        deviceType: Platform.isAndroid ? "android" : "ios",
        deviceToken: fcmToken,
      );
      LoginResponse? googleResponse = await signRepository.signInWithAccessToken(socialInfo: socialInfo);

      if (googleResponse != null) {
        localDB.updateAuthInfo(googleResponse);
        GetUserData? userData = await signRepository.getUserData();
        UserData? updateInfoApple = UserData(
          user_id: userData?.userData?.user_id,
          name: userData?.userData?.name,
          birth_date: "",
          gender: "F",
          email: googleUser?.email ?? "",
          profile_image: null,
          nick_name: googleUser?.displayName ?? "",
          social_token: googleAuth?.idToken,
          created_at: userData?.userData?.created_at,
          updated_at: userData?.userData?.user_id,
          is_deleted: userData?.userData?.is_deleted,
          login_type: userData?.userData?.login_type,
          password: userData?.userData?.password,
          comment: userData?.userData?.comment,
          introduction: userData?.userData?.introduction ?? "pending",
          post: userData?.userData?.post,
          role: userData?.userData?.role,
          shipping: userData?.userData?.shipping,
          privacy_settings: userData?.userData?.privacy_settings ?? PrivacySettingsModel(posts: "public", comments: "public"),
          notification_settings: userData?.userData?.notification_settings ??
              NotificationSettingsModel(cheeringNotice: "enabled", events: "enabled", reservationNotice: "enabled"),
        );
        updateInfo = updateInfoApple;

        //kakaoResponse updateInfo 이 두개를 저장을 합시다.
        localDB.updateAuthInfo(googleResponse);
        localDB.updateUserInfo(updateInfo);
        safePrint(userData?.userData?.name);
        if (updateInfoApple.name == null) {
          state = false;
        } else {
          state = true;
        }
      }
    } catch (e) {
      safePrint('구글 로그인 에러');
      safePrint(e);
    }
  }

  initSign() async {
    try {
      SocialInfo? socialInfo = await localDB.findSocialInfo();
      if (socialInfo == null) {
      } else {
        LoginResponse? loginResponse = await signRepository.signInWithAccessToken(socialInfo: socialInfo);
        if (loginResponse != null) {
          GetUserData? getUserData = await signRepository.getUserData();
          safePrint(getUserData?.userData);
          localDB.updateUserInfo(getUserData?.userData);
          if (getUserData != null) {
            if (getUserData.userData?.name == null) {
              state = null;
            } else {
              safePrint('아 여기 있습니다 토큰');
              safePrint(loginResponse.accessToken);
              state = true;
            }
          }
        }
      }
    } catch (e) {
      safePrint('에러 났어요');
      safePrint(e);
    }
  }

  userAlready() => state = false;
}
