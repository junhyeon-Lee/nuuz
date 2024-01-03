// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'terms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Terms _$TermsFromJson(Map<String, dynamic> json) {
  return _Terms.fromJson(json);
}

/// @nodoc
mixin _$Terms {
  String? get terms => throw _privateConstructorUsedError;
  String? get privacy => throw _privateConstructorUsedError;
  String? get marketing => throw _privateConstructorUsedError;
  String? get caution => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermsCopyWith<Terms> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsCopyWith<$Res> {
  factory $TermsCopyWith(Terms value, $Res Function(Terms) then) =
      _$TermsCopyWithImpl<$Res, Terms>;
  @useResult
  $Res call(
      {String? terms, String? privacy, String? marketing, String? caution});
}

/// @nodoc
class _$TermsCopyWithImpl<$Res, $Val extends Terms>
    implements $TermsCopyWith<$Res> {
  _$TermsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? terms = freezed,
    Object? privacy = freezed,
    Object? marketing = freezed,
    Object? caution = freezed,
  }) {
    return _then(_value.copyWith(
      terms: freezed == terms
          ? _value.terms
          : terms // ignore: cast_nullable_to_non_nullable
              as String?,
      privacy: freezed == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      marketing: freezed == marketing
          ? _value.marketing
          : marketing // ignore: cast_nullable_to_non_nullable
              as String?,
      caution: freezed == caution
          ? _value.caution
          : caution // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TermsCopyWith<$Res> implements $TermsCopyWith<$Res> {
  factory _$$_TermsCopyWith(_$_Terms value, $Res Function(_$_Terms) then) =
      __$$_TermsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? terms, String? privacy, String? marketing, String? caution});
}

/// @nodoc
class __$$_TermsCopyWithImpl<$Res> extends _$TermsCopyWithImpl<$Res, _$_Terms>
    implements _$$_TermsCopyWith<$Res> {
  __$$_TermsCopyWithImpl(_$_Terms _value, $Res Function(_$_Terms) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? terms = freezed,
    Object? privacy = freezed,
    Object? marketing = freezed,
    Object? caution = freezed,
  }) {
    return _then(_$_Terms(
      terms: freezed == terms
          ? _value.terms
          : terms // ignore: cast_nullable_to_non_nullable
              as String?,
      privacy: freezed == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      marketing: freezed == marketing
          ? _value.marketing
          : marketing // ignore: cast_nullable_to_non_nullable
              as String?,
      caution: freezed == caution
          ? _value.caution
          : caution // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Terms implements _Terms {
  _$_Terms(
      {required this.terms,
      required this.privacy,
      required this.marketing,
      required this.caution});

  factory _$_Terms.fromJson(Map<String, dynamic> json) =>
      _$$_TermsFromJson(json);

  @override
  final String? terms;
  @override
  final String? privacy;
  @override
  final String? marketing;
  @override
  final String? caution;

  @override
  String toString() {
    return 'Terms(terms: $terms, privacy: $privacy, marketing: $marketing, caution: $caution)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Terms &&
            (identical(other.terms, terms) || other.terms == terms) &&
            (identical(other.privacy, privacy) || other.privacy == privacy) &&
            (identical(other.marketing, marketing) ||
                other.marketing == marketing) &&
            (identical(other.caution, caution) || other.caution == caution));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, terms, privacy, marketing, caution);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TermsCopyWith<_$_Terms> get copyWith =>
      __$$_TermsCopyWithImpl<_$_Terms>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TermsToJson(
      this,
    );
  }
}

abstract class _Terms implements Terms {
  factory _Terms(
      {required final String? terms,
      required final String? privacy,
      required final String? marketing,
      required final String? caution}) = _$_Terms;

  factory _Terms.fromJson(Map<String, dynamic> json) = _$_Terms.fromJson;

  @override
  String? get terms;
  @override
  String? get privacy;
  @override
  String? get marketing;
  @override
  String? get caution;
  @override
  @JsonKey(ignore: true)
  _$$_TermsCopyWith<_$_Terms> get copyWith =>
      throw _privateConstructorUsedError;
}
