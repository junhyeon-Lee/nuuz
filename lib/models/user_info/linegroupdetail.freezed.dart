// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'linegroupdetail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LineGroupDetail _$LineGroupDetailFromJson(Map<String, dynamic> json) {
  return _LineGroupDetail.fromJson(json);
}

/// @nodoc
mixin _$LineGroupDetail {
  int? get value => throw _privateConstructorUsedError;
  int? get cartridge => throw _privateConstructorUsedError;
  String? get line_name => throw _privateConstructorUsedError;
  String? get short_name => throw _privateConstructorUsedError;
  int? get line_group_id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LineGroupDetailCopyWith<LineGroupDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LineGroupDetailCopyWith<$Res> {
  factory $LineGroupDetailCopyWith(
          LineGroupDetail value, $Res Function(LineGroupDetail) then) =
      _$LineGroupDetailCopyWithImpl<$Res, LineGroupDetail>;
  @useResult
  $Res call(
      {int? value,
      int? cartridge,
      String? line_name,
      String? short_name,
      int? line_group_id});
}

/// @nodoc
class _$LineGroupDetailCopyWithImpl<$Res, $Val extends LineGroupDetail>
    implements $LineGroupDetailCopyWith<$Res> {
  _$LineGroupDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? cartridge = freezed,
    Object? line_name = freezed,
    Object? short_name = freezed,
    Object? line_group_id = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      cartridge: freezed == cartridge
          ? _value.cartridge
          : cartridge // ignore: cast_nullable_to_non_nullable
              as int?,
      line_name: freezed == line_name
          ? _value.line_name
          : line_name // ignore: cast_nullable_to_non_nullable
              as String?,
      short_name: freezed == short_name
          ? _value.short_name
          : short_name // ignore: cast_nullable_to_non_nullable
              as String?,
      line_group_id: freezed == line_group_id
          ? _value.line_group_id
          : line_group_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LineGroupDetailCopyWith<$Res>
    implements $LineGroupDetailCopyWith<$Res> {
  factory _$$_LineGroupDetailCopyWith(
          _$_LineGroupDetail value, $Res Function(_$_LineGroupDetail) then) =
      __$$_LineGroupDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? value,
      int? cartridge,
      String? line_name,
      String? short_name,
      int? line_group_id});
}

/// @nodoc
class __$$_LineGroupDetailCopyWithImpl<$Res>
    extends _$LineGroupDetailCopyWithImpl<$Res, _$_LineGroupDetail>
    implements _$$_LineGroupDetailCopyWith<$Res> {
  __$$_LineGroupDetailCopyWithImpl(
      _$_LineGroupDetail _value, $Res Function(_$_LineGroupDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? cartridge = freezed,
    Object? line_name = freezed,
    Object? short_name = freezed,
    Object? line_group_id = freezed,
  }) {
    return _then(_$_LineGroupDetail(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      cartridge: freezed == cartridge
          ? _value.cartridge
          : cartridge // ignore: cast_nullable_to_non_nullable
              as int?,
      line_name: freezed == line_name
          ? _value.line_name
          : line_name // ignore: cast_nullable_to_non_nullable
              as String?,
      short_name: freezed == short_name
          ? _value.short_name
          : short_name // ignore: cast_nullable_to_non_nullable
              as String?,
      line_group_id: freezed == line_group_id
          ? _value.line_group_id
          : line_group_id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LineGroupDetail implements _LineGroupDetail {
  _$_LineGroupDetail(
      {required this.value,
      required this.cartridge,
      required this.line_name,
      required this.short_name,
      required this.line_group_id});

  factory _$_LineGroupDetail.fromJson(Map<String, dynamic> json) =>
      _$$_LineGroupDetailFromJson(json);

  @override
  final int? value;
  @override
  final int? cartridge;
  @override
  final String? line_name;
  @override
  final String? short_name;
  @override
  final int? line_group_id;

  @override
  String toString() {
    return 'LineGroupDetail(value: $value, cartridge: $cartridge, line_name: $line_name, short_name: $short_name, line_group_id: $line_group_id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LineGroupDetail &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.cartridge, cartridge) ||
                other.cartridge == cartridge) &&
            (identical(other.line_name, line_name) ||
                other.line_name == line_name) &&
            (identical(other.short_name, short_name) ||
                other.short_name == short_name) &&
            (identical(other.line_group_id, line_group_id) ||
                other.line_group_id == line_group_id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, cartridge, line_name, short_name, line_group_id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LineGroupDetailCopyWith<_$_LineGroupDetail> get copyWith =>
      __$$_LineGroupDetailCopyWithImpl<_$_LineGroupDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LineGroupDetailToJson(
      this,
    );
  }
}

abstract class _LineGroupDetail implements LineGroupDetail {
  factory _LineGroupDetail(
      {required final int? value,
      required final int? cartridge,
      required final String? line_name,
      required final String? short_name,
      required final int? line_group_id}) = _$_LineGroupDetail;

  factory _LineGroupDetail.fromJson(Map<String, dynamic> json) =
      _$_LineGroupDetail.fromJson;

  @override
  int? get value;
  @override
  int? get cartridge;
  @override
  String? get line_name;
  @override
  String? get short_name;
  @override
  int? get line_group_id;
  @override
  @JsonKey(ignore: true)
  _$$_LineGroupDetailCopyWith<_$_LineGroupDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
