// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Form _$FormFromJson(Map<String, dynamic> json) {
  return _Form.fromJson(json);
}

/// @nodoc
mixin _$Form {
  String? get form_id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get updated_at => throw _privateConstructorUsedError;
  int? get is_deleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FormCopyWith<Form> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormCopyWith<$Res> {
  factory $FormCopyWith(Form value, $Res Function(Form) then) =
      _$FormCopyWithImpl<$Res, Form>;
  @useResult
  $Res call(
      {String? form_id,
      String? title,
      String? content,
      String? image,
      String? type,
      String? status,
      String? created_at,
      String? updated_at,
      int? is_deleted});
}

/// @nodoc
class _$FormCopyWithImpl<$Res, $Val extends Form>
    implements $FormCopyWith<$Res> {
  _$FormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form_id = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? image = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
  }) {
    return _then(_value.copyWith(
      form_id: freezed == form_id
          ? _value.form_id
          : form_id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as String?,
      is_deleted: freezed == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FormCopyWith<$Res> implements $FormCopyWith<$Res> {
  factory _$$_FormCopyWith(_$_Form value, $Res Function(_$_Form) then) =
      __$$_FormCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? form_id,
      String? title,
      String? content,
      String? image,
      String? type,
      String? status,
      String? created_at,
      String? updated_at,
      int? is_deleted});
}

/// @nodoc
class __$$_FormCopyWithImpl<$Res> extends _$FormCopyWithImpl<$Res, _$_Form>
    implements _$$_FormCopyWith<$Res> {
  __$$_FormCopyWithImpl(_$_Form _value, $Res Function(_$_Form) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form_id = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? image = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
  }) {
    return _then(_$_Form(
      form_id: freezed == form_id
          ? _value.form_id
          : form_id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as String?,
      is_deleted: freezed == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Form implements _Form {
  _$_Form(
      {required this.form_id,
      required this.title,
      required this.content,
      required this.image,
      required this.type,
      required this.status,
      required this.created_at,
      required this.updated_at,
      required this.is_deleted});

  factory _$_Form.fromJson(Map<String, dynamic> json) => _$$_FormFromJson(json);

  @override
  final String? form_id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? image;
  @override
  final String? type;
  @override
  final String? status;
  @override
  final String? created_at;
  @override
  final String? updated_at;
  @override
  final int? is_deleted;

  @override
  String toString() {
    return 'Form(form_id: $form_id, title: $title, content: $content, image: $image, type: $type, status: $status, created_at: $created_at, updated_at: $updated_at, is_deleted: $is_deleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Form &&
            (identical(other.form_id, form_id) || other.form_id == form_id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, form_id, title, content, image,
      type, status, created_at, updated_at, is_deleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FormCopyWith<_$_Form> get copyWith =>
      __$$_FormCopyWithImpl<_$_Form>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FormToJson(
      this,
    );
  }
}

abstract class _Form implements Form {
  factory _Form(
      {required final String? form_id,
      required final String? title,
      required final String? content,
      required final String? image,
      required final String? type,
      required final String? status,
      required final String? created_at,
      required final String? updated_at,
      required final int? is_deleted}) = _$_Form;

  factory _Form.fromJson(Map<String, dynamic> json) = _$_Form.fromJson;

  @override
  String? get form_id;
  @override
  String? get title;
  @override
  String? get content;
  @override
  String? get image;
  @override
  String? get type;
  @override
  String? get status;
  @override
  String? get created_at;
  @override
  String? get updated_at;
  @override
  int? get is_deleted;
  @override
  @JsonKey(ignore: true)
  _$$_FormCopyWith<_$_Form> get copyWith => throw _privateConstructorUsedError;
}
