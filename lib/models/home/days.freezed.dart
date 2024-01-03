// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'days.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Days _$DaysFromJson(Map<String, dynamic> json) {
  return _Days.fromJson(json);
}

/// @nodoc
mixin _$Days {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;
  bool get inMonth => throw _privateConstructorUsedError;
  bool get picked => throw _privateConstructorUsedError;
  bool get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DaysCopyWith<Days> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DaysCopyWith<$Res> {
  factory $DaysCopyWith(Days value, $Res Function(Days) then) =
      _$DaysCopyWithImpl<$Res, Days>;
  @useResult
  $Res call(
      {int year, int month, int day, bool inMonth, bool picked, bool result});
}

/// @nodoc
class _$DaysCopyWithImpl<$Res, $Val extends Days>
    implements $DaysCopyWith<$Res> {
  _$DaysCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
    Object? inMonth = null,
    Object? picked = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      inMonth: null == inMonth
          ? _value.inMonth
          : inMonth // ignore: cast_nullable_to_non_nullable
              as bool,
      picked: null == picked
          ? _value.picked
          : picked // ignore: cast_nullable_to_non_nullable
              as bool,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DaysCopyWith<$Res> implements $DaysCopyWith<$Res> {
  factory _$$_DaysCopyWith(_$_Days value, $Res Function(_$_Days) then) =
      __$$_DaysCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int year, int month, int day, bool inMonth, bool picked, bool result});
}

/// @nodoc
class __$$_DaysCopyWithImpl<$Res> extends _$DaysCopyWithImpl<$Res, _$_Days>
    implements _$$_DaysCopyWith<$Res> {
  __$$_DaysCopyWithImpl(_$_Days _value, $Res Function(_$_Days) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
    Object? inMonth = null,
    Object? picked = null,
    Object? result = null,
  }) {
    return _then(_$_Days(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      inMonth: null == inMonth
          ? _value.inMonth
          : inMonth // ignore: cast_nullable_to_non_nullable
              as bool,
      picked: null == picked
          ? _value.picked
          : picked // ignore: cast_nullable_to_non_nullable
              as bool,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Days implements _Days {
  _$_Days(
      {required this.year,
      required this.month,
      required this.day,
      required this.inMonth,
      required this.picked,
      required this.result});

  factory _$_Days.fromJson(Map<String, dynamic> json) => _$$_DaysFromJson(json);

  @override
  final int year;
  @override
  final int month;
  @override
  final int day;
  @override
  final bool inMonth;
  @override
  final bool picked;
  @override
  final bool result;

  @override
  String toString() {
    return 'Days(year: $year, month: $month, day: $day, inMonth: $inMonth, picked: $picked, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Days &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.inMonth, inMonth) || other.inMonth == inMonth) &&
            (identical(other.picked, picked) || other.picked == picked) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, year, month, day, inMonth, picked, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DaysCopyWith<_$_Days> get copyWith =>
      __$$_DaysCopyWithImpl<_$_Days>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DaysToJson(
      this,
    );
  }
}

abstract class _Days implements Days {
  factory _Days(
      {required final int year,
      required final int month,
      required final int day,
      required final bool inMonth,
      required final bool picked,
      required final bool result}) = _$_Days;

  factory _Days.fromJson(Map<String, dynamic> json) = _$_Days.fromJson;

  @override
  int get year;
  @override
  int get month;
  @override
  int get day;
  @override
  bool get inMonth;
  @override
  bool get picked;
  @override
  bool get result;
  @override
  @JsonKey(ignore: true)
  _$$_DaysCopyWith<_$_Days> get copyWith => throw _privateConstructorUsedError;
}
