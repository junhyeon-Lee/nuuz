
import 'package:freezed_annotation/freezed_annotation.dart';

import 'form.dart';
part 'termslist.freezed.dart';
part 'termslist.g.dart';

@freezed
class TermsList with _$TermsList {
  factory TermsList({

    required List<Form>? form,
    required int? count,
  }) = _TermsList;

  factory TermsList.fromJson(Map<String, dynamic> json) =>
      _$TermsListFromJson(json);
}
