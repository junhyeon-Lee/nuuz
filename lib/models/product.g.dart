// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      productId: json['product_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      value: json['value'] as String?,
      imageUrl:
          (json['image'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'image': instance.imageUrl,
    };
