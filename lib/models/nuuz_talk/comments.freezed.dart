// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserComment _$UserCommentFromJson(Map<String, dynamic> json) {
  return _UserComment.fromJson(json);
}

/// @nodoc
mixin _$UserComment {
  String? get comment_id => throw _privateConstructorUsedError;
  String? get post_id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get updated_at => throw _privateConstructorUsedError;
  int? get is_deleted => throw _privateConstructorUsedError;
  CommentUserInfo? get user => throw _privateConstructorUsedError;
  int? get reactions => throw _privateConstructorUsedError;
  int? get is_liked => throw _privateConstructorUsedError;
  String? get reactId => throw _privateConstructorUsedError;
  String? get postImage => throw _privateConstructorUsedError;
  String? get categoryName => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCommentCopyWith<UserComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCommentCopyWith<$Res> {
  factory $UserCommentCopyWith(
          UserComment value, $Res Function(UserComment) then) =
      _$UserCommentCopyWithImpl<$Res, UserComment>;
  @useResult
  $Res call(
      {String? comment_id,
      String? post_id,
      String? user_id,
      String? description,
      String? created_at,
      String? updated_at,
      int? is_deleted,
      CommentUserInfo? user,
      int? reactions,
      int? is_liked,
      String? reactId,
      String? postImage,
      String? categoryName,
      String? categoryId});

  $CommentUserInfoCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserCommentCopyWithImpl<$Res, $Val extends UserComment>
    implements $UserCommentCopyWith<$Res> {
  _$UserCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment_id = freezed,
    Object? post_id = freezed,
    Object? user_id = freezed,
    Object? description = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
    Object? user = freezed,
    Object? reactions = freezed,
    Object? is_liked = freezed,
    Object? reactId = freezed,
    Object? postImage = freezed,
    Object? categoryName = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_value.copyWith(
      comment_id: freezed == comment_id
          ? _value.comment_id
          : comment_id // ignore: cast_nullable_to_non_nullable
              as String?,
      post_id: freezed == post_id
          ? _value.post_id
          : post_id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommentUserInfo?,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as int?,
      is_liked: freezed == is_liked
          ? _value.is_liked
          : is_liked // ignore: cast_nullable_to_non_nullable
              as int?,
      reactId: freezed == reactId
          ? _value.reactId
          : reactId // ignore: cast_nullable_to_non_nullable
              as String?,
      postImage: freezed == postImage
          ? _value.postImage
          : postImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentUserInfoCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $CommentUserInfoCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserCommentCopyWith<$Res>
    implements $UserCommentCopyWith<$Res> {
  factory _$$_UserCommentCopyWith(
          _$_UserComment value, $Res Function(_$_UserComment) then) =
      __$$_UserCommentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? comment_id,
      String? post_id,
      String? user_id,
      String? description,
      String? created_at,
      String? updated_at,
      int? is_deleted,
      CommentUserInfo? user,
      int? reactions,
      int? is_liked,
      String? reactId,
      String? postImage,
      String? categoryName,
      String? categoryId});

  @override
  $CommentUserInfoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_UserCommentCopyWithImpl<$Res>
    extends _$UserCommentCopyWithImpl<$Res, _$_UserComment>
    implements _$$_UserCommentCopyWith<$Res> {
  __$$_UserCommentCopyWithImpl(
      _$_UserComment _value, $Res Function(_$_UserComment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment_id = freezed,
    Object? post_id = freezed,
    Object? user_id = freezed,
    Object? description = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
    Object? user = freezed,
    Object? reactions = freezed,
    Object? is_liked = freezed,
    Object? reactId = freezed,
    Object? postImage = freezed,
    Object? categoryName = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_$_UserComment(
      comment_id: freezed == comment_id
          ? _value.comment_id
          : comment_id // ignore: cast_nullable_to_non_nullable
              as String?,
      post_id: freezed == post_id
          ? _value.post_id
          : post_id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommentUserInfo?,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as int?,
      is_liked: freezed == is_liked
          ? _value.is_liked
          : is_liked // ignore: cast_nullable_to_non_nullable
              as int?,
      reactId: freezed == reactId
          ? _value.reactId
          : reactId // ignore: cast_nullable_to_non_nullable
              as String?,
      postImage: freezed == postImage
          ? _value.postImage
          : postImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserComment implements _UserComment {
  _$_UserComment(
      {this.comment_id,
      this.post_id,
      this.user_id,
      this.description,
      this.created_at,
      this.updated_at,
      this.is_deleted,
      this.user,
      this.reactions,
      this.is_liked,
      this.reactId,
      this.postImage,
      this.categoryName,
      this.categoryId});

  factory _$_UserComment.fromJson(Map<String, dynamic> json) =>
      _$$_UserCommentFromJson(json);

  @override
  final String? comment_id;
  @override
  final String? post_id;
  @override
  final String? user_id;
  @override
  final String? description;
  @override
  final String? created_at;
  @override
  final String? updated_at;
  @override
  final int? is_deleted;
  @override
  final CommentUserInfo? user;
  @override
  final int? reactions;
  @override
  final int? is_liked;
  @override
  final String? reactId;
  @override
  final String? postImage;
  @override
  final String? categoryName;
  @override
  final String? categoryId;

  @override
  String toString() {
    return 'UserComment(comment_id: $comment_id, post_id: $post_id, user_id: $user_id, description: $description, created_at: $created_at, updated_at: $updated_at, is_deleted: $is_deleted, user: $user, reactions: $reactions, is_liked: $is_liked, reactId: $reactId, postImage: $postImage, categoryName: $categoryName, categoryId: $categoryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserComment &&
            (identical(other.comment_id, comment_id) ||
                other.comment_id == comment_id) &&
            (identical(other.post_id, post_id) || other.post_id == post_id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.reactions, reactions) ||
                other.reactions == reactions) &&
            (identical(other.is_liked, is_liked) ||
                other.is_liked == is_liked) &&
            (identical(other.reactId, reactId) || other.reactId == reactId) &&
            (identical(other.postImage, postImage) ||
                other.postImage == postImage) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      comment_id,
      post_id,
      user_id,
      description,
      created_at,
      updated_at,
      is_deleted,
      user,
      reactions,
      is_liked,
      reactId,
      postImage,
      categoryName,
      categoryId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCommentCopyWith<_$_UserComment> get copyWith =>
      __$$_UserCommentCopyWithImpl<_$_UserComment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserCommentToJson(
      this,
    );
  }
}

abstract class _UserComment implements UserComment {
  factory _UserComment(
      {final String? comment_id,
      final String? post_id,
      final String? user_id,
      final String? description,
      final String? created_at,
      final String? updated_at,
      final int? is_deleted,
      final CommentUserInfo? user,
      final int? reactions,
      final int? is_liked,
      final String? reactId,
      final String? postImage,
      final String? categoryName,
      final String? categoryId}) = _$_UserComment;

  factory _UserComment.fromJson(Map<String, dynamic> json) =
      _$_UserComment.fromJson;

  @override
  String? get comment_id;
  @override
  String? get post_id;
  @override
  String? get user_id;
  @override
  String? get description;
  @override
  String? get created_at;
  @override
  String? get updated_at;
  @override
  int? get is_deleted;
  @override
  CommentUserInfo? get user;
  @override
  int? get reactions;
  @override
  int? get is_liked;
  @override
  String? get reactId;
  @override
  String? get postImage;
  @override
  String? get categoryName;
  @override
  String? get categoryId;
  @override
  @JsonKey(ignore: true)
  _$$_UserCommentCopyWith<_$_UserComment> get copyWith =>
      throw _privateConstructorUsedError;
}
