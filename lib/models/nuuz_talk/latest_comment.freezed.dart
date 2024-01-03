// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latest_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LatestComment _$LatestCommentFromJson(Map<String, dynamic> json) {
  return _LatestComment.fromJson(json);
}

/// @nodoc
mixin _$LatestComment {
  @JsonKey(name: "comment_id")
  String? get commentId => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LatestCommentCopyWith<LatestComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestCommentCopyWith<$Res> {
  factory $LatestCommentCopyWith(
          LatestComment value, $Res Function(LatestComment) then) =
      _$LatestCommentCopyWithImpl<$Res, LatestComment>;
  @useResult
  $Res call(
      {@JsonKey(name: "comment_id") String? commentId,
      @JsonKey(name: "description") String? description});
}

/// @nodoc
class _$LatestCommentCopyWithImpl<$Res, $Val extends LatestComment>
    implements $LatestCommentCopyWith<$Res> {
  _$LatestCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LatestCommentCopyWith<$Res>
    implements $LatestCommentCopyWith<$Res> {
  factory _$$_LatestCommentCopyWith(
          _$_LatestComment value, $Res Function(_$_LatestComment) then) =
      __$$_LatestCommentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "comment_id") String? commentId,
      @JsonKey(name: "description") String? description});
}

/// @nodoc
class __$$_LatestCommentCopyWithImpl<$Res>
    extends _$LatestCommentCopyWithImpl<$Res, _$_LatestComment>
    implements _$$_LatestCommentCopyWith<$Res> {
  __$$_LatestCommentCopyWithImpl(
      _$_LatestComment _value, $Res Function(_$_LatestComment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_LatestComment(
      commentId: freezed == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
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
class _$_LatestComment implements _LatestComment {
  _$_LatestComment(
      {@JsonKey(name: "comment_id") this.commentId,
      @JsonKey(name: "description") this.description});

  factory _$_LatestComment.fromJson(Map<String, dynamic> json) =>
      _$$_LatestCommentFromJson(json);

  @override
  @JsonKey(name: "comment_id")
  final String? commentId;
  @override
  @JsonKey(name: "description")
  final String? description;

  @override
  String toString() {
    return 'LatestComment(commentId: $commentId, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LatestComment &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, commentId, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LatestCommentCopyWith<_$_LatestComment> get copyWith =>
      __$$_LatestCommentCopyWithImpl<_$_LatestComment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LatestCommentToJson(
      this,
    );
  }
}

abstract class _LatestComment implements LatestComment {
  factory _LatestComment(
          {@JsonKey(name: "comment_id") final String? commentId,
          @JsonKey(name: "description") final String? description}) =
      _$_LatestComment;

  factory _LatestComment.fromJson(Map<String, dynamic> json) =
      _$_LatestComment.fromJson;

  @override
  @JsonKey(name: "comment_id")
  String? get commentId;
  @override
  @JsonKey(name: "description")
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_LatestCommentCopyWith<_$_LatestComment> get copyWith =>
      throw _privateConstructorUsedError;
}
