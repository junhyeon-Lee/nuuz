// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'formlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FormList _$FormListFromJson(Map<String, dynamic> json) {
  return _FormList.fromJson(json);
}

/// @nodoc
mixin _$FormList {
  bool? get status => throw _privateConstructorUsedError;
  TermsList? get resultData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FormListCopyWith<FormList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormListCopyWith<$Res> {
  factory $FormListCopyWith(FormList value, $Res Function(FormList) then) =
      _$FormListCopyWithImpl<$Res, FormList>;
  @useResult
  $Res call({bool? status, TermsList? resultData});

  $TermsListCopyWith<$Res>? get resultData;
}

/// @nodoc
class _$FormListCopyWithImpl<$Res, $Val extends FormList>
    implements $FormListCopyWith<$Res> {
  _$FormListCopyWithImpl(this._value, this._then);

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
              as TermsList?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TermsListCopyWith<$Res>? get resultData {
    if (_value.resultData == null) {
      return null;
    }

    return $TermsListCopyWith<$Res>(_value.resultData!, (value) {
      return _then(_value.copyWith(resultData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FormListCopyWith<$Res> implements $FormListCopyWith<$Res> {
  factory _$$_FormListCopyWith(
          _$_FormList value, $Res Function(_$_FormList) then) =
      __$$_FormListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? status, TermsList? resultData});

  @override
  $TermsListCopyWith<$Res>? get resultData;
}

/// @nodoc
class __$$_FormListCopyWithImpl<$Res>
    extends _$FormListCopyWithImpl<$Res, _$_FormList>
    implements _$$_FormListCopyWith<$Res> {
  __$$_FormListCopyWithImpl(
      _$_FormList _value, $Res Function(_$_FormList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? resultData = freezed,
  }) {
    return _then(_$_FormList(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      resultData: freezed == resultData
          ? _value.resultData
          : resultData // ignore: cast_nullable_to_non_nullable
              as TermsList?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FormList implements _FormList {
  _$_FormList({required this.status, this.resultData});

  factory _$_FormList.fromJson(Map<String, dynamic> json) =>
      _$$_FormListFromJson(json);

  @override
  final bool? status;
  @override
  final TermsList? resultData;

  @override
  String toString() {
    return 'FormList(status: $status, resultData: $resultData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FormList &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resultData, resultData) ||
                other.resultData == resultData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, resultData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FormListCopyWith<_$_FormList> get copyWith =>
      __$$_FormListCopyWithImpl<_$_FormList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FormListToJson(
      this,
    );
  }
}

abstract class _FormList implements FormList {
  factory _FormList(
      {required final bool? status, final TermsList? resultData}) = _$_FormList;

  factory _FormList.fromJson(Map<String, dynamic> json) = _$_FormList.fromJson;

  @override
  bool? get status;
  @override
  TermsList? get resultData;
  @override
  @JsonKey(ignore: true)
  _$$_FormListCopyWith<_$_FormList> get copyWith =>
      throw _privateConstructorUsedError;
}
