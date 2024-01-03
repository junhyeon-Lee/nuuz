// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cheerup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheerUp _$CheerUpFromJson(Map<String, dynamic> json) {
  return _CheerUp.fromJson(json);
}

/// @nodoc
mixin _$CheerUp {
  String? get user_care_program_id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get program_id => throw _privateConstructorUsedError;
  String? get start_day => throw _privateConstructorUsedError;
  int? get set_up_routine => throw _privateConstructorUsedError;
  ReservationNotice? get reservation_notice =>
      throw _privateConstructorUsedError;
  int? get cheering_notice => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get updated_at => throw _privateConstructorUsedError;
  int? get is_deleted => throw _privateConstructorUsedError;
  String? get start_date => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  CheerUpUser? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheerUpCopyWith<CheerUp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheerUpCopyWith<$Res> {
  factory $CheerUpCopyWith(CheerUp value, $Res Function(CheerUp) then) =
      _$CheerUpCopyWithImpl<$Res, CheerUp>;
  @useResult
  $Res call(
      {String? user_care_program_id,
      String? user_id,
      String? program_id,
      String? start_day,
      int? set_up_routine,
      ReservationNotice? reservation_notice,
      int? cheering_notice,
      String? created_at,
      String? updated_at,
      int? is_deleted,
      String? start_date,
      String? status,
      CheerUpUser? user});

  $ReservationNoticeCopyWith<$Res>? get reservation_notice;
  $CheerUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CheerUpCopyWithImpl<$Res, $Val extends CheerUp>
    implements $CheerUpCopyWith<$Res> {
  _$CheerUpCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_care_program_id = freezed,
    Object? user_id = freezed,
    Object? program_id = freezed,
    Object? start_day = freezed,
    Object? set_up_routine = freezed,
    Object? reservation_notice = freezed,
    Object? cheering_notice = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
    Object? start_date = freezed,
    Object? status = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      user_care_program_id: freezed == user_care_program_id
          ? _value.user_care_program_id
          : user_care_program_id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      program_id: freezed == program_id
          ? _value.program_id
          : program_id // ignore: cast_nullable_to_non_nullable
              as String?,
      start_day: freezed == start_day
          ? _value.start_day
          : start_day // ignore: cast_nullable_to_non_nullable
              as String?,
      set_up_routine: freezed == set_up_routine
          ? _value.set_up_routine
          : set_up_routine // ignore: cast_nullable_to_non_nullable
              as int?,
      reservation_notice: freezed == reservation_notice
          ? _value.reservation_notice
          : reservation_notice // ignore: cast_nullable_to_non_nullable
              as ReservationNotice?,
      cheering_notice: freezed == cheering_notice
          ? _value.cheering_notice
          : cheering_notice // ignore: cast_nullable_to_non_nullable
              as int?,
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
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CheerUpUser?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationNoticeCopyWith<$Res>? get reservation_notice {
    if (_value.reservation_notice == null) {
      return null;
    }

    return $ReservationNoticeCopyWith<$Res>(_value.reservation_notice!,
        (value) {
      return _then(_value.copyWith(reservation_notice: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CheerUpUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $CheerUpUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CheerUpCopyWith<$Res> implements $CheerUpCopyWith<$Res> {
  factory _$$_CheerUpCopyWith(
          _$_CheerUp value, $Res Function(_$_CheerUp) then) =
      __$$_CheerUpCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? user_care_program_id,
      String? user_id,
      String? program_id,
      String? start_day,
      int? set_up_routine,
      ReservationNotice? reservation_notice,
      int? cheering_notice,
      String? created_at,
      String? updated_at,
      int? is_deleted,
      String? start_date,
      String? status,
      CheerUpUser? user});

  @override
  $ReservationNoticeCopyWith<$Res>? get reservation_notice;
  @override
  $CheerUpUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_CheerUpCopyWithImpl<$Res>
    extends _$CheerUpCopyWithImpl<$Res, _$_CheerUp>
    implements _$$_CheerUpCopyWith<$Res> {
  __$$_CheerUpCopyWithImpl(_$_CheerUp _value, $Res Function(_$_CheerUp) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_care_program_id = freezed,
    Object? user_id = freezed,
    Object? program_id = freezed,
    Object? start_day = freezed,
    Object? set_up_routine = freezed,
    Object? reservation_notice = freezed,
    Object? cheering_notice = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? is_deleted = freezed,
    Object? start_date = freezed,
    Object? status = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_CheerUp(
      user_care_program_id: freezed == user_care_program_id
          ? _value.user_care_program_id
          : user_care_program_id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      program_id: freezed == program_id
          ? _value.program_id
          : program_id // ignore: cast_nullable_to_non_nullable
              as String?,
      start_day: freezed == start_day
          ? _value.start_day
          : start_day // ignore: cast_nullable_to_non_nullable
              as String?,
      set_up_routine: freezed == set_up_routine
          ? _value.set_up_routine
          : set_up_routine // ignore: cast_nullable_to_non_nullable
              as int?,
      reservation_notice: freezed == reservation_notice
          ? _value.reservation_notice
          : reservation_notice // ignore: cast_nullable_to_non_nullable
              as ReservationNotice?,
      cheering_notice: freezed == cheering_notice
          ? _value.cheering_notice
          : cheering_notice // ignore: cast_nullable_to_non_nullable
              as int?,
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
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CheerUpUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheerUp implements _CheerUp {
  _$_CheerUp(
      {this.user_care_program_id,
      this.user_id,
      this.program_id,
      this.start_day,
      this.set_up_routine,
      this.reservation_notice,
      this.cheering_notice,
      this.created_at,
      this.updated_at,
      this.is_deleted,
      this.start_date,
      this.status,
      this.user});

  factory _$_CheerUp.fromJson(Map<String, dynamic> json) =>
      _$$_CheerUpFromJson(json);

  @override
  final String? user_care_program_id;
  @override
  final String? user_id;
  @override
  final String? program_id;
  @override
  final String? start_day;
  @override
  final int? set_up_routine;
  @override
  final ReservationNotice? reservation_notice;
  @override
  final int? cheering_notice;
  @override
  final String? created_at;
  @override
  final String? updated_at;
  @override
  final int? is_deleted;
  @override
  final String? start_date;
  @override
  final String? status;
  @override
  final CheerUpUser? user;

  @override
  String toString() {
    return 'CheerUp(user_care_program_id: $user_care_program_id, user_id: $user_id, program_id: $program_id, start_day: $start_day, set_up_routine: $set_up_routine, reservation_notice: $reservation_notice, cheering_notice: $cheering_notice, created_at: $created_at, updated_at: $updated_at, is_deleted: $is_deleted, start_date: $start_date, status: $status, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CheerUp &&
            (identical(other.user_care_program_id, user_care_program_id) ||
                other.user_care_program_id == user_care_program_id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.program_id, program_id) ||
                other.program_id == program_id) &&
            (identical(other.start_day, start_day) ||
                other.start_day == start_day) &&
            (identical(other.set_up_routine, set_up_routine) ||
                other.set_up_routine == set_up_routine) &&
            (identical(other.reservation_notice, reservation_notice) ||
                other.reservation_notice == reservation_notice) &&
            (identical(other.cheering_notice, cheering_notice) ||
                other.cheering_notice == cheering_notice) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted) &&
            (identical(other.start_date, start_date) ||
                other.start_date == start_date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      user_care_program_id,
      user_id,
      program_id,
      start_day,
      set_up_routine,
      reservation_notice,
      cheering_notice,
      created_at,
      updated_at,
      is_deleted,
      start_date,
      status,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheerUpCopyWith<_$_CheerUp> get copyWith =>
      __$$_CheerUpCopyWithImpl<_$_CheerUp>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheerUpToJson(
      this,
    );
  }
}

abstract class _CheerUp implements CheerUp {
  factory _CheerUp(
      {final String? user_care_program_id,
      final String? user_id,
      final String? program_id,
      final String? start_day,
      final int? set_up_routine,
      final ReservationNotice? reservation_notice,
      final int? cheering_notice,
      final String? created_at,
      final String? updated_at,
      final int? is_deleted,
      final String? start_date,
      final String? status,
      final CheerUpUser? user}) = _$_CheerUp;

  factory _CheerUp.fromJson(Map<String, dynamic> json) = _$_CheerUp.fromJson;

  @override
  String? get user_care_program_id;
  @override
  String? get user_id;
  @override
  String? get program_id;
  @override
  String? get start_day;
  @override
  int? get set_up_routine;
  @override
  ReservationNotice? get reservation_notice;
  @override
  int? get cheering_notice;
  @override
  String? get created_at;
  @override
  String? get updated_at;
  @override
  int? get is_deleted;
  @override
  String? get start_date;
  @override
  String? get status;
  @override
  CheerUpUser? get user;
  @override
  @JsonKey(ignore: true)
  _$$_CheerUpCopyWith<_$_CheerUp> get copyWith =>
      throw _privateConstructorUsedError;
}
