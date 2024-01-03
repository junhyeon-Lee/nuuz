
import 'package:freezed_annotation/freezed_annotation.dart';

import 'banner.dart';


part 'bannerlist.freezed.dart';
part 'bannerlist.g.dart';

@freezed
class BannerList with _$BannerList {
  factory BannerList({
    required bool status,
    required List<Banner>? resultData,
  }) = _BannerList;

  factory BannerList.fromJson(Map<String, dynamic> json) =>
      _$BannerListFromJson(json);
}
