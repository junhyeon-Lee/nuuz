// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userproductlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserProductList _$UserProductListFromJson(Map<String, dynamic> json) {
  return _UserProductList.fromJson(json);
}

/// @nodoc
mixin _$UserProductList {
  bool get status => throw _privateConstructorUsedError;
  List<UserProduct> get userProduct => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProductListCopyWith<UserProductList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProductListCopyWith<$Res> {
  factory $UserProductListCopyWith(
          UserProductList value, $Res Function(UserProductList) then) =
      _$UserProductListCopyWithImpl<$Res, UserProductList>;
  @useResult
  $Res call({bool status, List<UserProduct> userProduct});
}

/// @nodoc
class _$UserProductListCopyWithImpl<$Res, $Val extends UserProductList>
    implements $UserProductListCopyWith<$Res> {
  _$UserProductListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? userProduct = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      userProduct: null == userProduct
          ? _value.userProduct
          : userProduct // ignore: cast_nullable_to_non_nullable
              as List<UserProduct>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserProductListCopyWith<$Res>
    implements $UserProductListCopyWith<$Res> {
  factory _$$_UserProductListCopyWith(
          _$_UserProductList value, $Res Function(_$_UserProductList) then) =
      __$$_UserProductListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<UserProduct> userProduct});
}

/// @nodoc
class __$$_UserProductListCopyWithImpl<$Res>
    extends _$UserProductListCopyWithImpl<$Res, _$_UserProductList>
    implements _$$_UserProductListCopyWith<$Res> {
  __$$_UserProductListCopyWithImpl(
      _$_UserProductList _value, $Res Function(_$_UserProductList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? userProduct = null,
  }) {
    return _then(_$_UserProductList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      userProduct: null == userProduct
          ? _value._userProduct
          : userProduct // ignore: cast_nullable_to_non_nullable
              as List<UserProduct>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserProductList implements _UserProductList {
  _$_UserProductList(
      {required this.status, required final List<UserProduct> userProduct})
      : _userProduct = userProduct;

  factory _$_UserProductList.fromJson(Map<String, dynamic> json) =>
      _$$_UserProductListFromJson(json);

  @override
  final bool status;
  final List<UserProduct> _userProduct;
  @override
  List<UserProduct> get userProduct {
    if (_userProduct is EqualUnmodifiableListView) return _userProduct;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userProduct);
  }

  @override
  String toString() {
    return 'UserProductList(status: $status, userProduct: $userProduct)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserProductList &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._userProduct, _userProduct));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_userProduct));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserProductListCopyWith<_$_UserProductList> get copyWith =>
      __$$_UserProductListCopyWithImpl<_$_UserProductList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserProductListToJson(
      this,
    );
  }
}

abstract class _UserProductList implements UserProductList {
  factory _UserProductList(
      {required final bool status,
      required final List<UserProduct> userProduct}) = _$_UserProductList;

  factory _UserProductList.fromJson(Map<String, dynamic> json) =
      _$_UserProductList.fromJson;

  @override
  bool get status;
  @override
  List<UserProduct> get userProduct;
  @override
  @JsonKey(ignore: true)
  _$$_UserProductListCopyWith<_$_UserProductList> get copyWith =>
      throw _privateConstructorUsedError;
}
