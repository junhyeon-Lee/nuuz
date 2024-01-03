// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return _Program.fromJson(json);
}

/// @nodoc
mixin _$Program {
  @JsonKey(name: "care_program_id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "care_program_name")
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: "routin_days")
  int? get routineDays => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  List<Subprogram>? get subprograms => throw _privateConstructorUsedError;
  List<String>? get product_id_array => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res, Program>;
  @useResult
  $Res call(
      {@JsonKey(name: "care_program_id") int id,
      @JsonKey(name: "care_program_name") String name,
      String? description,
      @JsonKey(name: "routin_days") int? routineDays,
      String? image,
      List<Subprogram>? subprograms,
      List<String>? product_id_array});
}

/// @nodoc
class _$ProgramCopyWithImpl<$Res, $Val extends Program>
    implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? routineDays = freezed,
    Object? image = freezed,
    Object? subprograms = freezed,
    Object? product_id_array = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      routineDays: freezed == routineDays
          ? _value.routineDays
          : routineDays // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      subprograms: freezed == subprograms
          ? _value.subprograms
          : subprograms // ignore: cast_nullable_to_non_nullable
              as List<Subprogram>?,
      product_id_array: freezed == product_id_array
          ? _value.product_id_array
          : product_id_array // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$$_ProgramCopyWith(
          _$_Program value, $Res Function(_$_Program) then) =
      __$$_ProgramCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "care_program_id") int id,
      @JsonKey(name: "care_program_name") String name,
      String? description,
      @JsonKey(name: "routin_days") int? routineDays,
      String? image,
      List<Subprogram>? subprograms,
      List<String>? product_id_array});
}

/// @nodoc
class __$$_ProgramCopyWithImpl<$Res>
    extends _$ProgramCopyWithImpl<$Res, _$_Program>
    implements _$$_ProgramCopyWith<$Res> {
  __$$_ProgramCopyWithImpl(_$_Program _value, $Res Function(_$_Program) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? routineDays = freezed,
    Object? image = freezed,
    Object? subprograms = freezed,
    Object? product_id_array = freezed,
  }) {
    return _then(_$_Program(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      routineDays: freezed == routineDays
          ? _value.routineDays
          : routineDays // ignore: cast_nullable_to_non_nullable
              as int?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      subprograms: freezed == subprograms
          ? _value._subprograms
          : subprograms // ignore: cast_nullable_to_non_nullable
              as List<Subprogram>?,
      product_id_array: freezed == product_id_array
          ? _value._product_id_array
          : product_id_array // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Program implements _Program {
  _$_Program(
      {@JsonKey(name: "care_program_id") required this.id,
      @JsonKey(name: "care_program_name") required this.name,
      required this.description,
      @JsonKey(name: "routin_days") required this.routineDays,
      required this.image,
      required final List<Subprogram>? subprograms,
      final List<String>? product_id_array})
      : _subprograms = subprograms,
        _product_id_array = product_id_array;

  factory _$_Program.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramFromJson(json);

  @override
  @JsonKey(name: "care_program_id")
  final int id;
  @override
  @JsonKey(name: "care_program_name")
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: "routin_days")
  final int? routineDays;
  @override
  final String? image;
  final List<Subprogram>? _subprograms;
  @override
  List<Subprogram>? get subprograms {
    final value = _subprograms;
    if (value == null) return null;
    if (_subprograms is EqualUnmodifiableListView) return _subprograms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _product_id_array;
  @override
  List<String>? get product_id_array {
    final value = _product_id_array;
    if (value == null) return null;
    if (_product_id_array is EqualUnmodifiableListView)
      return _product_id_array;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Program(id: $id, name: $name, description: $description, routineDays: $routineDays, image: $image, subprograms: $subprograms, product_id_array: $product_id_array)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Program &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.routineDays, routineDays) ||
                other.routineDays == routineDays) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality()
                .equals(other._subprograms, _subprograms) &&
            const DeepCollectionEquality()
                .equals(other._product_id_array, _product_id_array));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      routineDays,
      image,
      const DeepCollectionEquality().hash(_subprograms),
      const DeepCollectionEquality().hash(_product_id_array));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      __$$_ProgramCopyWithImpl<_$_Program>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramToJson(
      this,
    );
  }
}

abstract class _Program implements Program {
  factory _Program(
      {@JsonKey(name: "care_program_id") required final int id,
      @JsonKey(name: "care_program_name") required final String name,
      required final String? description,
      @JsonKey(name: "routin_days") required final int? routineDays,
      required final String? image,
      required final List<Subprogram>? subprograms,
      final List<String>? product_id_array}) = _$_Program;

  factory _Program.fromJson(Map<String, dynamic> json) = _$_Program.fromJson;

  @override
  @JsonKey(name: "care_program_id")
  int get id;
  @override
  @JsonKey(name: "care_program_name")
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: "routin_days")
  int? get routineDays;
  @override
  String? get image;
  @override
  List<Subprogram>? get subprograms;
  @override
  List<String>? get product_id_array;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      throw _privateConstructorUsedError;
}
