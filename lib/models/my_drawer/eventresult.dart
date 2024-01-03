import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/my_drawer/event.dart';
import 'package:nuuz/models/my_drawer/eventlist.dart';

part 'eventresult.freezed.dart';

part 'eventresult.g.dart';

@freezed
class EventResult with _$EventResult {
  factory EventResult({
    required bool status,
    required EventList eventData,
  }) = _EventResult;

  factory EventResult.fromJson(Map<String, dynamic> json) => _$EventResultFromJson(json);
}
