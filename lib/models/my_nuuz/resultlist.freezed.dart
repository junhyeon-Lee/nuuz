// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resultlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResultList _$ResultListFromJson(Map<String, dynamic> json) {
  return _ResultList.fromJson(json);
}

/// @nodoc
mixin _$ResultList {
  bool? get status => throw _privateConstructorUsedError;
  List<Result>? get resultData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultListCopyWith<ResultList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultListCopyWith<$Res> {
  factory $ResultListCopyWith(
          ResultList value, $Res Function(ResultList) then) =
      _$ResultListCopyWithImpl<$Res, ResultList>;
  @useResult
  $Res call({bool? status, List<Result>? resultData});
}

/// @nodoc
class _$ResultListCopyWithImpl<$Res, $Val extends ResultList>
    implements $ResultListCopyWith<$Res> {
  _$ResultListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? resultData = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      resultData: freezed == resultData
          ? _value.resultData
          : resultData // ignore: cast_nullable_to_non_nullable
              as List<Result>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResultListCopyWith<$Res>
    implements $ResultListCopyWith<$Res> {
  factory _$$_ResultListCopyWith(
          _$_ResultList value, $Res Function(_$_ResultList) then) =
      __$$_ResultListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? status, List<Result>? resultData});
}

/// @nodoc
class __$$_ResultListCopyWithImpl<$Res>
    extends _$ResultListCopyWithImpl<$Res, _$_ResultList>
    implements _$$_ResultListCopyWith<$Res> {
  __$$_ResultListCopyWithImpl(
      _$_ResultList _value, $Res Function(_$_ResultList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? resultData = freezed,
  }) {
    return _then(_$_ResultList(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      resultData: freezed == resultData
          ? _value._resultData
          : resultData // ignore: cast_nullable_to_non_nullable
              as List<Result>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ResultList implements _ResultList {
  _$_ResultList({required this.status, required final List<Result>? resultData})
      : _resultData = resultData;

  factory _$_ResultList.fromJson(Map<String, dynamic> json) =>
      _$$_ResultListFromJson(json);

  @override
  final bool? status;
  final List<Result>? _resultData;
  @override
  List<Result>? get resultData {
    final value = _resultData;
    if (value == null) return null;
    if (_resultData is EqualUnmodifiableListView) return _resultData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ResultList(status: $status, resultData: $resultData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResultList &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._resultData, _resultData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_resultData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultListCopyWith<_$_ResultList> get copyWith =>
      __$$_ResultListCopyWithImpl<_$_ResultList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResultListToJson(
      this,
    );
  }
}

abstract class _ResultList implements ResultList {
  factory _ResultList(
      {required final bool? status,
      required final List<Result>? resultData}) = _$_ResultList;

  factory _ResultList.fromJson(Map<String, dynamic> json) =
      _$_ResultList.fromJson;

  @override
  bool? get status;
  @override
  List<Result>? get resultData;
  @override
  @JsonKey(ignore: true)
  _$$_ResultListCopyWith<_$_ResultList> get copyWith =>
      throw _privateConstructorUsedError;
}
