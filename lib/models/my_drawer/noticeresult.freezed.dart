// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'noticeresult.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoticeResult _$NoticeResultFromJson(Map<String, dynamic> json) {
  return _NoticeResult.fromJson(json);
}

/// @nodoc
mixin _$NoticeResult {
  bool get status => throw _privateConstructorUsedError;
  NoticeList get noticeData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoticeResultCopyWith<NoticeResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeResultCopyWith<$Res> {
  factory $NoticeResultCopyWith(
          NoticeResult value, $Res Function(NoticeResult) then) =
      _$NoticeResultCopyWithImpl<$Res, NoticeResult>;
  @useResult
  $Res call({bool status, NoticeList noticeData});

  $NoticeListCopyWith<$Res> get noticeData;
}

/// @nodoc
class _$NoticeResultCopyWithImpl<$Res, $Val extends NoticeResult>
    implements $NoticeResultCopyWith<$Res> {
  _$NoticeResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? noticeData = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      noticeData: null == noticeData
          ? _value.noticeData
          : noticeData // ignore: cast_nullable_to_non_nullable
              as NoticeList,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NoticeListCopyWith<$Res> get noticeData {
    return $NoticeListCopyWith<$Res>(_value.noticeData, (value) {
      return _then(_value.copyWith(noticeData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_NoticeResultCopyWith<$Res>
    implements $NoticeResultCopyWith<$Res> {
  factory _$$_NoticeResultCopyWith(
          _$_NoticeResult value, $Res Function(_$_NoticeResult) then) =
      __$$_NoticeResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, NoticeList noticeData});

  @override
  $NoticeListCopyWith<$Res> get noticeData;
}

/// @nodoc
class __$$_NoticeResultCopyWithImpl<$Res>
    extends _$NoticeResultCopyWithImpl<$Res, _$_NoticeResult>
    implements _$$_NoticeResultCopyWith<$Res> {
  __$$_NoticeResultCopyWithImpl(
      _$_NoticeResult _value, $Res Function(_$_NoticeResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? noticeData = null,
  }) {
    return _then(_$_NoticeResult(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      noticeData: null == noticeData
          ? _value.noticeData
          : noticeData // ignore: cast_nullable_to_non_nullable
              as NoticeList,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NoticeResult implements _NoticeResult {
  _$_NoticeResult({required this.status, required this.noticeData});

  factory _$_NoticeResult.fromJson(Map<String, dynamic> json) =>
      _$$_NoticeResultFromJson(json);

  @override
  final bool status;
  @override
  final NoticeList noticeData;

  @override
  String toString() {
    return 'NoticeResult(status: $status, noticeData: $noticeData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoticeResult &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.noticeData, noticeData) ||
                other.noticeData == noticeData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, noticeData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoticeResultCopyWith<_$_NoticeResult> get copyWith =>
      __$$_NoticeResultCopyWithImpl<_$_NoticeResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoticeResultToJson(
      this,
    );
  }
}

abstract class _NoticeResult implements NoticeResult {
  factory _NoticeResult(
      {required final bool status,
      required final NoticeList noticeData}) = _$_NoticeResult;

  factory _NoticeResult.fromJson(Map<String, dynamic> json) =
      _$_NoticeResult.fromJson;

  @override
  bool get status;
  @override
  NoticeList get noticeData;
  @override
  @JsonKey(ignore: true)
  _$$_NoticeResultCopyWith<_$_NoticeResult> get copyWith =>
      throw _privateConstructorUsedError;
}
