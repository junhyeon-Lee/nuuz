// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'socialinfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SocialInfo _$SocialInfoFromJson(Map<String, dynamic> json) {
  return _SocialInfo.fromJson(json);
}

/// @nodoc
mixin _$SocialInfo {
  String get loginType => throw _privateConstructorUsedError;
  String? get socialToken => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get deviceType => throw _privateConstructorUsedError;
  String? get deviceToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialInfoCopyWith<SocialInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialInfoCopyWith<$Res> {
  factory $SocialInfoCopyWith(
          SocialInfo value, $Res Function(SocialInfo) then) =
      _$SocialInfoCopyWithImpl<$Res, SocialInfo>;
  @useResult
  $Res call(
      {String loginType,
      String? socialToken,
      String? email,
      String? deviceType,
      String? deviceToken});
}

/// @nodoc
class _$SocialInfoCopyWithImpl<$Res, $Val extends SocialInfo>
    implements $SocialInfoCopyWith<$Res> {
  _$SocialInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginType = null,
    Object? socialToken = freezed,
    Object? email = freezed,
    Object? deviceType = freezed,
    Object? deviceToken = freezed,
  }) {
    return _then(_value.copyWith(
      loginType: null == loginType
          ? _value.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String,
      socialToken: freezed == socialToken
          ? _value.socialToken
          : socialToken // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceType: freezed == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceToken: freezed == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SocialInfoCopyWith<$Res>
    implements $SocialInfoCopyWith<$Res> {
  factory _$$_SocialInfoCopyWith(
          _$_SocialInfo value, $Res Function(_$_SocialInfo) then) =
      __$$_SocialInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String loginType,
      String? socialToken,
      String? email,
      String? deviceType,
      String? deviceToken});
}

/// @nodoc
class __$$_SocialInfoCopyWithImpl<$Res>
    extends _$SocialInfoCopyWithImpl<$Res, _$_SocialInfo>
    implements _$$_SocialInfoCopyWith<$Res> {
  __$$_SocialInfoCopyWithImpl(
      _$_SocialInfo _value, $Res Function(_$_SocialInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loginType = null,
    Object? socialToken = freezed,
    Object? email = freezed,
    Object? deviceType = freezed,
    Object? deviceToken = freezed,
  }) {
    return _then(_$_SocialInfo(
      loginType: null == loginType
          ? _value.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String,
      socialToken: freezed == socialToken
          ? _value.socialToken
          : socialToken // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceType: freezed == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceToken: freezed == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SocialInfo implements _SocialInfo {
  _$_SocialInfo(
      {required this.loginType,
      required this.socialToken,
      required this.email,
      required this.deviceType,
      required this.deviceToken});

  factory _$_SocialInfo.fromJson(Map<String, dynamic> json) =>
      _$$_SocialInfoFromJson(json);

  @override
  final String loginType;
  @override
  final String? socialToken;
  @override
  final String? email;
  @override
  final String? deviceType;
  @override
  final String? deviceToken;

  @override
  String toString() {
    return 'SocialInfo(loginType: $loginType, socialToken: $socialToken, email: $email, deviceType: $deviceType, deviceToken: $deviceToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SocialInfo &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.socialToken, socialToken) ||
                other.socialToken == socialToken) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, loginType, socialToken, email, deviceType, deviceToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SocialInfoCopyWith<_$_SocialInfo> get copyWith =>
      __$$_SocialInfoCopyWithImpl<_$_SocialInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SocialInfoToJson(
      this,
    );
  }
}

abstract class _SocialInfo implements SocialInfo {
  factory _SocialInfo(
      {required final String loginType,
      required final String? socialToken,
      required final String? email,
      required final String? deviceType,
      required final String? deviceToken}) = _$_SocialInfo;

  factory _SocialInfo.fromJson(Map<String, dynamic> json) =
      _$_SocialInfo.fromJson;

  @override
  String get loginType;
  @override
  String? get socialToken;
  @override
  String? get email;
  @override
  String? get deviceType;
  @override
  String? get deviceToken;
  @override
  @JsonKey(ignore: true)
  _$$_SocialInfoCopyWith<_$_SocialInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
