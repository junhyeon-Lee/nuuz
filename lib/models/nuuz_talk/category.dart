
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  factory Category({
    @JsonKey(name: "category_id") required String id,
    required String name,
  }) = _Category;
	
  factory Category.fromJson(Map<String, dynamic> json) =>
			_$CategoryFromJson(json);
}
