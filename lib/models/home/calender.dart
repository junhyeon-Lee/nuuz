
import 'package:freezed_annotation/freezed_annotation.dart';

import 'days.dart';

part 'calender.freezed.dart';
part 'calender.g.dart';

@freezed
class Calender with _$Calender {
  factory Calender({
    required int nickname,
    required int profileImage,
    required Days days
  }) = _Calender;

  factory Calender.fromJson(Map<String, dynamic> json) =>
      _$CalenderFromJson(json);
}
