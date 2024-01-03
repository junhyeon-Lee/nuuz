// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/my_nuuz/resultprogram.dart';

part 'result.freezed.dart';

part 'result.g.dart';

@freezed
class Result with _$Result {
  factory Result({
    required String? result_id,
    required String? user_id,
    required String? product_id,
    required String? result_image,
    required String? date,
    required String? created_at,
    required String? updated_at,
    required int? is_deleted,
    required ResultProgram? program,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
