

import 'package:freezed_annotation/freezed_annotation.dart';

part 'selfdiagnosis.freezed.dart';

part 'selfdiagnosis.g.dart';

@freezed
class SelfDiagnosisModel with _$SelfDiagnosisModel {
  factory SelfDiagnosisModel({
    required String? self_diagnosis_id,
    required  String? user_id,
    required  String? skin_type,
    required  List<String>? skin_concerns,
    required  List<String>? detailed_concern,
    required  String? frequently_replaced,
    required  String? color_makeup,
    required  String? created_at,
    required  String? updated_at,
    required  int? is_deleted,
    required  String? skin_care_habits,
  }) = _SelfDiagnosisModel;

  factory SelfDiagnosisModel.fromJson(Map<String, dynamic> json) => _$SelfDiagnosisModelFromJson(json);
}
