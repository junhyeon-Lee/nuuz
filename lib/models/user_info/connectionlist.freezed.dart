// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectionlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConnectionList _$ConnectionListFromJson(Map<String, dynamic> json) {
  return _ConnectionList.fromJson(json);
}

/// @nodoc
mixin _$ConnectionList {
  String? get user_id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profile_image => throw _privateConstructorUsedError;
  String? get nick_name => throw _privateConstructorUsedError;
  String? get introduction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectionListCopyWith<ConnectionList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionListCopyWith<$Res> {
  factory $ConnectionListCopyWith(
          ConnectionList value, $Res Function(ConnectionList) then) =
      _$ConnectionListCopyWithImpl<$Res, ConnectionList>;
  @useResult
  $Res call(
      {String? user_id,
      String? name,
      String? email,
      String? profile_image,
      String? nick_name,
      String? introduction});
}

/// @nodoc
class _$ConnectionListCopyWithImpl<$Res, $Val extends ConnectionList>
    implements $ConnectionListCopyWith<$Res> {
  _$ConnectionListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? profile_image = freezed,
    Object? nick_name = freezed,
    Object? introduction = freezed,
  }) {
    return _then(_value.copyWith(
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      nick_name: freezed == nick_name
          ? _value.nick_name
          : nick_name // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: freezed == introduction
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConnectionListCopyWith<$Res>
    implements $ConnectionListCopyWith<$Res> {
  factory _$$_ConnectionListCopyWith(
          _$_ConnectionList value, $Res Function(_$_ConnectionList) then) =
      __$$_ConnectionListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? user_id,
      String? name,
      String? email,
      String? profile_image,
      String? nick_name,
      String? introduction});
}

/// @nodoc
class __$$_ConnectionListCopyWithImpl<$Res>
    extends _$ConnectionListCopyWithImpl<$Res, _$_ConnectionList>
    implements _$$_ConnectionListCopyWith<$Res> {
  __$$_ConnectionListCopyWithImpl(
      _$_ConnectionList _value, $Res Function(_$_ConnectionList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? profile_image = freezed,
    Object? nick_name = freezed,
    Object? introduction = freezed,
  }) {
    return _then(_$_ConnectionList(
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      nick_name: freezed == nick_name
          ? _value.nick_name
          : nick_name // ignore: cast_nullable_to_non_nullable
              as String?,
      introduction: freezed == introduction
          ? _value.introduction
          : introduction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConnectionList implements _ConnectionList {
  _$_ConnectionList(
      {required this.user_id,
      required this.name,
      required this.email,
      required this.profile_image,
      required this.nick_name,
      required this.introduction});

  factory _$_ConnectionList.fromJson(Map<String, dynamic> json) =>
      _$$_ConnectionListFromJson(json);

  @override
  final String? user_id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? profile_image;
  @override
  final String? nick_name;
  @override
  final String? introduction;

  @override
  String toString() {
    return 'ConnectionList(user_id: $user_id, name: $name, email: $email, profile_image: $profile_image, nick_name: $nick_name, introduction: $introduction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectionList &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profile_image, profile_image) ||
                other.profile_image == profile_image) &&
            (identical(other.nick_name, nick_name) ||
                other.nick_name == nick_name) &&
            (identical(other.introduction, introduction) ||
                other.introduction == introduction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user_id, name, email,
      profile_image, nick_name, introduction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConnectionListCopyWith<_$_ConnectionList> get copyWith =>
      __$$_ConnectionListCopyWithImpl<_$_ConnectionList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConnectionListToJson(
      this,
    );
  }
}

abstract class _ConnectionList implements ConnectionList {
  factory _ConnectionList(
      {required final String? user_id,
      required final String? name,
      required final String? email,
      required final String? profile_image,
      required final String? nick_name,
      required final String? introduction}) = _$_ConnectionList;

  factory _ConnectionList.fromJson(Map<String, dynamic> json) =
      _$_ConnectionList.fromJson;

  @override
  String? get user_id;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get profile_image;
  @override
  String? get nick_name;
  @override
  String? get introduction;
  @override
  @JsonKey(ignore: true)
  _$$_ConnectionListCopyWith<_$_ConnectionList> get copyWith =>
      throw _privateConstructorUsedError;
}
