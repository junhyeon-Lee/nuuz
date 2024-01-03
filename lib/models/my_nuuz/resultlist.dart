import 'package:nuuz/models/my_nuuz/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'resultlist.freezed.dart';

part 'resultlist.g.dart';

@freezed
class ResultList with _$ResultList {
  factory ResultList({
    required bool? status,
    required List<Result>? resultData,
  }) = _ResultList;

  factory ResultList.fromJson(Map<String, dynamic> json) => _$ResultListFromJson(json);
}
