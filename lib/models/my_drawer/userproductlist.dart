import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/my_drawer/userproduct.dart';

part 'userproductlist.freezed.dart';

part 'userproductlist.g.dart';

@freezed
class UserProductList with _$UserProductList {
  factory UserProductList({
    required bool status,
    required List<UserProduct> userProduct,
  }) = _UserProductList;

  factory UserProductList.fromJson(Map<String, dynamic> json) => _$UserProductListFromJson(json);
}
