
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/model/faq.dart';

import '../../favoriteprograms/model/favprogram.dart';



part 'favprogramlist.freezed.dart';

part 'favprogramlist.g.dart';

@freezed
class FavProgramList with _$FavProgramList {
  factory FavProgramList({
    required bool status,
    required List<FavProgramModel> favouriteData,
  }) = _FavProgramList;

  factory FavProgramList.fromJson(Map<String, dynamic> json) => _$FavProgramListFromJson(json);
}
