// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'getuserdata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetUserData _$GetUserDataFromJson(Map<String, dynamic> json) {
  return _GetUserData.fromJson(json);
}

/// @nodoc
mixin _$GetUserData {
  bool? get status => throw _privateConstructorUsedError;
  UserData? get userData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetUserDataCopyWith<GetUserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetUserDataCopyWith<$Res> {
  factory $GetUserDataCopyWith(
          GetUserData value, $Res Function(GetUserData) then) =
      _$GetUserDataCopyWithImpl<$Res, GetUserData>;
  @useResult
  $Res call({bool? status, UserData? userData});

  $UserDataCopyWith<$Res>? get userData;
}

/// @nodoc
class _$GetUserDataCopyWithImpl<$Res, $Val extends GetUserData>
    implements $GetUserDataCopyWith<$Res> {
  _$GetUserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? userData = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res>? get userData {
    if (_value.userData == null) {
      return null;
    }

    return $UserDataCopyWith<$Res>(_value.userData!, (value) {
      return _then(_value.copyWith(userData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GetUserDataCopyWith<$Res>
    implements $GetUserDataCopyWith<$Res> {
  factory _$$_GetUserDataCopyWith(
          _$_GetUserData value, $Res Function(_$_GetUserData) then) =
      __$$_GetUserDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? status, UserData? userData});

  @override
  $UserDataCopyWith<$Res>? get userData;
}

/// @nodoc
class __$$_GetUserDataCopyWithImpl<$Res>
    extends _$GetUserDataCopyWithImpl<$Res, _$_GetUserData>
    implements _$$_GetUserDataCopyWith<$Res> {
  __$$_GetUserDataCopyWithImpl(
      _$_GetUserData _value, $Res Function(_$_GetUserData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? userData = freezed,
  }) {
    return _then(_$_GetUserData(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      userData: freezed == userData
          ? _value.userData
          : userData // ignore: cast_nullable_to_non_nullable
              as UserData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetUserData implements _GetUserData {
  _$_GetUserData({required this.status, required this.userData});

  factory _$_GetUserData.fromJson(Map<String, dynamic> json) =>
      _$$_GetUserDataFromJson(json);

  @override
  final bool? status;
  @override
  final UserData? userData;

  @override
  String toString() {
    return 'GetUserData(status: $status, userData: $userData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetUserData &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userData, userData) ||
                other.userData == userData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, userData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetUserDataCopyWith<_$_GetUserData> get copyWith =>
      __$$_GetUserDataCopyWithImpl<_$_GetUserData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetUserDataToJson(
      this,
    );
  }
}

abstract class _GetUserData implements GetUserData {
  factory _GetUserData(
      {required final bool? status,
      required final UserData? userData}) = _$_GetUserData;

  factory _GetUserData.fromJson(Map<String, dynamic> json) =
      _$_GetUserData.fromJson;

  @override
  bool? get status;
  @override
  UserData? get userData;
  @override
  @JsonKey(ignore: true)
  _$$_GetUserDataCopyWith<_$_GetUserData> get copyWith =>
      throw _privateConstructorUsedError;
}
