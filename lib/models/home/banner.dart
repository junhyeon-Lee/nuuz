
import 'package:freezed_annotation/freezed_annotation.dart';


part 'banner.freezed.dart';
part 'banner.g.dart';

@freezed
class Banner with _$Banner {
  factory Banner({
  required String? banner_id,
  required String? banner_image,
  required String? title_text,
  required String? content_text,
  required String? link,
  required String? banner_order,
  required String? status,
  required int? is_deleted,
  required String? created_at,
  required String? updated_at,
  required String? link_value
  }) = _Banner;

  factory Banner.fromJson(Map<String, dynamic> json) =>
      _$BannerFromJson(json);
}
