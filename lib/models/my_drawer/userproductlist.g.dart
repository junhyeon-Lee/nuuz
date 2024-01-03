// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userproductlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProductList _$$_UserProductListFromJson(Map<String, dynamic> json) =>
    _$_UserProductList(
      status: json['status'] as bool,
      userProduct: (json['userProduct'] as List<dynamic>)
          .map((e) => UserProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserProductListToJson(_$_UserProductList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'userProduct': instance.userProduct,
    };
