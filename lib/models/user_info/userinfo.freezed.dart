// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userinfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
mixin _$UserInfo {
  String get token => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  DateTime? get birthday => throw _privateConstructorUsedError;
  String? get registeredProduct => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res, UserInfo>;
  @useResult
  $Res call(
      {String token,
      String? email,
      String? nickname,
      String? gender,
      String? profileImage,
      DateTime? birthday,
      String? registeredProduct});
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res, $Val extends UserInfo>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? email = freezed,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? profileImage = freezed,
    Object? birthday = freezed,
    Object? registeredProduct = freezed,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      registeredProduct: freezed == registeredProduct
          ? _value.registeredProduct
          : registeredProduct // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$$_UserInfoCopyWith(
          _$_UserInfo value, $Res Function(_$_UserInfo) then) =
      __$$_UserInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token,
      String? email,
      String? nickname,
      String? gender,
      String? profileImage,
      DateTime? birthday,
      String? registeredProduct});
}

/// @nodoc
class __$$_UserInfoCopyWithImpl<$Res>
    extends _$UserInfoCopyWithImpl<$Res, _$_UserInfo>
    implements _$$_UserInfoCopyWith<$Res> {
  __$$_UserInfoCopyWithImpl(
      _$_UserInfo _value, $Res Function(_$_UserInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? email = freezed,
    Object? nickname = freezed,
    Object? gender = freezed,
    Object? profileImage = freezed,
    Object? birthday = freezed,
    Object? registeredProduct = freezed,
  }) {
    return _then(_$_UserInfo(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      registeredProduct: freezed == registeredProduct
          ? _value.registeredProduct
          : registeredProduct // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfo implements _UserInfo {
  _$_UserInfo(
      {required this.token,
      required this.email,
      required this.nickname,
      required this.gender,
      required this.profileImage,
      required this.birthday,
      required this.registeredProduct});

  factory _$_UserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoFromJson(json);

  @override
  final String token;
  @override
  final String? email;
  @override
  final String? nickname;
  @override
  final String? gender;
  @override
  final String? profileImage;
  @override
  final DateTime? birthday;
  @override
  final String? registeredProduct;

  @override
  String toString() {
    return 'UserInfo(token: $token, email: $email, nickname: $nickname, gender: $gender, profileImage: $profileImage, birthday: $birthday, registeredProduct: $registeredProduct)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfo &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.registeredProduct, registeredProduct) ||
                other.registeredProduct == registeredProduct));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, email, nickname, gender,
      profileImage, birthday, registeredProduct);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      __$$_UserInfoCopyWithImpl<_$_UserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoToJson(
      this,
    );
  }
}

abstract class _UserInfo implements UserInfo {
  factory _UserInfo(
      {required final String token,
      required final String? email,
      required final String? nickname,
      required final String? gender,
      required final String? profileImage,
      required final DateTime? birthday,
      required final String? registeredProduct}) = _$_UserInfo;

  factory _UserInfo.fromJson(Map<String, dynamic> json) = _$_UserInfo.fromJson;

  @override
  String get token;
  @override
  String? get email;
  @override
  String? get nickname;
  @override
  String? get gender;
  @override
  String? get profileImage;
  @override
  DateTime? get birthday;
  @override
  String? get registeredProduct;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
