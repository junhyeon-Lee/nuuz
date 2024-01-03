
import 'package:freezed_annotation/freezed_annotation.dart';

part 'days.freezed.dart';
part 'days.g.dart';

@freezed
class Days with _$Days {
  factory Days({
    required int year,
    required int month,
    required int day,
    required bool inMonth,
    required bool picked,
    required bool result
  }) = _Days;

  factory Days.fromJson(Map<String, dynamic> json) =>
      _$DaysFromJson(json);
}
