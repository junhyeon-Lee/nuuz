import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/my_nuuz/reservation_notice_model.dart';
import 'package:nuuz/models/usercareprogram.dart';
import 'package:nuuz/modules/home/nuuz_my_screen.dart';
import 'package:nuuz/modules/nuzz_care/care_program/service/user_care_program_service.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_care_program_controller.g.dart';

class UserCareProgramNotifier extends AsyncNotifier<List<UserCareProgram>> {
  final userCareProgramRepository = UserCareProgramRepository();

  @override
  FutureOr<List<UserCareProgram>> build() {
    return _fetchUserCarePrograms();
  }

  Future<List<UserCareProgram>> _fetchUserCarePrograms() async {
    NotificationService notificationService = NotificationService();
    //모든 푸시 예약 삭제
    await notificationService.cancelAllNotifications();
    //새로운 푸시 예약을 위해 새로운 유저케어프로그램 가져오기 30일치
    List<UserCareProgram> rangeList = await userCareProgramRepository.getUserCareProgramForDateRange(DateTime.now().toString(), DateTime.now().add(const Duration(days: 30)).toString());

    for(int i=0; i<rangeList.length; i++){
      safePrint('${rangeList[i].startDate} ${rangeList[i].userCareProgramId} ${rangeList[i].reservationNotice?.reminderTime??""} ${rangeList[i].reservationNotice?.sendReminder}' );
    }

    ///예약은 케어프로그램이 새롭게 세팅될 때 같이 다시 세팅됩니다.
    for(int i = 0; i <  rangeList.length; i++){
      if(rangeList[i].reservationNotice?.sendReminder==1){
        notificationService.scheduleNotifications(reservation: DateTime.parse(rangeList[i].reservationNotice?.reminderTime?[0]??""), notificationId: i);
      }
    }

    safePrint('@@@@유저 케어 프로그램 가져오기 @@@@');
    return userCareProgramRepository.getUserCareProgram();
  }


  Future<String> createUserCarePrograms(userCareProgramData) async {
    try {
      return userCareProgramRepository.postUserCareProgramData(userCareProgramData);
    } catch (e) {
      rethrow;
    }
  }

  Future<AsyncValue> deleteUserCarePrograms(String userCareProgramId) async {
    // state = const AsyncValue.loading();
    return await AsyncValue.guard(() async {
      await userCareProgramRepository.deleteUserCareProgramData(userCareProgramId);
    });

  }

  Future<void> updateUserCarePrograms({required String userCareProgramId, required Map<String, dynamic> data}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await userCareProgramRepository.updateUserCareProgramData(userCareProgramId, data);
      return _fetchUserCarePrograms();
    });
  }
}

final userCareProgramProvider = AsyncNotifierProvider<UserCareProgramNotifier, List<UserCareProgram>>(() {
  return UserCareProgramNotifier();
});

@Riverpod(keepAlive: true)
Future<List<UserCareProgram>?> userCareProgramForDateRange(Ref ref, String startDate, String endDate) {
  final myNuuzRepository = UserCareProgramRepository();
  safePrint('유저 케어 프로그램 범위 검색');
  return myNuuzRepository.getUserCareProgramForDateRange(startDate, endDate);
}
