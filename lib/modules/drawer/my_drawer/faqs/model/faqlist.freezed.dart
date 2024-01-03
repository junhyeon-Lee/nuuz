// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faqlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FaqList _$FaqListFromJson(Map<String, dynamic> json) {
  return _FaqList.fromJson(json);
}

/// @nodoc
mixin _$FaqList {
  bool get status => throw _privateConstructorUsedError;
  List<FaqModel> get resultData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaqListCopyWith<FaqList> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqListCopyWith<$Res> {
  factory $FaqListCopyWith(FaqList value, $Res Function(FaqList) then) =
      _$FaqListCopyWithImpl<$Res, FaqList>;
  @useResult
  $Res call({bool status, List<FaqModel> resultData});
}

/// @nodoc
class _$FaqListCopyWithImpl<$Res, $Val extends FaqList>
    implements $FaqListCopyWith<$Res> {
  _$FaqListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? resultData = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      resultData: null == resultData
          ? _value.resultData
          : resultData // ignore: cast_nullable_to_non_nullable
              as List<FaqModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FaqListCopyWith<$Res> implements $FaqListCopyWith<$Res> {
  factory _$$_FaqListCopyWith(
          _$_FaqList value, $Res Function(_$_FaqList) then) =
      __$$_FaqListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<FaqModel> resultData});
}

/// @nodoc
class __$$_FaqListCopyWithImpl<$Res>
    extends _$FaqListCopyWithImpl<$Res, _$_FaqList>
    implements _$$_FaqListCopyWith<$Res> {
  __$$_FaqListCopyWithImpl(_$_FaqList _value, $Res Function(_$_FaqList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? resultData = null,
  }) {
    return _then(_$_FaqList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      resultData: null == resultData
          ? _value._resultData
          : resultData // ignore: cast_nullable_to_non_nullable
              as List<FaqModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FaqList implements _FaqList {
  _$_FaqList({required this.status, required final List<FaqModel> resultData})
      : _resultData = resultData;

  factory _$_FaqList.fromJson(Map<String, dynamic> json) =>
      _$$_FaqListFromJson(json);

  @override
  final bool status;
  final List<FaqModel> _resultData;
  @override
  List<FaqModel> get resultData {
    if (_resultData is EqualUnmodifiableListView) return _resultData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resultData);
  }

  @override
  String toString() {
    return 'FaqList(status: $status, resultData: $resultData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FaqList &&
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
  _$$_FaqListCopyWith<_$_FaqList> get copyWith =>
      __$$_FaqListCopyWithImpl<_$_FaqList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FaqListToJson(
      this,
    );
  }
}

abstract class _FaqList implements FaqList {
  factory _FaqList(
      {required final bool status,
      required final List<FaqModel> resultData}) = _$_FaqList;

  factory _FaqList.fromJson(Map<String, dynamic> json) = _$_FaqList.fromJson;

  @override
  bool get status;
  @override
  List<FaqModel> get resultData;
  @override
  @JsonKey(ignore: true)
  _$$_FaqListCopyWith<_$_FaqList> get copyWith =>
      throw _privateConstructorUsedError;
}
