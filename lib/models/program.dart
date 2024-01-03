
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/subprogram.dart';

part 'program.freezed.dart';
part 'program.g.dart';

@freezed
class Program with _$Program {
  factory Program({
    @JsonKey(name: "care_program_id") required int id,
    @JsonKey(name: "care_program_name") required String name,
    required String? description,
    @JsonKey(name: "routin_days") required int? routineDays,
    required String? image,
    required List<Subprogram>? subprograms,
    List<String>? product_id_array
  }) = _Program;
	
  factory Program.fromJson(Map<String, dynamic> json) =>
			_$ProgramFromJson(json);
}
