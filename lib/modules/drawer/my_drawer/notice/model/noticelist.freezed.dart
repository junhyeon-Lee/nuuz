// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'noticelist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoticeList _$NoticeListFromJson(Map<String, dynamic> json) {
  return _NoticeList.fromJson(json);
}

/// @nodoc
mixin _$NoticeList {
  int get count => throw _privateConstructorUsedError;
  List<Notice> get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoticeListCopyWith<NoticeList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeListCopyWith<$Res> {
  factory $NoticeListCopyWith(
          NoticeList value, $Res Function(NoticeList) then) =
      _$NoticeListCopyWithImpl<$Res, NoticeList>;
  @useResult
  $Res call({int count, List<Notice> result});
}

/// @nodoc
class _$NoticeListCopyWithImpl<$Res, $Val extends NoticeList>
    implements $NoticeListCopyWith<$Res> {
  _$NoticeListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Notice>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoticeListCopyWith<$Res>
    implements $NoticeListCopyWith<$Res> {
  factory _$$_NoticeListCopyWith(
          _$_NoticeList value, $Res Function(_$_NoticeList) then) =
      __$$_NoticeListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int count, List<Notice> result});
}

/// @nodoc
class __$$_NoticeListCopyWithImpl<$Res>
    extends _$NoticeListCopyWithImpl<$Res, _$_NoticeList>
    implements _$$_NoticeListCopyWith<$Res> {
  __$$_NoticeListCopyWithImpl(
      _$_NoticeList _value, $Res Function(_$_NoticeList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? result = null,
  }) {
    return _then(_$_NoticeList(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Notice>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NoticeList implements _NoticeList {
  _$_NoticeList({required this.count, required final List<Notice> result})
      : _result = result;

  factory _$_NoticeList.fromJson(Map<String, dynamic> json) =>
      _$$_NoticeListFromJson(json);

  @override
  final int count;
  final List<Notice> _result;
  @override
  List<Notice> get result {
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_result);
  }

  @override
  String toString() {
    return 'NoticeList(count: $count, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoticeList &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, count, const DeepCollectionEquality().hash(_result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoticeListCopyWith<_$_NoticeList> get copyWith =>
      __$$_NoticeListCopyWithImpl<_$_NoticeList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoticeListToJson(
      this,
    );
  }
}

abstract class _NoticeList implements NoticeList {
  factory _NoticeList(
      {required final int count,
      required final List<Notice> result}) = _$_NoticeList;

  factory _NoticeList.fromJson(Map<String, dynamic> json) =
      _$_NoticeList.fromJson;

  @override
  int get count;
  @override
  List<Notice> get result;
  @override
  @JsonKey(ignore: true)
  _$$_NoticeListCopyWith<_$_NoticeList> get copyWith =>
      throw _privateConstructorUsedError;
}
