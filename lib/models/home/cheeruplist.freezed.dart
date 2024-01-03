// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cheeruplist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheerUpList _$CheerUpListFromJson(Map<String, dynamic> json) {
  return _CheerUpList.fromJson(json);
}

/// @nodoc
mixin _$CheerUpList {
  bool get status => throw _privateConstructorUsedError;
  List<CheerUp> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheerUpListCopyWith<CheerUpList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheerUpListCopyWith<$Res> {
  factory $CheerUpListCopyWith(
          CheerUpList value, $Res Function(CheerUpList) then) =
      _$CheerUpListCopyWithImpl<$Res, CheerUpList>;
  @useResult
  $Res call({bool status, List<CheerUp> data});
}

/// @nodoc
class _$CheerUpListCopyWithImpl<$Res, $Val extends CheerUpList>
    implements $CheerUpListCopyWith<$Res> {
  _$CheerUpListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CheerUp>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CheerUpListCopyWith<$Res>
    implements $CheerUpListCopyWith<$Res> {
  factory _$$_CheerUpListCopyWith(
          _$_CheerUpList value, $Res Function(_$_CheerUpList) then) =
      __$$_CheerUpListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<CheerUp> data});
}

/// @nodoc
class __$$_CheerUpListCopyWithImpl<$Res>
    extends _$CheerUpListCopyWithImpl<$Res, _$_CheerUpList>
    implements _$$_CheerUpListCopyWith<$Res> {
  __$$_CheerUpListCopyWithImpl(
      _$_CheerUpList _value, $Res Function(_$_CheerUpList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_$_CheerUpList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CheerUp>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheerUpList implements _CheerUpList {
  _$_CheerUpList({required this.status, required final List<CheerUp> data})
      : _data = data;

  factory _$_CheerUpList.fromJson(Map<String, dynamic> json) =>
      _$$_CheerUpListFromJson(json);

  @override
  final bool status;
  final List<CheerUp> _data;
  @override
  List<CheerUp> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'CheerUpList(status: $status, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheerUpList &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheerUpListCopyWith<_$_CheerUpList> get copyWith =>
      __$$_CheerUpListCopyWithImpl<_$_CheerUpList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheerUpListToJson(
      this,
    );
  }
}

abstract class _CheerUpList implements CheerUpList {
  factory _CheerUpList(
      {required final bool status,
      required final List<CheerUp> data}) = _$_CheerUpList;

  factory _CheerUpList.fromJson(Map<String, dynamic> json) =
      _$_CheerUpList.fromJson;

  @override
  bool get status;
  @override
  List<CheerUp> get data;
  @override
  @JsonKey(ignore: true)
  _$$_CheerUpListCopyWith<_$_CheerUpList> get copyWith =>
      throw _privateConstructorUsedError;
}
