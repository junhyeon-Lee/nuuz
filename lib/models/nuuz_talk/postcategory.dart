
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'postcategory.freezed.dart';
part 'postcategory.g.dart';

@freezed
class PostCategory with _$PostCategory {
  factory PostCategory({
    @JsonKey(name: "category_id") required String id,
    required String name,

  }) = _PostCategory;
	
  factory PostCategory.fromJson(Map<String, dynamic> json) =>
			_$PostCategoryFromJson(json);
}
