// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programguide.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProgramGuide _$ProgramGuideFromJson(Map<String, dynamic> json) {
  return _ProgramGuide.fromJson(json);
}

/// @nodoc
mixin _$ProgramGuide {
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get cartridge => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramGuideCopyWith<ProgramGuide> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramGuideCopyWith<$Res> {
  factory $ProgramGuideCopyWith(
          ProgramGuide value, $Res Function(ProgramGuide) then) =
      _$ProgramGuideCopyWithImpl<$Res, ProgramGuide>;
  @useResult
  $Res call(
      {String? name,
      String? image,
      String? title,
      String? cartridge,
      String? description});
}

/// @nodoc
class _$ProgramGuideCopyWithImpl<$Res, $Val extends ProgramGuide>
    implements $ProgramGuideCopyWith<$Res> {
  _$ProgramGuideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
    Object? title = freezed,
    Object? cartridge = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      cartridge: freezed == cartridge
          ? _value.cartridge
          : cartridge // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgramGuideCopyWith<$Res>
    implements $ProgramGuideCopyWith<$Res> {
  factory _$$_ProgramGuideCopyWith(
          _$_ProgramGuide value, $Res Function(_$_ProgramGuide) then) =
      __$$_ProgramGuideCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? image,
      String? title,
      String? cartridge,
      String? description});
}

/// @nodoc
class __$$_ProgramGuideCopyWithImpl<$Res>
    extends _$ProgramGuideCopyWithImpl<$Res, _$_ProgramGuide>
    implements _$$_ProgramGuideCopyWith<$Res> {
  __$$_ProgramGuideCopyWithImpl(
      _$_ProgramGuide _value, $Res Function(_$_ProgramGuide) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
    Object? title = freezed,
    Object? cartridge = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_ProgramGuide(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      cartridge: freezed == cartridge
          ? _value.cartridge
          : cartridge // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProgramGuide implements _ProgramGuide {
  _$_ProgramGuide(
      {required this.name,
      required this.image,
      required this.title,
      required this.cartridge,
      required this.description});

  factory _$_ProgramGuide.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramGuideFromJson(json);

  @override
  final String? name;
  @override
  final String? image;
  @override
  final String? title;
  @override
  final String? cartridge;
  @override
  final String? description;

  @override
  String toString() {
    return 'ProgramGuide(name: $name, image: $image, title: $title, cartridge: $cartridge, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgramGuide &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.cartridge, cartridge) ||
                other.cartridge == cartridge) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, image, title, cartridge, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgramGuideCopyWith<_$_ProgramGuide> get copyWith =>
      __$$_ProgramGuideCopyWithImpl<_$_ProgramGuide>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramGuideToJson(
      this,
    );
  }
}

abstract class _ProgramGuide implements ProgramGuide {
  factory _ProgramGuide(
      {required final String? name,
      required final String? image,
      required final String? title,
      required final String? cartridge,
      required final String? description}) = _$_ProgramGuide;

  factory _ProgramGuide.fromJson(Map<String, dynamic> json) =
      _$_ProgramGuide.fromJson;

  @override
  String? get name;
  @override
  String? get image;
  @override
  String? get title;
  @override
  String? get cartridge;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramGuideCopyWith<_$_ProgramGuide> get copyWith =>
      throw _privateConstructorUsedError;
}
