import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

part 'event.g.dart';

@freezed
class Event with _$Event {
  factory Event({
    required String event_id,
    required String user_id,
    required String image,
    required String title_text,
    required String body_text,
    required String status,
    required DateTime created_at,
    required DateTime? updated_at,
    required int is_deleted,
    required String invoked_link
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
