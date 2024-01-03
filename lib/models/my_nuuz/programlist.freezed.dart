// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProgramList _$ProgramListFromJson(Map<String, dynamic> json) {
  return _ProgramList.fromJson(json);
}

/// @nodoc
mixin _$ProgramList {
  bool get status => throw _privateConstructorUsedError;
  List<Program>? get careProgram => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramListCopyWith<ProgramList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramListCopyWith<$Res> {
  factory $ProgramListCopyWith(
          ProgramList value, $Res Function(ProgramList) then) =
      _$ProgramListCopyWithImpl<$Res, ProgramList>;
  @useResult
  $Res call({bool status, List<Program>? careProgram});
}

/// @nodoc
class _$ProgramListCopyWithImpl<$Res, $Val extends ProgramList>
    implements $ProgramListCopyWith<$Res> {
  _$ProgramListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? careProgram = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      careProgram: freezed == careProgram
          ? _value.careProgram
          : careProgram // ignore: cast_nullable_to_non_nullable
              as List<Program>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgramListCopyWith<$Res>
    implements $ProgramListCopyWith<$Res> {
  factory _$$_ProgramListCopyWith(
          _$_ProgramList value, $Res Function(_$_ProgramList) then) =
      __$$_ProgramListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, List<Program>? careProgram});
}

/// @nodoc
class __$$_ProgramListCopyWithImpl<$Res>
    extends _$ProgramListCopyWithImpl<$Res, _$_ProgramList>
    implements _$$_ProgramListCopyWith<$Res> {
  __$$_ProgramListCopyWithImpl(
      _$_ProgramList _value, $Res Function(_$_ProgramList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? careProgram = freezed,
  }) {
    return _then(_$_ProgramList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      careProgram: freezed == careProgram
          ? _value._careProgram
          : careProgram // ignore: cast_nullable_to_non_nullable
              as List<Program>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProgramList implements _ProgramList {
  _$_ProgramList(
      {required this.status, required final List<Program>? careProgram})
      : _careProgram = careProgram;

  factory _$_ProgramList.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramListFromJson(json);

  @override
  final bool status;
  final List<Program>? _careProgram;
  @override
  List<Program>? get careProgram {
    final value = _careProgram;
    if (value == null) return null;
    if (_careProgram is EqualUnmodifiableListView) return _careProgram;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ProgramList(status: $status, careProgram: $careProgram)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgramList &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._careProgram, _careProgram));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_careProgram));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgramListCopyWith<_$_ProgramList> get copyWith =>
      __$$_ProgramListCopyWithImpl<_$_ProgramList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramListToJson(
      this,
    );
  }
}

abstract class _ProgramList implements ProgramList {
  factory _ProgramList(
      {required final bool status,
      required final List<Program>? careProgram}) = _$_ProgramList;

  factory _ProgramList.fromJson(Map<String, dynamic> json) =
      _$_ProgramList.fromJson;

  @override
  bool get status;
  @override
  List<Program>? get careProgram;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramListCopyWith<_$_ProgramList> get copyWith =>
      throw _privateConstructorUsedError;
}
