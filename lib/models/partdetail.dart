
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_info/linegroupdetail.dart';

part 'partdetail.freezed.dart';
part 'partdetail.g.dart';

@freezed
class PartDetail with _$PartDetail {
  factory PartDetail({
    required String partName,
    required String title,
    @JsonKey(name: "image") required String? imageUrl,
    required String cartridgeType,
    required String description,
    required List<LineGroupDetail> line_group_details,
    required int shots
  }) = _PartDetail;
	
  factory PartDetail.fromJson(Map<String, dynamic> json) =>
			_$PartDetailFromJson(json);
}
