// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) {
  return _FaqModel.fromJson(json);
}

/// @nodoc
mixin _$FaqModel {
  String? get faq_id => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get title_text => throw _privateConstructorUsedError;
  String? get content_text => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  int? get is_deleted => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get updated_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaqModelCopyWith<FaqModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqModelCopyWith<$Res> {
  factory $FaqModelCopyWith(FaqModel value, $Res Function(FaqModel) then) =
      _$FaqModelCopyWithImpl<$Res, FaqModel>;
  @useResult
  $Res call(
      {String? faq_id,
      String? category,
      String? title_text,
      String? content_text,
      String? status,
      int? is_deleted,
      String? created_at,
      String? updated_at});
}

/// @nodoc
class _$FaqModelCopyWithImpl<$Res, $Val extends FaqModel>
    implements $FaqModelCopyWith<$Res> {
  _$FaqModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faq_id = freezed,
    Object? category = freezed,
    Object? title_text = freezed,
    Object? content_text = freezed,
    Object? status = freezed,
    Object? is_deleted = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_value.copyWith(
      faq_id: freezed == faq_id
          ? _value.faq_id
          : faq_id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      title_text: freezed == title_text
          ? _value.title_text
          : title_text // ignore: cast_nullable_to_non_nullable
              as String?,
      content_text: freezed == content_text
          ? _value.content_text
          : content_text // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      is_deleted: freezed == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FaqModelCopyWith<$Res> implements $FaqModelCopyWith<$Res> {
  factory _$$_FaqModelCopyWith(
          _$_FaqModel value, $Res Function(_$_FaqModel) then) =
      __$$_FaqModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? faq_id,
      String? category,
      String? title_text,
      String? content_text,
      String? status,
      int? is_deleted,
      String? created_at,
      String? updated_at});
}

/// @nodoc
class __$$_FaqModelCopyWithImpl<$Res>
    extends _$FaqModelCopyWithImpl<$Res, _$_FaqModel>
    implements _$$_FaqModelCopyWith<$Res> {
  __$$_FaqModelCopyWithImpl(
      _$_FaqModel _value, $Res Function(_$_FaqModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faq_id = freezed,
    Object? category = freezed,
    Object? title_text = freezed,
    Object? content_text = freezed,
    Object? status = freezed,
    Object? is_deleted = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$_FaqModel(
      faq_id: freezed == faq_id
          ? _value.faq_id
          : faq_id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      title_text: freezed == title_text
          ? _value.title_text
          : title_text // ignore: cast_nullable_to_non_nullable
              as String?,
      content_text: freezed == content_text
          ? _value.content_text
          : content_text // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      is_deleted: freezed == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FaqModel implements _FaqModel {
  _$_FaqModel(
      {required this.faq_id,
      required this.category,
      required this.title_text,
      required this.content_text,
      required this.status,
      required this.is_deleted,
      required this.created_at,
      required this.updated_at});

  factory _$_FaqModel.fromJson(Map<String, dynamic> json) =>
      _$$_FaqModelFromJson(json);

  @override
  final String? faq_id;
  @override
  final String? category;
  @override
  final String? title_text;
  @override
  final String? content_text;
  @override
  final String? status;
  @override
  final int? is_deleted;
  @override
  final String? created_at;
  @override
  final String? updated_at;

  @override
  String toString() {
    return 'FaqModel(faq_id: $faq_id, category: $category, title_text: $title_text, content_text: $content_text, status: $status, is_deleted: $is_deleted, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FaqModel &&
            (identical(other.faq_id, faq_id) || other.faq_id == faq_id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title_text, title_text) ||
                other.title_text == title_text) &&
            (identical(other.content_text, content_text) ||
                other.content_text == content_text) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, faq_id, category, title_text,
      content_text, status, is_deleted, created_at, updated_at);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FaqModelCopyWith<_$_FaqModel> get copyWith =>
      __$$_FaqModelCopyWithImpl<_$_FaqModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FaqModelToJson(
      this,
    );
  }
}

abstract class _FaqModel implements FaqModel {
  factory _FaqModel(
      {required final String? faq_id,
      required final String? category,
      required final String? title_text,
      required final String? content_text,
      required final String? status,
      required final int? is_deleted,
      required final String? created_at,
      required final String? updated_at}) = _$_FaqModel;

  factory _FaqModel.fromJson(Map<String, dynamic> json) = _$_FaqModel.fromJson;

  @override
  String? get faq_id;
  @override
  String? get category;
  @override
  String? get title_text;
  @override
  String? get content_text;
  @override
  String? get status;
  @override
  int? get is_deleted;
  @override
  String? get created_at;
  @override
  String? get updated_at;
  @override
  @JsonKey(ignore: true)
  _$$_FaqModelCopyWith<_$_FaqModel> get copyWith =>
      throw _privateConstructorUsedError;
}
