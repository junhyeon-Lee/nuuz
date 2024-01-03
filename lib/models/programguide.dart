import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/subprogram.dart';

part 'programguide.freezed.dart';
part 'programguide.g.dart';

@freezed
class ProgramGuide with _$ProgramGuide {
  factory ProgramGuide({
    required String? name,
    required String? image,
    required String? title,
    required String? cartridge,
    required String? description,
  }) = _ProgramGuide;

  factory ProgramGuide.fromJson(Map<String, dynamic> json) =>
      _$ProgramGuideFromJson(json);
}
