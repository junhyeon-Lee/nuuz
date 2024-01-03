import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/product.dart';

part 'userproduct.freezed.dart';

part 'userproduct.g.dart';

@freezed
class UserProduct with _$UserProduct {
  factory UserProduct({
    required String user_product_id,
    required String user_id,
    String? product_code,
    required DateTime created_at,
    required DateTime? updated_at,
    required int is_deleted,
    required Product product,
  }) = _UserProduct;

  factory UserProduct.fromJson(Map<String, dynamic> json) => _$UserProductFromJson(json);
}
