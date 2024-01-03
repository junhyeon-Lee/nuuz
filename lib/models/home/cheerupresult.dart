
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/home/cheerup.dart';
import 'package:nuuz/models/home/mycheerup.dart';

part 'cheerupresult.freezed.dart';
part 'cheerupresult.g.dart';

@freezed
class CheerUpResult with _$CheerUpResult {
  factory CheerUpResult({
    required List<MyCheerUp> result,
    required int count

  }) = _CheerUpResult;

  factory CheerUpResult.fromJson(Map<String, dynamic> json) =>
      _$CheerUpResultFromJson(json);
}
