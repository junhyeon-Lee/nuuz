import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:nuuz/models/usercareprogram.dart';

class MyEvent {
  final String type;
  final String eventDate;

  const MyEvent({required this.type, required this.eventDate});

  static MyEvent fromUserCareProgram(UserCareProgram userCareProgram) {
    return MyEvent(type: 'program', eventDate: userCareProgram.startDate);
  }

  static MyEvent fromResult(Result result) {
    return MyEvent(type: 'result', eventDate: result.date ?? '');
  }
}
