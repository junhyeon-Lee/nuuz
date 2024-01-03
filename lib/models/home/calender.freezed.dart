// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calender.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Calender _$CalenderFromJson(Map<String, dynamic> json) {
  return _Calender.fromJson(json);
}

/// @nodoc
mixin _$Calender {
  int get nickname => throw _privateConstructorUsedError;
  int get profileImage => throw _privateConstructorUsedError;
  Days get days => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalenderCopyWith<Calender> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalenderCopyWith<$Res> {
  factory $CalenderCopyWith(Calender value, $Res Function(Calender) then) =
      _$CalenderCopyWithImpl<$Res, Calender>;
  @useResult
  $Res call({int nickname, int profileImage, Days days});

  $DaysCopyWith<$Res> get days;
}

/// @nodoc
class _$CalenderCopyWithImpl<$Res, $Val extends Calender>
    implements $CalenderCopyWith<$Res> {
  _$CalenderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? profileImage = null,
    Object? days = null,
  }) {
    return _then(_value.copyWith(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as int,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as int,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as Days,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DaysCopyWith<$Res> get days {
    return $DaysCopyWith<$Res>(_value.days, (value) {
      return _then(_value.copyWith(days: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CalenderCopyWith<$Res> implements $CalenderCopyWith<$Res> {
  factory _$$_CalenderCopyWith(
          _$_Calender value, $Res Function(_$_Calender) then) =
      __$$_CalenderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int nickname, int profileImage, Days days});

  @override
  $DaysCopyWith<$Res> get days;
}

/// @nodoc
class __$$_CalenderCopyWithImpl<$Res>
    extends _$CalenderCopyWithImpl<$Res, _$_Calender>
    implements _$$_CalenderCopyWith<$Res> {
  __$$_CalenderCopyWithImpl(
      _$_Calender _value, $Res Function(_$_Calender) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = null,
    Object? profileImage = null,
    Object? days = null,
  }) {
    return _then(_$_Calender(
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as int,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as int,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as Days,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Calender implements _Calender {
  _$_Calender(
      {required this.nickname, required this.profileImage, required this.days});

  factory _$_Calender.fromJson(Map<String, dynamic> json) =>
      _$$_CalenderFromJson(json);

  @override
  final int nickname;
  @override
  final int profileImage;
  @override
  final Days days;

  @override
  String toString() {
    return 'Calender(nickname: $nickname, profileImage: $profileImage, days: $days)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Calender &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.days, days) || other.days == days));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nickname, profileImage, days);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CalenderCopyWith<_$_Calender> get copyWith =>
      __$$_CalenderCopyWithImpl<_$_Calender>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CalenderToJson(
      this,
    );
  }
}

abstract class _Calender implements Calender {
  factory _Calender(
      {required final int nickname,
      required final int profileImage,
      required final Days days}) = _$_Calender;

  factory _Calender.fromJson(Map<String, dynamic> json) = _$_Calender.fromJson;

  @override
  int get nickname;
  @override
  int get profileImage;
  @override
  Days get days;
  @override
  @JsonKey(ignore: true)
  _$$_CalenderCopyWith<_$_Calender> get copyWith =>
      throw _privateConstructorUsedError;
}
