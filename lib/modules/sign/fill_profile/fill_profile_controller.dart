import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/sign/sign_service.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/log_print.dart';

final emailProvider = StateNotifierProvider<EmailProvider, bool?>((ref) {
  return EmailProvider();
});

class EmailProvider extends StateNotifier<bool?> {
  EmailProvider() : super(null);

  alreadyUsing() => state = false;

  availableUsing() => state = true;
  TextEditingController emailController = TextEditingController();
}

final nickNameProvider = StateNotifierProvider<NickNameProvider, int>((ref) {
  return NickNameProvider();
});

class NickNameProvider extends StateNotifier<int> {
  NickNameProvider() : super(0);
  TextEditingController nickNameController = TextEditingController();

  nicknameSetLength(int length) => state = length;

  nicknameLength() => state = nickNameController.text.length;
}

final birthDayProvider = StateNotifierProvider<BirthDayProvider, int>((ref) {
  return BirthDayProvider();
});

class BirthDayProvider extends StateNotifier<int> {
  BirthDayProvider() : super(0);
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();

  setBirthDay(String birthday) {
    int year = int.parse(birthday.substring(0, 4));
    int month = int.parse(birthday.substring(4, 6));
    int day = int.parse(birthday.substring(6, 8));

    DateTime birthDatetime = DateTime(year, month, day);

    yearController.text = birthDatetime.toString().substring(0, 4);
    monthController.text = birthDatetime.toString().substring(5, 7);
    dayController.text = birthDatetime.toString().substring(8, 10);
  }

  countBirthLength() {
    state = yearController.text.length + monthController.text.length + dayController.text.length;
  }

  String birthDay() {
    DateTime result = DateTime(int.parse(yearController.text), int.parse(monthController.text), int.parse(dayController.text));
    return result.toString().substring(0, 10);
  }
}

final genderProvider = StateNotifierProvider<GenderProvider, int>((ref) {
  return GenderProvider();
});

class GenderProvider extends StateNotifier<int> {
  GenderProvider() : super(0);

  tapFemale() => state = 0;

  tapMale() => state = 1;

  tapNull() => state = 2;
}

final getStartProvider = StateNotifierProvider<GetStartProvider, bool>((ref) {
  return GetStartProvider();
});

class GetStartProvider extends StateNotifier<bool> {
  GetStartProvider() : super(false);

  LocalDB localDB = LocalDB();
  final signRepository = SignRepository();

  getStarted(String email, String nickname, String birthday, bool gender, UserData? updateInfo) async {
    try {
      String userGender;
      if (gender) {
        userGender = 'FEMALE';
      } else {
        userGender = 'MALE';
      }

      UserData? userData = updateInfo?.copyWith(
        email: email,
        gender: userGender,
        nick_name: nickname,
        birth_date: birthday,
        name: 'true',
      );
      safePrint('여');
      safePrint(userData);
      bool? userUpdateState = await signRepository.updateUserInfo(userData!);

      if (userUpdateState) {
        state = true;
      }

      state = true;
    } catch (error) {
      safePrint('error: $error');
    }
  }
}
