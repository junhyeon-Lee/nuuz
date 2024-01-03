import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/my_nuuz/partdetail.dart';

part 'resultprogram.freezed.dart';
part 'resultprogram.g.dart';

@freezed
class ResultProgram with _$ResultProgram {
  factory ResultProgram({
    required String? description,
    required int? progaram_id,
    required String? care_program_name,
  }) = _ResultProgram;

  factory ResultProgram.fromJson(Map<String, dynamic> json) =>
      _$ResultProgramFromJson(json);
}
