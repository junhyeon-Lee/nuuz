// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subprogram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubProgram _$SubProgramFromJson(Map<String, dynamic> json) {
  return _SubProgram.fromJson(json);
}

/// @nodoc
mixin _$SubProgram {
  List<String>? get areas => throw _privateConstructorUsedError;
  String? get cartridgeType => throw _privateConstructorUsedError;
  List<PartDetail>? get partDetails => throw _privateConstructorUsedError;
  int get expectedShots => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubProgramCopyWith<SubProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubProgramCopyWith<$Res> {
  factory $SubProgramCopyWith(
          SubProgram value, $Res Function(SubProgram) then) =
      _$SubProgramCopyWithImpl<$Res, SubProgram>;
  @useResult
  $Res call(
      {List<String>? areas,
      String? cartridgeType,
      List<PartDetail>? partDetails,
      int expectedShots});
}

/// @nodoc
class _$SubProgramCopyWithImpl<$Res, $Val extends SubProgram>
    implements $SubProgramCopyWith<$Res> {
  _$SubProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areas = freezed,
    Object? cartridgeType = freezed,
    Object? partDetails = freezed,
    Object? expectedShots = null,
  }) {
    return _then(_value.copyWith(
      areas: freezed == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cartridgeType: freezed == cartridgeType
          ? _value.cartridgeType
          : cartridgeType // ignore: cast_nullable_to_non_nullable
              as String?,
      partDetails: freezed == partDetails
          ? _value.partDetails
          : partDetails // ignore: cast_nullable_to_non_nullable
              as List<PartDetail>?,
      expectedShots: null == expectedShots
          ? _value.expectedShots
          : expectedShots // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubProgramCopyWith<$Res>
    implements $SubProgramCopyWith<$Res> {
  factory _$$_SubProgramCopyWith(
          _$_SubProgram value, $Res Function(_$_SubProgram) then) =
      __$$_SubProgramCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? areas,
      String? cartridgeType,
      List<PartDetail>? partDetails,
      int expectedShots});
}

/// @nodoc
class __$$_SubProgramCopyWithImpl<$Res>
    extends _$SubProgramCopyWithImpl<$Res, _$_SubProgram>
    implements _$$_SubProgramCopyWith<$Res> {
  __$$_SubProgramCopyWithImpl(
      _$_SubProgram _value, $Res Function(_$_SubProgram) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areas = freezed,
    Object? cartridgeType = freezed,
    Object? partDetails = freezed,
    Object? expectedShots = null,
  }) {
    return _then(_$_SubProgram(
      areas: freezed == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cartridgeType: freezed == cartridgeType
          ? _value.cartridgeType
          : cartridgeType // ignore: cast_nullable_to_non_nullable
              as String?,
      partDetails: freezed == partDetails
          ? _value._partDetails
          : partDetails // ignore: cast_nullable_to_non_nullable
              as List<PartDetail>?,
      expectedShots: null == expectedShots
          ? _value.expectedShots
          : expectedShots // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubProgram implements _SubProgram {
  _$_SubProgram(
      {required final List<String>? areas,
      required this.cartridgeType,
      required final List<PartDetail>? partDetails,
      required this.expectedShots})
      : _areas = areas,
        _partDetails = partDetails;

  factory _$_SubProgram.fromJson(Map<String, dynamic> json) =>
      _$$_SubProgramFromJson(json);

  final List<String>? _areas;
  @override
  List<String>? get areas {
    final value = _areas;
    if (value == null) return null;
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? cartridgeType;
  final List<PartDetail>? _partDetails;
  @override
  List<PartDetail>? get partDetails {
    final value = _partDetails;
    if (value == null) return null;
    if (_partDetails is EqualUnmodifiableListView) return _partDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int expectedShots;

  @override
  String toString() {
    return 'SubProgram(areas: $areas, cartridgeType: $cartridgeType, partDetails: $partDetails, expectedShots: $expectedShots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SubProgram &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            (identical(other.cartridgeType, cartridgeType) ||
                other.cartridgeType == cartridgeType) &&
            const DeepCollectionEquality()
                .equals(other._partDetails, _partDetails) &&
            (identical(other.expectedShots, expectedShots) ||
                other.expectedShots == expectedShots));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_areas),
      cartridgeType,
      const DeepCollectionEquality().hash(_partDetails),
      expectedShots);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubProgramCopyWith<_$_SubProgram> get copyWith =>
      __$$_SubProgramCopyWithImpl<_$_SubProgram>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubProgramToJson(
      this,
    );
  }
}

abstract class _SubProgram implements SubProgram {
  factory _SubProgram(
      {required final List<String>? areas,
      required final String? cartridgeType,
      required final List<PartDetail>? partDetails,
      required final int expectedShots}) = _$_SubProgram;

  factory _SubProgram.fromJson(Map<String, dynamic> json) =
      _$_SubProgram.fromJson;

  @override
  List<String>? get areas;
  @override
  String? get cartridgeType;
  @override
  List<PartDetail>? get partDetails;
  @override
  int get expectedShots;
  @override
  @JsonKey(ignore: true)
  _$$_SubProgramCopyWith<_$_SubProgram> get copyWith =>
      throw _privateConstructorUsedError;
}
