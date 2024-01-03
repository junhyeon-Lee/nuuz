// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usercareprogram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserCareProgram _$UserCareProgramFromJson(Map<String, dynamic> json) {
  return _UserCareProgram.fromJson(json);
}

/// @nodoc
mixin _$UserCareProgram {
  @JsonKey(name: "user_care_program_id")
  String get userCareProgramId => throw _privateConstructorUsedError;
  @JsonKey(name: "care_program")
  Program get program => throw _privateConstructorUsedError;
  @JsonKey(name: "start_day")
  String? get startDay => throw _privateConstructorUsedError;
  @JsonKey(name: "reservation_notice")
  ReservationNotice? get reservationNotice =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "cheering_notice")
  int? get cheeringNotice => throw _privateConstructorUsedError;
  @JsonKey(name: "start_date")
  String get startDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCareProgramCopyWith<UserCareProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCareProgramCopyWith<$Res> {
  factory $UserCareProgramCopyWith(
          UserCareProgram value, $Res Function(UserCareProgram) then) =
      _$UserCareProgramCopyWithImpl<$Res, UserCareProgram>;
  @useResult
  $Res call(
      {@JsonKey(name: "user_care_program_id") String userCareProgramId,
      @JsonKey(name: "care_program") Program program,
      @JsonKey(name: "start_day") String? startDay,
      @JsonKey(name: "reservation_notice") ReservationNotice? reservationNotice,
      @JsonKey(name: "cheering_notice") int? cheeringNotice,
      @JsonKey(name: "start_date") String startDate,
      String status});

  $ProgramCopyWith<$Res> get program;
  $ReservationNoticeCopyWith<$Res>? get reservationNotice;
}

