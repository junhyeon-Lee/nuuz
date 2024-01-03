// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userproduct.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserProduct _$UserProductFromJson(Map<String, dynamic> json) {
  return _UserProduct.fromJson(json);
}

/// @nodoc
mixin _$UserProduct {
  String get user_product_id => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  String? get product_code => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;
  int get is_deleted => throw _privateConstructorUsedError;
  Product get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProductCopyWith<UserProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductCopyWith<$Res> {
  factory $UserProductCopyWith(
          UserProduct value, $Res Function(UserProduct) then) =
      _$UserProductCopyWithImpl<$Res, UserProduct>;
  @useResult
  $Res call(
      {String user_product_id,
      String user_id,
      String? product_code,
      DateTime created_at,
      DateTime? updated_at,
      int is_deleted,
      Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$UserProductCopyWithImpl<$Res, $Val extends UserProduct>
    implements $UserProductCopyWith<$Res> {
  _$UserProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_product_id = null,
    Object? user_id = null,
    Object? product_code = freezed,
    Object? created_at = null,
    Object? updated_at = freezed,
    Object? is_deleted = null,
    Object? product = null,
  }) {
    return _then(_value.copyWith(
      user_product_id: null == user_product_id
          ? _value.user_product_id
          : user_product_id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      product_code: freezed == product_code
          ? _value.product_code
          : product_code // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      is_deleted: null == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserProductCopyWith<$Res>
    implements $UserProductCopyWith<$Res> {
  factory _$$_UserProductCopyWith(
          _$_UserProduct value, $Res Function(_$_UserProduct) then) =
      __$$_UserProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String user_product_id,
      String user_id,
      String? product_code,
      DateTime created_at,
      DateTime? updated_at,
      int is_deleted,
      Product product});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$_UserProductCopyWithImpl<$Res>
    extends _$UserProductCopyWithImpl<$Res, _$_UserProduct>
    implements _$$_UserProductCopyWith<$Res> {
  __$$_UserProductCopyWithImpl(
      _$_UserProduct _value, $Res Function(_$_UserProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_product_id = null,
    Object? user_id = null,
    Object? product_code = freezed,
    Object? created_at = null,
    Object? updated_at = freezed,
    Object? is_deleted = null,
    Object? product = null,
  }) {
    return _then(_$_UserProduct(
      user_product_id: null == user_product_id
          ? _value.user_product_id
          : user_product_id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      product_code: freezed == product_code
          ? _value.product_code
          : product_code // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      is_deleted: null == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int,
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserProduct implements _UserProduct {
  _$_UserProduct(
      {required this.user_product_id,
      required this.user_id,
      this.product_code,
      required this.created_at,
      required this.updated_at,
      required this.is_deleted,
      required this.product});

  factory _$_UserProduct.fromJson(Map<String, dynamic> json) =>
      _$$_UserProductFromJson(json);

  @override
  final String user_product_id;
  @override
  final String user_id;
  @override
  final String? product_code;
  @override
  final DateTime created_at;
  @override
  final DateTime? updated_at;
  @override
  final int is_deleted;
  @override
  final Product product;

  @override
  String toString() {
    return 'UserProduct(user_product_id: $user_product_id, user_id: $user_id, product_code: $product_code, created_at: $created_at, updated_at: $updated_at, is_deleted: $is_deleted, product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProduct &&
            (identical(other.user_product_id, user_product_id) ||
                other.user_product_id == user_product_id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.product_code, product_code) ||
                other.product_code == product_code) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user_product_id, user_id,
      product_code, created_at, updated_at, is_deleted, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProductCopyWith<_$_UserProduct> get copyWith =>
      __$$_UserProductCopyWithImpl<_$_UserProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserProductToJson(
      this,
    );
  }
}

abstract class _UserProduct implements UserProduct {
  factory _UserProduct(
      {required final String user_product_id,
      required final String user_id,
      final String? product_code,
      required final DateTime created_at,
      required final DateTime? updated_at,
      required final int is_deleted,
      required final Product product}) = _$_UserProduct;

  factory _UserProduct.fromJson(Map<String, dynamic> json) =
      _$_UserProduct.fromJson;

  @override
  String get user_product_id;
  @override
  String get user_id;
  @override
  String? get product_code;
  @override
  DateTime get created_at;
  @override
  DateTime? get updated_at;
  @override
  int get is_deleted;
  @override
  Product get product;
  @override
  @JsonKey(ignore: true)
  _$$_UserProductCopyWith<_$_UserProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
