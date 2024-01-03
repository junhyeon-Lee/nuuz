
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    @JsonKey(name:"product_id")
    required String productId,
    required String name,
    String? description,
    String? value,
    @JsonKey(name: 'image') required List<String> imageUrl,
  }) = _Product;
	
  factory Product.fromJson(Map<String, dynamic> json) =>
			_$ProductFromJson(json);
}
