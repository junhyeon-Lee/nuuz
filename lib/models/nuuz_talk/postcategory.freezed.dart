// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'postcategory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostCategory _$PostCategoryFromJson(Map<String, dynamic> json) {
  return _PostCategory.fromJson(json);
}

/// @nodoc
mixin _$PostCategory {
  @JsonKey(name: "category_id")
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCategoryCopyWith<PostCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCategoryCopyWith<$Res> {
  factory $PostCategoryCopyWith(
          PostCategory value, $Res Function(PostCategory) then) =
      _$PostCategoryCopyWithImpl<$Res, PostCategory>;
  @useResult
  $Res call({@JsonKey(name: "category_id") String id, String name});
}

/// @nodoc
class _$PostCategoryCopyWithImpl<$Res, $Val extends PostCategory>
    implements $PostCategoryCopyWith<$Res> {
  _$PostCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostCategoryCopyWith<$Res>
    implements $PostCategoryCopyWith<$Res> {
  factory _$$_PostCategoryCopyWith(
          _$_PostCategory value, $Res Function(_$_PostCategory) then) =
      __$$_PostCategoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "category_id") String id, String name});
}

/// @nodoc
class __$$_PostCategoryCopyWithImpl<$Res>
    extends _$PostCategoryCopyWithImpl<$Res, _$_PostCategory>
    implements _$$_PostCategoryCopyWith<$Res> {
  __$$_PostCategoryCopyWithImpl(
      _$_PostCategory _value, $Res Function(_$_PostCategory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_PostCategory(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostCategory implements _PostCategory {
  _$_PostCategory(
      {@JsonKey(name: "category_id") required this.id, required this.name});

  factory _$_PostCategory.fromJson(Map<String, dynamic> json) =>
      _$$_PostCategoryFromJson(json);

  @override
  @JsonKey(name: "category_id")
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'PostCategory(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostCategory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostCategoryCopyWith<_$_PostCategory> get copyWith =>
      __$$_PostCategoryCopyWithImpl<_$_PostCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostCategoryToJson(
      this,
    );
  }
}

abstract class _PostCategory implements PostCategory {
  factory _PostCategory(
      {@JsonKey(name: "category_id") required final String id,
      required final String name}) = _$_PostCategory;

  factory _PostCategory.fromJson(Map<String, dynamic> json) =
      _$_PostCategory.fromJson;

  @override
  @JsonKey(name: "category_id")
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_PostCategoryCopyWith<_$_PostCategory> get copyWith =>
      throw _privateConstructorUsedError;
}
