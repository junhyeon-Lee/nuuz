// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cheerupuser.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheerUpUser _$CheerUpUserFromJson(Map<String, dynamic> json) {
  return _CheerUpUser.fromJson(json);
}

/// @nodoc
mixin _$CheerUpUser {
  String? get name => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get nick_name => throw _privateConstructorUsedError;
  String? get profile_image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheerUpUserCopyWith<CheerUpUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheerUpUserCopyWith<$Res> {
  factory $CheerUpUserCopyWith(
          CheerUpUser value, $Res Function(CheerUpUser) then) =
      _$CheerUpUserCopyWithImpl<$Res, CheerUpUser>;
  @useResult
  $Res call(
      {String? name,
      String? user_id,
      String? nick_name,
      String? profile_image});
}

/// @nodoc
class _$CheerUpUserCopyWithImpl<$Res, $Val extends CheerUpUser>
    implements $CheerUpUserCopyWith<$Res> {
  _$CheerUpUserCopyWithImpl(this._value, this._then);

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
abstract class _$$_CheerUpUserCopyWith<$Res>
    implements $CheerUpUserCopyWith<$Res> {
  factory _$$_CheerUpUserCopyWith(
          _$_CheerUpUser value, $Res Function(_$_CheerUpUser) then) =
      __$$_CheerUpUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? user_id,
      String? nick_name,
      String? profile_image});
}

/// @nodoc
class __$$_CheerUpUserCopyWithImpl<$Res>
    extends _$CheerUpUserCopyWithImpl<$Res, _$_CheerUpUser>
    implements _$$_CheerUpUserCopyWith<$Res> {
  __$$_CheerUpUserCopyWithImpl(
      _$_CheerUpUser _value, $Res Function(_$_CheerUpUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? user_id = freezed,
    Object? nick_name = freezed,
    Object? profile_image = freezed,
  }) {
    return _then(_$_CheerUpUser(
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
class _$_CheerUpUser implements _CheerUpUser {
  _$_CheerUpUser({this.name, this.user_id, this.nick_name, this.profile_image});

  factory _$_CheerUpUser.fromJson(Map<String, dynamic> json) =>
      _$$_CheerUpUserFromJson(json);

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
    return 'CheerUpUser(name: $name, user_id: $user_id, nick_name: $nick_name, profile_image: $profile_image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheerUpUser &&
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
  _$$_CheerUpUserCopyWith<_$_CheerUpUser> get copyWith =>
      __$$_CheerUpUserCopyWithImpl<_$_CheerUpUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheerUpUserToJson(
      this,
    );
  }
}

abstract class _CheerUpUser implements CheerUpUser {
  factory _CheerUpUser(
      {final String? name,
      final String? user_id,
      final String? nick_name,
      final String? profile_image}) = _$_CheerUpUser;

  factory _CheerUpUser.fromJson(Map<String, dynamic> json) =
      _$_CheerUpUser.fromJson;

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
  _$$_CheerUpUserCopyWith<_$_CheerUpUser> get copyWith =>
      throw _privateConstructorUsedError;
}
