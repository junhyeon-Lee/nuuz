
import 'package:freezed_annotation/freezed_annotation.dart';
part 'terms.freezed.dart';
part 'terms.g.dart';

@freezed
class Terms with _$Terms {
  factory Terms({
    required String? terms,
    required String? privacy,
    required String? marketing,
    required String? caution
  }) = _Terms;

  factory Terms.fromJson(Map<String, dynamic> json) =>
      _$TermsFromJson(json);
}
