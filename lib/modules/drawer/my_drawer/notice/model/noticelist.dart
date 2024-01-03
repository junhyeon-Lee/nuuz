
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:nuuz/modules/drawer/my_drawer/notice/model/notice.dart';

part 'noticelist.freezed.dart';

part 'noticelist.g.dart';

@freezed
class NoticeList with _$NoticeList {
  factory NoticeList({
    required int count,
    required List<Notice> result,
  }) = _NoticeList;

  factory NoticeList.fromJson(Map<String, dynamic> json) => _$NoticeListFromJson(json);
}
