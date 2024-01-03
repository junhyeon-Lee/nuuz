

import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq.freezed.dart';

part 'faq.g.dart';

@freezed
class FaqModel with _$FaqModel {
  factory FaqModel({
    required String? faq_id,
    required  String? category,
    required  String? title_text,
    required  String? content_text,
    required  String? status,
    required  int? is_deleted,
    required  String? created_at,
    required  String? updated_at,
  }) = _FaqModel;

  factory FaqModel.fromJson(Map<String, dynamic> json) => _$FaqModelFromJson(json);
}
