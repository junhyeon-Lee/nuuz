
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:nuuz/modules/drawer/my_drawer/notice/model/notice.dart';
import 'package:nuuz/modules/drawer/my_drawer/notice/model/noticelist.dart';

part 'noticeresult.freezed.dart';

part 'noticeresult.g.dart';

@freezed
class NoticeResult with _$NoticeResult {
  factory NoticeResult({
    required bool status,
    required NoticeList noticeData,
  }) = _NoticeResult;

  factory NoticeResult.fromJson(Map<String, dynamic> json) => _$NoticeResultFromJson(json);
}
