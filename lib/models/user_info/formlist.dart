
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/user_info/termslist.dart';
part 'formlist.freezed.dart';
part 'formlist.g.dart';

@freezed
class FormList with _$FormList {
  factory FormList({
    required bool? status,
     TermsList? resultData,
  }) = _FormList;

  factory FormList.fromJson(Map<String, dynamic> json) =>
      _$FormListFromJson(json);
}
