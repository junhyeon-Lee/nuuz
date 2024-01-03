import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/my_nuuz/partdetail.dart';

part 'subprogram.freezed.dart';
part 'subprogram.g.dart';

@freezed
class SubProgram with _$SubProgram {
  factory SubProgram({
    required List<String>? areas,
    required String? cartridgeType,
    required List<PartDetail>? partDetails,
    required int expectedShots
  }) = _SubProgram;

  factory SubProgram.fromJson(Map<String, dynamic> json) =>
      _$SubProgramFromJson(json);
}
