// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commentuserinfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommentUserInfo _$CommentUserInfoFromJson(Map<String, dynamic> json) {
  return _CommentUserInfo.fromJson(json);
}

/// @nodoc
mixin _$CommentUserInfo {
  String? get name => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get nick_name => throw _privateConstructorUsedError;
  String? get profile_image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentUserInfoCopyWith<CommentUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentUserInfoCopyWith<$Res> {
  factory $CommentUserInfoCopyWith(
          CommentUserInfo value, $Res Function(CommentUserInfo) then) =
      _$CommentUserInfoCopyWithImpl<$Res, CommentUserInfo>;
  @useResult
  $Res call(
      {String? name,
      String? user_id,
      String? nick_name,
      String? profile_image});
}

/// @nodoc
class _$CommentUserInfoCopyWithImpl<$Res, $Val extends CommentUserInfo>
    implements $CommentUserInfoCopyWith<$Res> {
  _$CommentUserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? user_id = freezed,
    Object? nick_name = freezed,
    Object? profile_image = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      nick_name: freezed == nick_name
          ? _value.nick_name
          : nick_name // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommentUserInfoCopyWith<$Res>
    implements $CommentUserInfoCopyWith<$Res> {
  factory _$$_CommentUserInfoCopyWith(
          _$_CommentUserInfo value, $Res Function(_$_CommentUserInfo) then) =
      __$$_CommentUserInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? user_id,
      String? nick_name,
      String? profile_image});
}

/// @nodoc
class __$$_CommentUserInfoCopyWithImpl<$Res>
    extends _$CommentUserInfoCopyWithImpl<$Res, _$_CommentUserInfo>
    implements _$$_CommentUserInfoCopyWith<$Res> {
  __$$_CommentUserInfoCopyWithImpl(
      _$_CommentUserInfo _value, $Res Function(_$_CommentUserInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? user_id = freezed,
    Object? nick_name = freezed,
    Object? profile_image = freezed,
  }) {
    return _then(_$_CommentUserInfo(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      nick_name: freezed == nick_name
          ? _value.nick_name
          : nick_name // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommentUserInfo implements _CommentUserInfo {
  _$_CommentUserInfo(
      {required this.name,
      required this.user_id,
      required this.nick_name,
      required this.profile_image});

  factory _$_CommentUserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_CommentUserInfoFromJson(json);

  @override
  final String? name;
  @override
  final String? user_id;
  @override
  final String? nick_name;
  @override
  final String? profile_image;

  @override
  String toString() {
    return 'CommentUserInfo(name: $name, user_id: $user_id, nick_name: $nick_name, profile_image: $profile_image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentUserInfo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.nick_name, nick_name) ||
                other.nick_name == nick_name) &&
            (identical(other.profile_image, profile_image) ||
                other.profile_image == profile_image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, user_id, nick_name, profile_image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentUserInfoCopyWith<_$_CommentUserInfo> get copyWith =>
      __$$_CommentUserInfoCopyWithImpl<_$_CommentUserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentUserInfoToJson(
      this,
    );
  }
}

abstract class _CommentUserInfo implements CommentUserInfo {
  factory _CommentUserInfo(
      {required final String? name,
      required final String? user_id,
      required final String? nick_name,
      required final String? profile_image}) = _$_CommentUserInfo;

  factory _CommentUserInfo.fromJson(Map<String, dynamic> json) =
      _$_CommentUserInfo.fromJson;

  @override
  String? get name;
  @override
  String? get user_id;
  @override
  String? get nick_name;
  @override
  String? get profile_image;
  @override
  @JsonKey(ignore: true)
  _$$_CommentUserInfoCopyWith<_$_CommentUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
