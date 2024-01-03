
import 'package:freezed_annotation/freezed_annotation.dart';
part 'form.freezed.dart';
part 'form.g.dart';

@freezed
class Form with _$Form {
  factory Form({
    required String? form_id,
    required String? title,
    required String? content,
    required String? image,
    required String? type,
    required String? status,
    required String? created_at,
    required String? updated_at,
    required int? is_deleted
  }) = _Form;

  factory Form.fromJson(Map<String, dynamic> json) =>
      _$FormFromJson(json);
}
