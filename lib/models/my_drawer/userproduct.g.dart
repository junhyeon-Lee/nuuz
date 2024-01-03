// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userproduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProduct _$$_UserProductFromJson(Map<String, dynamic> json) =>
    _$_UserProduct(
      user_product_id: json['user_product_id'] as String,
      user_id: json['user_id'] as String,
      product_code: json['product_code'] as String?,
      created_at: DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      is_deleted: json['is_deleted'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserProductToJson(_$_UserProduct instance) =>
    <String, dynamic>{
      'user_product_id': instance.user_product_id,
      'user_id': instance.user_id,
      'product_code': instance.product_code,
      'created_at': instance.created_at.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'is_deleted': instance.is_deleted,
      'product': instance.product,
    };
