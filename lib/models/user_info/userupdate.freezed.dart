// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userupdate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserUpdate _$UserUpdateFromJson(Map<String, dynamic> json) {
  return _UserUpdate.fromJson(json);
}

/// @nodoc
mixin _$UserUpdate {
  String? get name => throw _privateConstructorUsedError;
  String? get birth_date => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profile_image => throw _privateConstructorUsedError;
  String? get is_deleted => throw _privateConstructorUsedError;
  String? get nick_name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserUpdateCopyWith<UserUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserUpdateCopyWith<$Res> {
  factory $UserUpdateCopyWith(
          UserUpdate value, $Res Function(UserUpdate) then) =
      _$UserUpdateCopyWithImpl<$Res, UserUpdate>;
  @useResult
  $Res call(
      {String? name,
      String? birth_date,
      String? gender,
      String? email,
      String? profile_image,
      String? is_deleted,
      String? nick_name});
}

/// @nodoc
class _$UserUpdateCopyWithImpl<$Res, $Val extends UserUpdate>
    implements $UserUpdateCopyWith<$Res> {
  _$UserUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? birth_date = freezed,
    Object? gender = freezed,
    Object? email = freezed,
    Object? profile_image = freezed,
    Object? is_deleted = freezed,
    Object? nick_name = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      birth_date: freezed == birth_date
          ? _value.birth_date
          : birth_date // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      is_deleted: freezed == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as String?,
      nick_name: freezed == nick_name
          ? _value.nick_name
          : nick_name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserUpdateCopyWith<$Res>
    implements $UserUpdateCopyWith<$Res> {
  factory _$$_UserUpdateCopyWith(
          _$_UserUpdate value, $Res Function(_$_UserUpdate) then) =
      __$$_UserUpdateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? birth_date,
      String? gender,
      String? email,
      String? profile_image,
      String? is_deleted,
      String? nick_name});
}

/// @nodoc
class __$$_UserUpdateCopyWithImpl<$Res>
    extends _$UserUpdateCopyWithImpl<$Res, _$_UserUpdate>
    implements _$$_UserUpdateCopyWith<$Res> {
  __$$_UserUpdateCopyWithImpl(
      _$_UserUpdate _value, $Res Function(_$_UserUpdate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? birth_date = freezed,
    Object? gender = freezed,
    Object? email = freezed,
    Object? profile_image = freezed,
    Object? is_deleted = freezed,
    Object? nick_name = freezed,
  }) {
    return _then(_$_UserUpdate(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      birth_date: freezed == birth_date
          ? _value.birth_date
          : birth_date // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profile_image: freezed == profile_image
          ? _value.profile_image
          : profile_image // ignore: cast_nullable_to_non_nullable
              as String?,
      is_deleted: freezed == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as String?,
      nick_name: freezed == nick_name
          ? _value.nick_name
          : nick_name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserUpdate implements _UserUpdate {
  _$_UserUpdate(
      {required this.name,
      required this.birth_date,
      required this.gender,
      required this.email,
      required this.profile_image,
      required this.is_deleted,
      required this.nick_name});

  factory _$_UserUpdate.fromJson(Map<String, dynamic> json) =>
      _$$_UserUpdateFromJson(json);

  @override
  final String? name;
  @override
  final String? birth_date;
  @override
  final String? gender;
  @override
  final String? email;
  @override
  final String? profile_image;
  @override
  final String? is_deleted;
  @override
  final String? nick_name;

  @override
  String toString() {
    return 'UserUpdate(name: $name, birth_date: $birth_date, gender: $gender, email: $email, profile_image: $profile_image, is_deleted: $is_deleted, nick_name: $nick_name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserUpdate &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birth_date, birth_date) ||
                other.birth_date == birth_date) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profile_image, profile_image) ||
                other.profile_image == profile_image) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted) &&
            (identical(other.nick_name, nick_name) ||
                other.nick_name == nick_name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, birth_date, gender, email,
      profile_image, is_deleted, nick_name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserUpdateCopyWith<_$_UserUpdate> get copyWith =>
      __$$_UserUpdateCopyWithImpl<_$_UserUpdate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserUpdateToJson(
      this,
    );
  }
}

abstract class _UserUpdate implements UserUpdate {
  factory _UserUpdate(
      {required final String? name,
      required final String? birth_date,
      required final String? gender,
      required final String? email,
      required final String? profile_image,
      required final String? is_deleted,
      required final String? nick_name}) = _$_UserUpdate;

  factory _UserUpdate.fromJson(Map<String, dynamic> json) =
      _$_UserUpdate.fromJson;

  @override
  String? get name;
  @override
  String? get birth_date;
  @override
  String? get gender;
  @override
  String? get email;
  @override
  String? get profile_image;
  @override
  String? get is_deleted;
  @override
  String? get nick_name;
  @override
  @JsonKey(ignore: true)
  _$$_UserUpdateCopyWith<_$_UserUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}
