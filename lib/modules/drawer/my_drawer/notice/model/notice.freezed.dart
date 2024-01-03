// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Notice _$NoticeFromJson(Map<String, dynamic> json) {
  return _Notice.fromJson(json);
}

/// @nodoc
mixin _$Notice {
  String? get notice_id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get title_text => throw _privateConstructorUsedError;
  String? get body_text => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get updated_at => throw _privateConstructorUsedError;
  int? get is_deleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoticeCopyWith<Notice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeCopyWith<$Res> {
  factory $NoticeCopyWith(Notice value, $Res Function(Notice) then) =
      _$NoticeCopyWithImpl<$Res, Notice>;
  @useResult
  $Res call(
      {String? notice_id,
      String? user_id,
      String? category,
      String? title_text,
      String? body_text,
      String? created_at,
      String? updated_at,
      int? is_deleted});
}

/// @nodoc
class _$NoticeCopyWithImpl<$Res, $Val extends Notice>
    implements $NoticeCopyWith<$Res> {
  _$NoticeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notice_id = freezed,
    Object? user_id = freezed,
    Object? category = freezed,
    Object? title_text = freezed,
    Object? body_text = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
  }) {
    return _then(_value.copyWith(
      notice_id: freezed == notice_id
          ? _value.notice_id
          : notice_id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      title_text: freezed == title_text
          ? _value.title_text
          : title_text // ignore: cast_nullable_to_non_nullable
              as String?,
      body_text: freezed == body_text
          ? _value.body_text
          : body_text // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_NoticeCopyWith<$Res> implements $NoticeCopyWith<$Res> {
  factory _$$_NoticeCopyWith(_$_Notice value, $Res Function(_$_Notice) then) =
      __$$_NoticeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? notice_id,
      String? user_id,
      String? category,
      String? title_text,
      String? body_text,
      String? created_at,
      String? updated_at,
      int? is_deleted});
}

/// @nodoc
class __$$_NoticeCopyWithImpl<$Res>
    extends _$NoticeCopyWithImpl<$Res, _$_Notice>
    implements _$$_NoticeCopyWith<$Res> {
  __$$_NoticeCopyWithImpl(_$_Notice _value, $Res Function(_$_Notice) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notice_id = freezed,
    Object? user_id = freezed,
    Object? category = freezed,
    Object? title_text = freezed,
    Object? body_text = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
  }) {
    return _then(_$_Notice(
      notice_id: freezed == notice_id
          ? _value.notice_id
          : notice_id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      title_text: freezed == title_text
          ? _value.title_text
          : title_text // ignore: cast_nullable_to_non_nullable
              as String?,
      body_text: freezed == body_text
          ? _value.body_text
          : body_text // ignore: cast_nullable_to_non_nullable
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
class _$_Notice implements _Notice {
  _$_Notice(
      {required this.notice_id,
      required this.user_id,
      required this.category,
      required this.title_text,
      required this.body_text,
      required this.created_at,
      required this.updated_at,
      required this.is_deleted});

  factory _$_Notice.fromJson(Map<String, dynamic> json) =>
      _$$_NoticeFromJson(json);

  @override
  final String? notice_id;
  @override
  final String? user_id;
  @override
  final String? category;
  @override
  final String? title_text;
  @override
  final String? body_text;
  @override
  final String? created_at;
  @override
  final String? updated_at;
  @override
  final int? is_deleted;

  @override
  String toString() {
    return 'Notice(notice_id: $notice_id, user_id: $user_id, category: $category, title_text: $title_text, body_text: $body_text, created_at: $created_at, updated_at: $updated_at, is_deleted: $is_deleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Notice &&
            (identical(other.notice_id, notice_id) ||
                other.notice_id == notice_id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.title_text, title_text) ||
                other.title_text == title_text) &&
            (identical(other.body_text, body_text) ||
                other.body_text == body_text) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, notice_id, user_id, category,
      title_text, body_text, created_at, updated_at, is_deleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoticeCopyWith<_$_Notice> get copyWith =>
      __$$_NoticeCopyWithImpl<_$_Notice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoticeToJson(
      this,
    );
  }
}

abstract class _Notice implements Notice {
  factory _Notice(
      {required final String? notice_id,
      required final String? user_id,
      required final String? category,
      required final String? title_text,
      required final String? body_text,
      required final String? created_at,
      required final String? updated_at,
      required final int? is_deleted}) = _$_Notice;

  factory _Notice.fromJson(Map<String, dynamic> json) = _$_Notice.fromJson;

  @override
  String? get notice_id;
  @override
  String? get user_id;
  @override
  String? get category;
  @override
  String? get title_text;
  @override
  String? get body_text;
  @override
  String? get created_at;
  @override
  String? get updated_at;
  @override
  int? get is_deleted;
  @override
  @JsonKey(ignore: true)
  _$$_NoticeCopyWith<_$_Notice> get copyWith =>
      throw _privateConstructorUsedError;
}
