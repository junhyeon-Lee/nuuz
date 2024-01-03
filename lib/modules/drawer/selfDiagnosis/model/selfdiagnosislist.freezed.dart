// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selfdiagnosislist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SelfDiagnosisList _$SelfDiagnosisListFromJson(Map<String, dynamic> json) {
  return _SelfDiagnosisList.fromJson(json);
}

/// @nodoc
mixin _$SelfDiagnosisList {
  bool get status => throw _privateConstructorUsedError;
  List<SelfDiagnosisModel> get selfDiagnosis =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SelfDiagnosisListCopyWith<SelfDiagnosisList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelfDiagnosisListCopyWith<$Res> {
  factory $SelfDiagnosisListCopyWith(
          SelfDiagnosisList value, $Res Function(SelfDiagnosisList) then) =
      _$SelfDiagnosisListCopyWithImpl<$Res, SelfDiagnosisList>;
  @useResult
  $Res call({bool status, List<SelfDiagnosisModel> selfDiagnosis});
}

/// @nodoc
class _$SelfDiagnosisListCopyWithImpl<$Res, $Val extends SelfDiagnosisList>
    implements $SelfDiagnosisListCopyWith<$Res> {
  _$SelfDiagnosisListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? selfDiagnosis = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      selfDiagnosis: null == selfDiagnosis
          ? _value.selfDiagnosis
          : selfDiagnosis // ignore: cast_nullable_to_non_nullable
              as List<SelfDiagnosisModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelfDiagnosisListCopyWith<$Res>
    implements $SelfDiagnosisListCopyWith<$Res> {
  factory _$$_SelfDiagnosisListCopyWith(_$_SelfDiagnosisList value,
          $Res Function(_$_SelfDiagnosisList) then) =
      __$$_SelfDiagnosisListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<SelfDiagnosisModel> selfDiagnosis});
}

/// @nodoc
class __$$_SelfDiagnosisListCopyWithImpl<$Res>
    extends _$SelfDiagnosisListCopyWithImpl<$Res, _$_SelfDiagnosisList>
    implements _$$_SelfDiagnosisListCopyWith<$Res> {
  __$$_SelfDiagnosisListCopyWithImpl(
      _$_SelfDiagnosisList _value, $Res Function(_$_SelfDiagnosisList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? selfDiagnosis = null,
  }) {
    return _then(_$_SelfDiagnosisList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      selfDiagnosis: null == selfDiagnosis
          ? _value._selfDiagnosis
          : selfDiagnosis // ignore: cast_nullable_to_non_nullable
              as List<SelfDiagnosisModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SelfDiagnosisList implements _SelfDiagnosisList {
  _$_SelfDiagnosisList(
      {required this.status,
      required final List<SelfDiagnosisModel> selfDiagnosis})
      : _selfDiagnosis = selfDiagnosis;

  factory _$_SelfDiagnosisList.fromJson(Map<String, dynamic> json) =>
      _$$_SelfDiagnosisListFromJson(json);

  @override
  final bool status;
  final List<SelfDiagnosisModel> _selfDiagnosis;
  @override
  List<SelfDiagnosisModel> get selfDiagnosis {
    if (_selfDiagnosis is EqualUnmodifiableListView) return _selfDiagnosis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selfDiagnosis);
  }

  @override
  String toString() {
    return 'SelfDiagnosisList(status: $status, selfDiagnosis: $selfDiagnosis)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelfDiagnosisList &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._selfDiagnosis, _selfDiagnosis));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_selfDiagnosis));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelfDiagnosisListCopyWith<_$_SelfDiagnosisList> get copyWith =>
      __$$_SelfDiagnosisListCopyWithImpl<_$_SelfDiagnosisList>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SelfDiagnosisListToJson(
      this,
    );
  }
}

abstract class _SelfDiagnosisList implements SelfDiagnosisList {
  factory _SelfDiagnosisList(
          {required final bool status,
          required final List<SelfDiagnosisModel> selfDiagnosis}) =
      _$_SelfDiagnosisList;

  factory _SelfDiagnosisList.fromJson(Map<String, dynamic> json) =
      _$_SelfDiagnosisList.fromJson;

  @override
  bool get status;
  @override
  List<SelfDiagnosisModel> get selfDiagnosis;
  @override
  @JsonKey(ignore: true)
  _$$_SelfDiagnosisListCopyWith<_$_SelfDiagnosisList> get copyWith =>
      throw _privateConstructorUsedError;
}
