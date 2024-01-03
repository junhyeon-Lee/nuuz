import 'package:freezed_annotation/freezed_annotation.dart';

part 'linegroupdetail.freezed.dart';
part 'linegroupdetail.g.dart';

@freezed
class LineGroupDetail with _$LineGroupDetail {
  factory LineGroupDetail({
    required int? value,
    required int? cartridge,
    required String? line_name,
    required String? short_name,
    required int? line_group_id
  }) = _LineGroupDetail;

  factory LineGroupDetail.fromJson(Map<String, dynamic> json) =>
      _$LineGroupDetailFromJson(json);
}
