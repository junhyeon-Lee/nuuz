// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservationnotice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReservationNotice _$ReservationNoticeFromJson(Map<String, dynamic> json) {
  return _ReservationNotice.fromJson(json);
}

/// @nodoc
mixin _$ReservationNotice {
  @JsonKey(name: "send_reminder")
  int? get sendReminder => throw _privateConstructorUsedError;
  @JsonKey(name: "reminder_time")
  List<String>? get reminderTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationNoticeCopyWith<ReservationNotice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationNoticeCopyWith<$Res> {
  factory $ReservationNoticeCopyWith(
          ReservationNotice value, $Res Function(ReservationNotice) then) =
      _$ReservationNoticeCopyWithImpl<$Res, ReservationNotice>;
  @useResult
  $Res call(
      {@JsonKey(name: "send_reminder") int? sendReminder,
      @JsonKey(name: "reminder_time") List<String>? reminderTime});
}

/// @nodoc
class _$ReservationNoticeCopyWithImpl<$Res, $Val extends ReservationNotice>
    implements $ReservationNoticeCopyWith<$Res> {
  _$ReservationNoticeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sendReminder = freezed,
    Object? reminderTime = freezed,
  }) {
    return _then(_value.copyWith(
      sendReminder: freezed == sendReminder
          ? _value.sendReminder
          : sendReminder // ignore: cast_nullable_to_non_nullable
              as int?,
      reminderTime: freezed == reminderTime
          ? _value.reminderTime
          : reminderTime // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReservationNoticeCopyWith<$Res>
    implements $ReservationNoticeCopyWith<$Res> {
  factory _$$_ReservationNoticeCopyWith(_$_ReservationNotice value,
          $Res Function(_$_ReservationNotice) then) =
      __$$_ReservationNoticeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "send_reminder") int? sendReminder,
      @JsonKey(name: "reminder_time") List<String>? reminderTime});
}

/// @nodoc
class __$$_ReservationNoticeCopyWithImpl<$Res>
    extends _$ReservationNoticeCopyWithImpl<$Res, _$_ReservationNotice>
    implements _$$_ReservationNoticeCopyWith<$Res> {
  __$$_ReservationNoticeCopyWithImpl(
      _$_ReservationNotice _value, $Res Function(_$_ReservationNotice) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sendReminder = freezed,
    Object? reminderTime = freezed,
  }) {
    return _then(_$_ReservationNotice(
      sendReminder: freezed == sendReminder
          ? _value.sendReminder
          : sendReminder // ignore: cast_nullable_to_non_nullable
              as int?,
      reminderTime: freezed == reminderTime
          ? _value._reminderTime
          : reminderTime // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReservationNotice implements _ReservationNotice {
  _$_ReservationNotice(
      {@JsonKey(name: "send_reminder") this.sendReminder,
      @JsonKey(name: "reminder_time") final List<String>? reminderTime})
      : _reminderTime = reminderTime;

  factory _$_ReservationNotice.fromJson(Map<String, dynamic> json) =>
      _$$_ReservationNoticeFromJson(json);

  @override
  @JsonKey(name: "send_reminder")
  final int? sendReminder;
  final List<String>? _reminderTime;
  @override
  @JsonKey(name: "reminder_time")
  List<String>? get reminderTime {
    final value = _reminderTime;
    if (value == null) return null;
    if (_reminderTime is EqualUnmodifiableListView) return _reminderTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ReservationNotice(sendReminder: $sendReminder, reminderTime: $reminderTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReservationNotice &&
            (identical(other.sendReminder, sendReminder) ||
                other.sendReminder == sendReminder) &&
            const DeepCollectionEquality()
                .equals(other._reminderTime, _reminderTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sendReminder,
      const DeepCollectionEquality().hash(_reminderTime));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReservationNoticeCopyWith<_$_ReservationNotice> get copyWith =>
      __$$_ReservationNoticeCopyWithImpl<_$_ReservationNotice>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReservationNoticeToJson(
      this,
    );
  }
}

abstract class _ReservationNotice implements ReservationNotice {
  factory _ReservationNotice(
          {@JsonKey(name: "send_reminder") final int? sendReminder,
          @JsonKey(name: "reminder_time") final List<String>? reminderTime}) =
      _$_ReservationNotice;

  factory _ReservationNotice.fromJson(Map<String, dynamic> json) =
      _$_ReservationNotice.fromJson;

  @override
  @JsonKey(name: "send_reminder")
  int? get sendReminder;
  @override
  @JsonKey(name: "reminder_time")
  List<String>? get reminderTime;
  @override
  @JsonKey(ignore: true)
  _$$_ReservationNoticeCopyWith<_$_ReservationNotice> get copyWith =>
      throw _privateConstructorUsedError;
}
