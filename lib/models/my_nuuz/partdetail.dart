import 'package:freezed_annotation/freezed_annotation.dart';

part 'partdetail.freezed.dart';
part 'partdetail.g.dart';

@freezed
class PartDetail with _$PartDetail {
  factory PartDetail({
    required String? partName,
    required String? cartridgeType,
    required int? shots,
  }) = _PartDetail;

  factory PartDetail.fromJson(Map<String, dynamic> json) =>
      _$PartDetailFromJson(json);
}
