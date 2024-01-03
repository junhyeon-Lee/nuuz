// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resultprogram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResultProgram _$ResultProgramFromJson(Map<String, dynamic> json) {
  return _ResultProgram.fromJson(json);
}

/// @nodoc
mixin _$ResultProgram {
  String? get description => throw _privateConstructorUsedError;
  int? get progaram_id => throw _privateConstructorUsedError;
  String? get care_program_name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResultProgramCopyWith<ResultProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultProgramCopyWith<$Res> {
  factory $ResultProgramCopyWith(
          ResultProgram value, $Res Function(ResultProgram) then) =
      _$ResultProgramCopyWithImpl<$Res, ResultProgram>;
  @useResult
  $Res call({String? description, int? progaram_id, String? care_program_name});
}

/// @nodoc
class _$ResultProgramCopyWithImpl<$Res, $Val extends ResultProgram>
    implements $ResultProgramCopyWith<$Res> {
  _$ResultProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? progaram_id = freezed,
    Object? care_program_name = freezed,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      progaram_id: freezed == progaram_id
          ? _value.progaram_id
          : progaram_id // ignore: cast_nullable_to_non_nullable
              as int?,
      care_program_name: freezed == care_program_name
          ? _value.care_program_name
          : care_program_name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResultProgramCopyWith<$Res>
    implements $ResultProgramCopyWith<$Res> {
  factory _$$_ResultProgramCopyWith(
          _$_ResultProgram value, $Res Function(_$_ResultProgram) then) =
      __$$_ResultProgramCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? description, int? progaram_id, String? care_program_name});
}

/// @nodoc
class __$$_ResultProgramCopyWithImpl<$Res>
    extends _$ResultProgramCopyWithImpl<$Res, _$_ResultProgram>
    implements _$$_ResultProgramCopyWith<$Res> {
  __$$_ResultProgramCopyWithImpl(
      _$_ResultProgram _value, $Res Function(_$_ResultProgram) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? progaram_id = freezed,
    Object? care_program_name = freezed,
  }) {
    return _then(_$_ResultProgram(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      progaram_id: freezed == progaram_id
          ? _value.progaram_id
          : progaram_id // ignore: cast_nullable_to_non_nullable
              as int?,
      care_program_name: freezed == care_program_name
          ? _value.care_program_name
          : care_program_name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ResultProgram implements _ResultProgram {
  _$_ResultProgram(
      {required this.description,
      required this.progaram_id,
      required this.care_program_name});

  factory _$_ResultProgram.fromJson(Map<String, dynamic> json) =>
      _$$_ResultProgramFromJson(json);

  @override
  final String? description;
  @override
  final int? progaram_id;
  @override
  final String? care_program_name;

  @override
  String toString() {
    return 'ResultProgram(description: $description, progaram_id: $progaram_id, care_program_name: $care_program_name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResultProgram &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.progaram_id, progaram_id) ||
                other.progaram_id == progaram_id) &&
            (identical(other.care_program_name, care_program_name) ||
                other.care_program_name == care_program_name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, description, progaram_id, care_program_name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultProgramCopyWith<_$_ResultProgram> get copyWith =>
      __$$_ResultProgramCopyWithImpl<_$_ResultProgram>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResultProgramToJson(
      this,
    );
  }
}

abstract class _ResultProgram implements ResultProgram {
  factory _ResultProgram(
      {required final String? description,
      required final int? progaram_id,
      required final String? care_program_name}) = _$_ResultProgram;

  factory _ResultProgram.fromJson(Map<String, dynamic> json) =
      _$_ResultProgram.fromJson;

  @override
  String? get description;
  @override
  int? get progaram_id;
  @override
  String? get care_program_name;
  @override
  @JsonKey(ignore: true)
  _$$_ResultProgramCopyWith<_$_ResultProgram> get copyWith =>
      throw _privateConstructorUsedError;
}
