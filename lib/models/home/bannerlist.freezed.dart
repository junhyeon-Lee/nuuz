// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bannerlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BannerList _$BannerListFromJson(Map<String, dynamic> json) {
  return _BannerList.fromJson(json);
}

/// @nodoc
mixin _$BannerList {
  bool get status => throw _privateConstructorUsedError;
  List<Banner>? get resultData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BannerListCopyWith<BannerList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BannerListCopyWith<$Res> {
  factory $BannerListCopyWith(
          BannerList value, $Res Function(BannerList) then) =
      _$BannerListCopyWithImpl<$Res, BannerList>;
  @useResult
  $Res call({bool status, List<Banner>? resultData});
}

/// @nodoc
class _$BannerListCopyWithImpl<$Res, $Val extends BannerList>
    implements $BannerListCopyWith<$Res> {
  _$BannerListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? resultData = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      resultData: freezed == resultData
          ? _value.resultData
          : resultData // ignore: cast_nullable_to_non_nullable
              as List<Banner>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BannerListCopyWith<$Res>
    implements $BannerListCopyWith<$Res> {
  factory _$$_BannerListCopyWith(
          _$_BannerList value, $Res Function(_$_BannerList) then) =
      __$$_BannerListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<Banner>? resultData});
}

/// @nodoc
class __$$_BannerListCopyWithImpl<$Res>
    extends _$BannerListCopyWithImpl<$Res, _$_BannerList>
    implements _$$_BannerListCopyWith<$Res> {
  __$$_BannerListCopyWithImpl(
      _$_BannerList _value, $Res Function(_$_BannerList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? resultData = freezed,
  }) {
    return _then(_$_BannerList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      resultData: freezed == resultData
          ? _value._resultData
          : resultData // ignore: cast_nullable_to_non_nullable
              as List<Banner>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BannerList implements _BannerList {
  _$_BannerList({required this.status, required final List<Banner>? resultData})
      : _resultData = resultData;

  factory _$_BannerList.fromJson(Map<String, dynamic> json) =>
      _$$_BannerListFromJson(json);

  @override
  final bool status;
  final List<Banner>? _resultData;
  @override
  List<Banner>? get resultData {
    final value = _resultData;
    if (value == null) return null;
    if (_resultData is EqualUnmodifiableListView) return _resultData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BannerList(status: $status, resultData: $resultData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BannerList &&
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
  _$$_BannerListCopyWith<_$_BannerList> get copyWith =>
      __$$_BannerListCopyWithImpl<_$_BannerList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BannerListToJson(
      this,
    );
  }
}

abstract class _BannerList implements BannerList {
  factory _BannerList(
      {required final bool status,
      required final List<Banner>? resultData}) = _$_BannerList;

  factory _BannerList.fromJson(Map<String, dynamic> json) =
      _$_BannerList.fromJson;

  @override
  bool get status;
  @override
  List<Banner>? get resultData;
  @override
  @JsonKey(ignore: true)
  _$$_BannerListCopyWith<_$_BannerList> get copyWith =>
      throw _privateConstructorUsedError;
}
