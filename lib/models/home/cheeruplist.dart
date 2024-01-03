
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/home/cheerup.dart';

part 'cheeruplist.freezed.dart';
part 'cheeruplist.g.dart';

@freezed
class CheerUpList with _$CheerUpList {
  factory CheerUpList({
    required bool status,
    required List<CheerUp> data

  }) = _CheerUpList;

  factory CheerUpList.fromJson(Map<String, dynamic> json) =>
      _$CheerUpListFromJson(json);
}
