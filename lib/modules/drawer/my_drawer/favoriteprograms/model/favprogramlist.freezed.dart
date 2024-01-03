// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favprogramlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavProgramList _$FavProgramListFromJson(Map<String, dynamic> json) {
  return _FavProgramList.fromJson(json);
}

/// @nodoc
mixin _$FavProgramList {
  bool get status => throw _privateConstructorUsedError;
  List<FavProgramModel> get favouriteData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavProgramListCopyWith<FavProgramList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavProgramListCopyWith<$Res> {
  factory $FavProgramListCopyWith(
          FavProgramList value, $Res Function(FavProgramList) then) =
      _$FavProgramListCopyWithImpl<$Res, FavProgramList>;
  @useResult
  $Res call({bool status, List<FavProgramModel> favouriteData});
}

/// @nodoc
class _$FavProgramListCopyWithImpl<$Res, $Val extends FavProgramList>
    implements $FavProgramListCopyWith<$Res> {
  _$FavProgramListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? favouriteData = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      favouriteData: null == favouriteData
          ? _value.favouriteData
          : favouriteData // ignore: cast_nullable_to_non_nullable
              as List<FavProgramModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavProgramListCopyWith<$Res>
    implements $FavProgramListCopyWith<$Res> {
  factory _$$_FavProgramListCopyWith(
          _$_FavProgramList value, $Res Function(_$_FavProgramList) then) =
      __$$_FavProgramListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<FavProgramModel> favouriteData});
}

/// @nodoc
class __$$_FavProgramListCopyWithImpl<$Res>
    extends _$FavProgramListCopyWithImpl<$Res, _$_FavProgramList>
    implements _$$_FavProgramListCopyWith<$Res> {
  __$$_FavProgramListCopyWithImpl(
      _$_FavProgramList _value, $Res Function(_$_FavProgramList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? favouriteData = null,
  }) {
    return _then(_$_FavProgramList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      favouriteData: null == favouriteData
          ? _value._favouriteData
          : favouriteData // ignore: cast_nullable_to_non_nullable
              as List<FavProgramModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavProgramList implements _FavProgramList {
  _$_FavProgramList(
      {required this.status,
      required final List<FavProgramModel> favouriteData})
      : _favouriteData = favouriteData;

  factory _$_FavProgramList.fromJson(Map<String, dynamic> json) =>
      _$$_FavProgramListFromJson(json);

  @override
  final bool status;
  final List<FavProgramModel> _favouriteData;
  @override
  List<FavProgramModel> get favouriteData {
    if (_favouriteData is EqualUnmodifiableListView) return _favouriteData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favouriteData);
  }

  @override
  String toString() {
    return 'FavProgramList(status: $status, favouriteData: $favouriteData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavProgramList &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._favouriteData, _favouriteData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_favouriteData));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavProgramListCopyWith<_$_FavProgramList> get copyWith =>
      __$$_FavProgramListCopyWithImpl<_$_FavProgramList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavProgramListToJson(
      this,
    );
  }
}

abstract class _FavProgramList implements FavProgramList {
  factory _FavProgramList(
      {required final bool status,
      required final List<FavProgramModel> favouriteData}) = _$_FavProgramList;

  factory _FavProgramList.fromJson(Map<String, dynamic> json) =
      _$_FavProgramList.fromJson;

  @override
  bool get status;
  @override
  List<FavProgramModel> get favouriteData;
  @override
  @JsonKey(ignore: true)
  _$$_FavProgramListCopyWith<_$_FavProgramList> get copyWith =>
      throw _privateConstructorUsedError;
}
