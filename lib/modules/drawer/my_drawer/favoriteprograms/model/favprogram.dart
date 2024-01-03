

import 'package:freezed_annotation/freezed_annotation.dart';

part 'favprogram.freezed.dart';

part 'favprogram.g.dart';

@freezed
class FavProgramModel with _$FavProgramModel {
  factory FavProgramModel({
    required int? care_program_id,
    required  String? care_program_name,
    required  String? created_at,
    required  String? description,
    required  List<int>? part_group,
    required  int? routin_days,
    required  String? time_spent,
    required  String? image,
    required  int? count,
  }) = _FavProgramModel;

  factory FavProgramModel.fromJson(Map<String, dynamic> json) => _$FavProgramModelFromJson(json);
}
