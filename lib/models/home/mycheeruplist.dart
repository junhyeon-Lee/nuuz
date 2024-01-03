import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/home/cheerupresult.dart';
import 'package:nuuz/models/home/mycheerup.dart';

part 'mycheeruplist.freezed.dart';
part 'mycheeruplist.g.dart';

@freezed
class MyCheerUpList with _$MyCheerUpList {
  factory MyCheerUpList({
    required bool status,
    required CheerUpResult data,


  }) = _MyCheerUpList;

  factory MyCheerUpList.fromJson(Map<String, dynamic> json) =>
      _$MyCheerUpListFromJson(json);
}
