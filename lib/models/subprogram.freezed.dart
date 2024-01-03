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

Subprogram _$SubprogramFromJson(Map<String, dynamic> json) {
  return _Subprogram.fromJson(json);
}

/// @nodoc
mixin _$Subprogram {
  String get cartridgeType => throw _privateConstructorUsedError;
  int? get expectedShots => throw _privateConstructorUsedError;
  String? get timeInMin => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get areas => throw _privateConstructorUsedError;
  List<PartDetail> get partDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubprogramCopyWith<Subprogram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubprogramCopyWith<$Res> {
  factory $SubprogramCopyWith(
          Subprogram value, $Res Function(Subprogram) then) =
      _$SubprogramCopyWithImpl<$Res, Subprogram>;
  @useResult
  $Res call(
      {String cartridgeType,
      int? expectedShots,
      String? timeInMin,
      String? imageUrl,
      List<String> areas,
      List<PartDetail> partDetails});
}

/// @nodoc
class _$SubprogramCopyWithImpl<$Res, $Val extends Subprogram>
    implements $SubprogramCopyWith<$Res> {
  _$SubprogramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartridgeType = null,
    Object? expectedShots = freezed,
    Object? timeInMin = freezed,
    Object? imageUrl = freezed,
    Object? areas = null,
    Object? partDetails = null,
  }) {
    return _then(_value.copyWith(
      cartridgeType: null == cartridgeType
          ? _value.cartridgeType
          : cartridgeType // ignore: cast_nullable_to_non_nullable
              as String,
      expectedShots: freezed == expectedShots
          ? _value.expectedShots
          : expectedShots // ignore: cast_nullable_to_non_nullable
              as int?,
      timeInMin: freezed == timeInMin
          ? _value.timeInMin
          : timeInMin // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      areas: null == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      partDetails: null == partDetails
          ? _value.partDetails
          : partDetails // ignore: cast_nullable_to_non_nullable
              as List<PartDetail>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubprogramCopyWith<$Res>
    implements $SubprogramCopyWith<$Res> {
  factory _$$_SubprogramCopyWith(
          _$_Subprogram value, $Res Function(_$_Subprogram) then) =
      __$$_SubprogramCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cartridgeType,
      int? expectedShots,
      String? timeInMin,
      String? imageUrl,
      List<String> areas,
      List<PartDetail> partDetails});
}

/// @nodoc
class __$$_SubprogramCopyWithImpl<$Res>
    extends _$SubprogramCopyWithImpl<$Res, _$_Subprogram>
    implements _$$_SubprogramCopyWith<$Res> {
  __$$_SubprogramCopyWithImpl(
      _$_Subprogram _value, $Res Function(_$_Subprogram) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cartridgeType = null,
    Object? expectedShots = freezed,
    Object? timeInMin = freezed,
    Object? imageUrl = freezed,
    Object? areas = null,
    Object? partDetails = null,
  }) {
    return _then(_$_Subprogram(
      cartridgeType: null == cartridgeType
          ? _value.cartridgeType
          : cartridgeType // ignore: cast_nullable_to_non_nullable
              as String,
      expectedShots: freezed == expectedShots
          ? _value.expectedShots
          : expectedShots // ignore: cast_nullable_to_non_nullable
              as int?,
      timeInMin: freezed == timeInMin
          ? _value.timeInMin
          : timeInMin // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      partDetails: null == partDetails
          ? _value._partDetails
          : partDetails // ignore: cast_nullable_to_non_nullable
              as List<PartDetail>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Subprogram implements _Subprogram {
  _$_Subprogram(
      {required this.cartridgeType,
      this.expectedShots,
      required this.timeInMin,
      required this.imageUrl,
      required final List<String> areas,
      required final List<PartDetail> partDetails})
      : _areas = areas,
        _partDetails = partDetails;

  factory _$_Subprogram.fromJson(Map<String, dynamic> json) =>
      _$$_SubprogramFromJson(json);

  @override
  final String cartridgeType;
  @override
  final int? expectedShots;
  @override
  final String? timeInMin;
  @override
  final String? imageUrl;
  final List<String> _areas;
  @override
  List<String> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  final List<PartDetail> _partDetails;
  @override
  List<PartDetail> get partDetails {
    if (_partDetails is EqualUnmodifiableListView) return _partDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_partDetails);
  }

  @override
  String toString() {
    return 'Subprogram(cartridgeType: $cartridgeType, expectedShots: $expectedShots, timeInMin: $timeInMin, imageUrl: $imageUrl, areas: $areas, partDetails: $partDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Subprogram &&
            (identical(other.cartridgeType, cartridgeType) ||
                other.cartridgeType == cartridgeType) &&
            (identical(other.expectedShots, expectedShots) ||
                other.expectedShots == expectedShots) &&
            (identical(other.timeInMin, timeInMin) ||
                other.timeInMin == timeInMin) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            const DeepCollectionEquality()
                .equals(other._partDetails, _partDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      cartridgeType,
      expectedShots,
      timeInMin,
      imageUrl,
      const DeepCollectionEquality().hash(_areas),
      const DeepCollectionEquality().hash(_partDetails));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubprogramCopyWith<_$_Subprogram> get copyWith =>
      __$$_SubprogramCopyWithImpl<_$_Subprogram>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubprogramToJson(
      this,
    );
  }
}

abstract class _Subprogram implements Subprogram {
  factory _Subprogram(
      {required final String cartridgeType,
      final int? expectedShots,
      required final String? timeInMin,
      required final String? imageUrl,
      required final List<String> areas,
      required final List<PartDetail> partDetails}) = _$_Subprogram;

  factory _Subprogram.fromJson(Map<String, dynamic> json) =
      _$_Subprogram.fromJson;

  @override
  String get cartridgeType;
  @override
  int? get expectedShots;
  @override
  String? get timeInMin;
  @override
  String? get imageUrl;
  @override
  List<String> get areas;
  @override
  List<PartDetail> get partDetails;
  @override
  @JsonKey(ignore: true)
  _$$_SubprogramCopyWith<_$_Subprogram> get copyWith =>
      throw _privateConstructorUsedError;
}
