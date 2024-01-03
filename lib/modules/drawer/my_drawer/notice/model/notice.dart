

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice.freezed.dart';

part 'notice.g.dart';

@freezed
class Notice with _$Notice {
  factory Notice({
    required String? notice_id,
    required String? user_id,
    required String? category,
    required String? title_text,
    required String? body_text,
    required String? created_at,
    required String? updated_at,
    required int? is_deleted,
  }) = _Notice;

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
}