/// @nodoc
class _$UserCareProgramCopyWithImpl<$Res, $Val extends UserCareProgram>
    implements $UserCareProgramCopyWith<$Res> {
  _$UserCareProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userCareProgramId = null,
    Object? program = null,
    Object? startDay = freezed,
    Object? reservationNotice = freezed,
    Object? cheeringNotice = freezed,
    Object? startDate = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      userCareProgramId: null == userCareProgramId
          ? _value.userCareProgramId
          : userCareProgramId // ignore: cast_nullable_to_non_nullable
              as String,
      program: null == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as Program,
      startDay: freezed == startDay
          ? _value.startDay
          : startDay // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationNotice: freezed == reservationNotice
          ? _value.reservationNotice
          : reservationNotice // ignore: cast_nullable_to_non_nullable
              as ReservationNotice?,
      cheeringNotice: freezed == cheeringNotice
          ? _value.cheeringNotice
          : cheeringNotice // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProgramCopyWith<$Res> get program {
    return $ProgramCopyWith<$Res>(_value.program, (value) {
      return _then(_value.copyWith(program: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationNoticeCopyWith<$Res>? get reservationNotice {
    if (_value.reservationNotice == null) {
      return null;
    }

    return $ReservationNoticeCopyWith<$Res>(_value.reservationNotice!, (value) {
      return _then(_value.copyWith(reservationNotice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserCareProgramCopyWith<$Res>
    implements $UserCareProgramCopyWith<$Res> {
  factory _$$_UserCareProgramCopyWith(
          _$_UserCareProgram value, $Res Function(_$_UserCareProgram) then) =
      __$$_UserCareProgramCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "user_care_program_id") String userCareProgramId,
      @JsonKey(name: "care_program") Program program,
      @JsonKey(name: "start_day") String? startDay,
      @JsonKey(name: "reservation_notice") ReservationNotice? reservationNotice,
      @JsonKey(name: "cheering_notice") int? cheeringNotice,
      @JsonKey(name: "start_date") String startDate,
      String status});

  @override
  $ProgramCopyWith<$Res> get program;
  @override
  $ReservationNoticeCopyWith<$Res>? get reservationNotice;
}

/// @nodoc
class __$$_UserCareProgramCopyWithImpl<$Res>
    extends _$UserCareProgramCopyWithImpl<$Res, _$_UserCareProgram>
    implements _$$_UserCareProgramCopyWith<$Res> {
  __$$_UserCareProgramCopyWithImpl(
      _$_UserCareProgram _value, $Res Function(_$_UserCareProgram) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userCareProgramId = null,
    Object? program = null,
    Object? startDay = freezed,
    Object? reservationNotice = freezed,
    Object? cheeringNotice = freezed,
    Object? startDate = null,
    Object? status = null,
  }) {
    return _then(_$_UserCareProgram(
      userCareProgramId: null == userCareProgramId
          ? _value.userCareProgramId
          : userCareProgramId // ignore: cast_nullable_to_non_nullable
              as String,
      program: null == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as Program,
      startDay: freezed == startDay
          ? _value.startDay
          : startDay // ignore: cast_nullable_to_non_nullable
              as String?,
      reservationNotice: freezed == reservationNotice
          ? _value.reservationNotice
          : reservationNotice // ignore: cast_nullable_to_non_nullable
              as ReservationNotice?,
      cheeringNotice: freezed == cheeringNotice
          ? _value.cheeringNotice
          : cheeringNotice // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserCareProgram implements _UserCareProgram {
  _$_UserCareProgram(
      {@JsonKey(name: "user_care_program_id") required this.userCareProgramId,
      @JsonKey(name: "care_program") required this.program,
      @JsonKey(name: "start_day") this.startDay,
      @JsonKey(name: "reservation_notice") this.reservationNotice,
      @JsonKey(name: "cheering_notice") this.cheeringNotice,
      @JsonKey(name: "start_date") required this.startDate,
      required this.status});

  factory _$_UserCareProgram.fromJson(Map<String, dynamic> json) =>
      _$$_UserCareProgramFromJson(json);

  @override
  @JsonKey(name: "user_care_program_id")
  final String userCareProgramId;
  @override
  @JsonKey(name: "care_program")
  final Program program;
  @override
  @JsonKey(name: "start_day")
  final String? startDay;
  @override
  @JsonKey(name: "reservation_notice")
  final ReservationNotice? reservationNotice;
  @override
  @JsonKey(name: "cheering_notice")
  final int? cheeringNotice;
  @override
  @JsonKey(name: "start_date")
  final String startDate;
  @override
  final String status;

  @override
  String toString() {
    return 'UserCareProgram(userCareProgramId: $userCareProgramId, program: $program, startDay: $startDay, reservationNotice: $reservationNotice, cheeringNotice: $cheeringNotice, startDate: $startDate, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserCareProgram &&
            (identical(other.userCareProgramId, userCareProgramId) ||
                other.userCareProgramId == userCareProgramId) &&
            (identical(other.program, program) || other.program == program) &&
            (identical(other.startDay, startDay) ||
                other.startDay == startDay) &&
            (identical(other.reservationNotice, reservationNotice) ||
                other.reservationNotice == reservationNotice) &&
            (identical(other.cheeringNotice, cheeringNotice) ||
                other.cheeringNotice == cheeringNotice) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userCareProgramId, program,
      startDay, reservationNotice, cheeringNotice, startDate, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCareProgramCopyWith<_$_UserCareProgram> get copyWith =>
      __$$_UserCareProgramCopyWithImpl<_$_UserCareProgram>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserCareProgramToJson(
      this,
    );
  }
}

abstract class _UserCareProgram implements UserCareProgram {
  factory _UserCareProgram(
      {@JsonKey(name: "user_care_program_id")
          required final String userCareProgramId,
      @JsonKey(name: "care_program")
          required final Program program,
      @JsonKey(name: "start_day")
          final String? startDay,
      @JsonKey(name: "reservation_notice")
          final ReservationNotice? reservationNotice,
      @JsonKey(name: "cheering_notice")
          final int? cheeringNotice,
      @JsonKey(name: "start_date")
          required final String startDate,
      required final String status}) = _$_UserCareProgram;

  factory _UserCareProgram.fromJson(Map<String, dynamic> json) =
      _$_UserCareProgram.fromJson;

  @override
  @JsonKey(name: "user_care_program_id")
  String get userCareProgramId;
  @override
  @JsonKey(name: "care_program")
  Program get program;
  @override
  @JsonKey(name: "start_day")
  String? get startDay;
  @override
  @JsonKey(name: "reservation_notice")
  ReservationNotice? get reservationNotice;
  @override
  @JsonKey(name: "cheering_notice")
  int? get cheeringNotice;
  @override
  @JsonKey(name: "start_date")
  String get startDate;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_UserCareProgramCopyWith<_$_UserCareProgram> get copyWith =>
      throw _privateConstructorUsedError;
}
