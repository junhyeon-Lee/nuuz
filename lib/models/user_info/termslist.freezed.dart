// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'termslist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TermsList _$TermsListFromJson(Map<String, dynamic> json) {
  return _TermsList.fromJson(json);
}

/// @nodoc
mixin _$TermsList {
  List<Form>? get form => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermsListCopyWith<TermsList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsListCopyWith<$Res> {
  factory $TermsListCopyWith(TermsList value, $Res Function(TermsList) then) =
      _$TermsListCopyWithImpl<$Res, TermsList>;
  @useResult
  $Res call({List<Form>? form, int? count});
}

/// @nodoc
class _$TermsListCopyWithImpl<$Res, $Val extends TermsList>
    implements $TermsListCopyWith<$Res> {
  _$TermsListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      form: freezed == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as List<Form>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TermsListCopyWith<$Res> implements $TermsListCopyWith<$Res> {
  factory _$$_TermsListCopyWith(
          _$_TermsList value, $Res Function(_$_TermsList) then) =
      __$$_TermsListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Form>? form, int? count});
}

/// @nodoc
class __$$_TermsListCopyWithImpl<$Res>
    extends _$TermsListCopyWithImpl<$Res, _$_TermsList>
    implements _$$_TermsListCopyWith<$Res> {
  __$$_TermsListCopyWithImpl(
      _$_TermsList _value, $Res Function(_$_TermsList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = freezed,
    Object? count = freezed,
  }) {
    return _then(_$_TermsList(
      form: freezed == form
          ? _value._form
          : form // ignore: cast_nullable_to_non_nullable
              as List<Form>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TermsList implements _TermsList {
  _$_TermsList({required final List<Form>? form, required this.count})
      : _form = form;

  factory _$_TermsList.fromJson(Map<String, dynamic> json) =>
      _$$_TermsListFromJson(json);

  final List<Form>? _form;
  @override
  List<Form>? get form {
    final value = _form;
    if (value == null) return null;
    if (_form is EqualUnmodifiableListView) return _form;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? count;

  @override
  String toString() {
    return 'TermsList(form: $form, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TermsList &&
            const DeepCollectionEquality().equals(other._form, _form) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_form), count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TermsListCopyWith<_$_TermsList> get copyWith =>
      __$$_TermsListCopyWithImpl<_$_TermsList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TermsListToJson(
      this,
    );
  }
}

abstract class _TermsList implements TermsList {
  factory _TermsList(
      {required final List<Form>? form,
      required final int? count}) = _$_TermsList;

  factory _TermsList.fromJson(Map<String, dynamic> json) =
      _$_TermsList.fromJson;

  @override
  List<Form>? get form;
  @override
  int? get count;
  @override
  @JsonKey(ignore: true)
  _$$_TermsListCopyWith<_$_TermsList> get copyWith =>
      throw _privateConstructorUsedError;
}
