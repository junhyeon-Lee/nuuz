
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/my_drawer/event.dart';

part 'eventlist.freezed.dart';

part 'eventlist.g.dart';

@freezed
class EventList with _$EventList {
  factory EventList({
    required int count,
    required List<Event> result,
  }) = _EventList;

  factory EventList.fromJson(Map<String, dynamic> json) => _$EventListFromJson(json);
}
