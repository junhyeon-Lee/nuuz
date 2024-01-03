
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trendlist.freezed.dart';
part 'trendlist.g.dart';

@freezed
class TrendList with _$TrendList {
  factory TrendList({
    required String? trend_id,
    required String? title,
    String? link_type,
    String? link_value,
    String? additional_information,
    String? status,
    required String? banner_image,
    required String? end_date,
    required int? is_deleted,
  }) = _TrendList;

  factory TrendList.fromJson(Map<String, dynamic> json) =>
      _$TrendListFromJson(json);
}
