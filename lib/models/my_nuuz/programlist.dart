import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/program.dart';

part 'programlist.freezed.dart';
part 'programlist.g.dart';

@freezed
class ProgramList with _$ProgramList {
  factory ProgramList({
    required bool status,
    required List<Program>? careProgram,
  }) = _ProgramList;

  factory ProgramList.fromJson(Map<String, dynamic> json) =>
      _$ProgramListFromJson(json);
}
