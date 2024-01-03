// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cheerupresult.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheerUpResult _$CheerUpResultFromJson(Map<String, dynamic> json) {
  return _CheerUpResult.fromJson(json);
}

/// @nodoc
mixin _$CheerUpResult {
  List<MyCheerUp> get result => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheerUpResultCopyWith<CheerUpResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheerUpResultCopyWith<$Res> {
  factory $CheerUpResultCopyWith(
          CheerUpResult value, $Res Function(CheerUpResult) then) =
      _$CheerUpResultCopyWithImpl<$Res, CheerUpResult>;
  @useResult
  $Res call({List<MyCheerUp> result, int count});
}

/// @nodoc
class _$CheerUpResultCopyWithImpl<$Res, $Val extends CheerUpResult>
    implements $CheerUpResultCopyWith<$Res> {
  _$CheerUpResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<MyCheerUp>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CheerUpResultCopyWith<$Res>
    implements $CheerUpResultCopyWith<$Res> {
  factory _$$_CheerUpResultCopyWith(
          _$_CheerUpResult value, $Res Function(_$_CheerUpResult) then) =
      __$$_CheerUpResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MyCheerUp> result, int count});
}

/// @nodoc
class __$$_CheerUpResultCopyWithImpl<$Res>
    extends _$CheerUpResultCopyWithImpl<$Res, _$_CheerUpResult>
    implements _$$_CheerUpResultCopyWith<$Res> {
  __$$_CheerUpResultCopyWithImpl(
      _$_CheerUpResult _value, $Res Function(_$_CheerUpResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? count = null,
  }) {
    return _then(_$_CheerUpResult(
      result: null == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<MyCheerUp>,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheerUpResult implements _CheerUpResult {
  _$_CheerUpResult({required final List<MyCheerUp> result, required this.count})
      : _result = result;

  factory _$_CheerUpResult.fromJson(Map<String, dynamic> json) =>
      _$$_CheerUpResultFromJson(json);

  final List<MyCheerUp> _result;
  @override
  List<MyCheerUp> get result {
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_result);
  }

  @override
  final int count;

  @override
  String toString() {
    return 'CheerUpResult(result: $result, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheerUpResult &&
            const DeepCollectionEquality().equals(other._result, _result) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_result), count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheerUpResultCopyWith<_$_CheerUpResult> get copyWith =>
      __$$_CheerUpResultCopyWithImpl<_$_CheerUpResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheerUpResultToJson(
      this,
    );
  }
}

abstract class _CheerUpResult implements CheerUpResult {
  factory _CheerUpResult(
      {required final List<MyCheerUp> result,
      required final int count}) = _$_CheerUpResult;

  factory _CheerUpResult.fromJson(Map<String, dynamic> json) =
      _$_CheerUpResult.fromJson;

  @override
  List<MyCheerUp> get result;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$_CheerUpResultCopyWith<_$_CheerUpResult> get copyWith =>
      throw _privateConstructorUsedError;
}
