import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/my_drawer/event.dart';
import 'package:nuuz/models/my_drawer/eventlist.dart';
import 'package:nuuz/models/my_drawer/userproductlist.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/drawer/my_drawer/favoriteprograms/model/favprogramlist.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/model/noticelist.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/model/selfdiagnosislist.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/log_print.dart';

import 'my_drawer_service.dart';
import 'faqs/model/faqlist.dart';

import 'notice/model/notice.dart';

final myDrawerProvider = StateNotifierProvider<MyDrawerProvider, UserData?>((ref) {
  return MyDrawerProvider();
});

class MyDrawerProvider extends StateNotifier<UserData?> {
  MyDrawerProvider() : super(null);

  LocalDB localDB = LocalDB();

  getUserData() async {
    state = await localDB.findUserInfo();
    safePrint('겟유저데이터');
    safePrint(state);
  }
}

final getAuthInfoData = StateNotifierProvider<AuthInfoDataProvider, LoginResponse?>((ref) {
  return AuthInfoDataProvider();
});

class AuthInfoDataProvider extends StateNotifier<LoginResponse?> {
  AuthInfoDataProvider() : super(null);

  LocalDB localDB = LocalDB();

  getAuthInfoData() async {
    state = await localDB.findAuthInfo();
    safePrint("getAuthInfoData----$state");
  }
}

final userProductProvider = StateNotifierProvider<UserProductProvider, UserProductList?>((ref) {
  return UserProductProvider();
});

class UserProductProvider extends StateNotifier<UserProductList?> {
  UserProductProvider() : super(null);
  final myDrawerRepository = MyDrawerRepository();

  Future<void> getUserProduct() async {
    try {
      state = await myDrawerRepository.getUserProduct();
      if (state != null) {
        safePrint(state);
      }
    } catch (e) {
      safePrint(e);
    }
  }
}

final userDataProvider = StateNotifierProvider<UserDataProvider, UserData?>((ref) {
  return UserDataProvider();
});

class UserDataProvider extends StateNotifier<UserData?> {
  UserDataProvider() : super(null);

  final myDrawerRepository = MyDrawerRepository();

  Future<UserData?> getUserProfileData() async {
    try {
      state = await myDrawerRepository.getUserProfileData();
      if (state != null) {
        safePrint(state);
        return state;
      }
    } catch (e) {
      safePrint(e);
    }
    return null;
  }
}

final eventProvider = StateNotifierProvider<EventProvider, EventList?>((ref) {
  return EventProvider();
});

class EventProvider extends StateNotifier<EventList?> {
  EventProvider() : super(null);
  final myDrawerRepository = MyDrawerRepository();

  EventList? singleEventList = EventList(count: 0, result: []);

  Future<void> getEvent() async {
    try {
      state = await myDrawerRepository.getEvent(null);
      if (state != null) {
        safePrint(state);
        safePrint('이벤트 호출 성공');
      }
    } catch (e) {
      safePrint(e);
    }
  }

  Future<Event?> getSingleEvent(String id) async {
    try {
      singleEventList = await myDrawerRepository.getEvent(id);
      if (singleEventList != null) {
        safePrint(state);
        safePrint('싱글 이벤트 호출 성공');
        return singleEventList!.result[0];
      }
    return null;
    } catch (e) {
      safePrint(e);
      return null;
    }
  }

}

final noticeProvider = StateNotifierProvider<NoticeProvider, NoticeList?>((ref) {
  return NoticeProvider();
});

class NoticeProvider extends StateNotifier<NoticeList?> {
  NoticeProvider() : super(null);
  final myDrawerRepository = MyDrawerRepository();

  Future<void> getNotice({required BuildContext context}) async {
    try {
      state = await myDrawerRepository.getNotice(context: context);

      if (state != null) {
        safePrint("getEvent====>$state");
        safePrint('이벤트 호출 성공');
      } else {
        safePrint("getNotice==null==>$state");
      }
    } catch (e) {
      safePrint(e);
    }
  }
}

final editProfileNotifier = StateNotifierProvider<EditProfileNotifier, Response?>((ref) {
  return EditProfileNotifier();
});

class EditProfileNotifier extends StateNotifier<Response?> {
  EditProfileNotifier() : super(null);
  final myDrawerRepository = MyDrawerRepository();
  bool isSuccess=false;

  Future<void> getEditProfile({required Map<String, dynamic> updateProfileData}) async {
    safePrint("call getEditProfile  ===>${updateProfileData}");
    isSuccess=false;

    try {
      state = await myDrawerRepository.editProfile(updateProfileData: updateProfileData);

      if (state != null) {
        if(state?.data['status']){
          isSuccess=true;
        }
        safePrint("call EditProfileNotifier====>$state");
      }
    } catch (e) {
      safePrint(e);
    }
  }
}

final faqNotifier = StateNotifierProvider<FaqNotifier, FaqList?>((ref) {
  return FaqNotifier();
});

class FaqNotifier extends StateNotifier<FaqList?> {
  FaqNotifier() : super(null);
  final myDrawerRepository = MyDrawerRepository();

  Future<FaqList?> getFaqData(token) async {
    safePrint("call getFaqData  ===>$token");
    try {
      state = await myDrawerRepository.getFaq(token);
      if (state != null) {
        safePrint("call getFaqData====>$state");
        return state;
      }
    } catch (e) {
      safePrint(e);
    }
    return null;
  }
}

final favProgramNotifier = StateNotifierProvider<FavProgramNotifier, FavProgramList?>((ref) {
  return FavProgramNotifier();
});

class FavProgramNotifier extends StateNotifier<FavProgramList?> {
  FavProgramNotifier() : super(null);
  final myDrawerRepository = MyDrawerRepository();

  Future<FavProgramList?> getFavProgram(token) async {
    safePrint("call getFavProgram  ===>$token");
    try {
      state = await myDrawerRepository.getFavProgram(token);
      if (state != null) {
        safePrint("call getFavProgram state====>$state");
        //return state;
      }
    } catch (e) {
      safePrint(e);
    }
    return null;
  }
}

final deleteFavProgramNotifier = StateNotifierProvider<DeleteFavProgramNotifier, Response?>((ref) {
  return DeleteFavProgramNotifier();
});

class DeleteFavProgramNotifier extends StateNotifier<Response?> {
  DeleteFavProgramNotifier() : super(null);
  final myDrawerRepository = MyDrawerRepository();
/*
  Future<Response?> deleteFavProgram(token, data) async {
    safePrint("call deleteFavProgram  ===>$token");
    try {
      state = (await myDrawerRepository.deleteFavProgram(token, data)) as Response?;
      if (state != null) {
        safePrint("call deleteFavProgram state====>$state");
        //return state;
      }
    } catch (e) {
      safePrint(e);
    }
    return null;
  }*/
}/*
final selfDiagnosisNotifier = StateNotifierProvider<SelfDiagnosisNotifier, SelfDiagnosisList?>((ref) {
  return SelfDiagnosisNotifier();
});

class SelfDiagnosisNotifier extends StateNotifier<SelfDiagnosisList?> {
  SelfDiagnosisNotifier() : super(null);
  final myDrawerRepository = MyDrawerRepository();
  Future<SelfDiagnosisList?> getSelfDiagnosis(token, ) async {
    safePrint("call getSelfDiagnosis  ===>$token");
    try {
      state = await myDrawerRepository.getSelfDiagnosis(token, );
      if (state != null) {
        safePrint("call getSelfDiagnosis state====>$state");
        //return state;
      }
    } catch (e) {
      safePrint(e);
    }
    return null;
  }
}*/
