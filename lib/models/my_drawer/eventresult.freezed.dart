// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eventresult.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventResult _$EventResultFromJson(Map<String, dynamic> json) {
  return _EventResult.fromJson(json);
}

/// @nodoc
mixin _$EventResult {
  bool get status => throw _privateConstructorUsedError;
  EventList get eventData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventResultCopyWith<EventResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventResultCopyWith<$Res> {
  factory $EventResultCopyWith(
          EventResult value, $Res Function(EventResult) then) =
      _$EventResultCopyWithImpl<$Res, EventResult>;
  @useResult
  $Res call({bool status, EventList eventData});

  $EventListCopyWith<$Res> get eventData;
}

/// @nodoc
class _$EventResultCopyWithImpl<$Res, $Val extends EventResult>
    implements $EventResultCopyWith<$Res> {
  _$EventResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? eventData = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      eventData: null == eventData
          ? _value.eventData
          : eventData // ignore: cast_nullable_to_non_nullable
              as EventList,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventListCopyWith<$Res> get eventData {
    return $EventListCopyWith<$Res>(_value.eventData, (value) {
      return _then(_value.copyWith(eventData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventResultCopyWith<$Res>
    implements $EventResultCopyWith<$Res> {
  factory _$$_EventResultCopyWith(
          _$_EventResult value, $Res Function(_$_EventResult) then) =
      __$$_EventResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, EventList eventData});

  @override
  $EventListCopyWith<$Res> get eventData;
}

/// @nodoc
class __$$_EventResultCopyWithImpl<$Res>
    extends _$EventResultCopyWithImpl<$Res, _$_EventResult>
    implements _$$_EventResultCopyWith<$Res> {
  __$$_EventResultCopyWithImpl(
      _$_EventResult _value, $Res Function(_$_EventResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? eventData = null,
  }) {
    return _then(_$_EventResult(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      eventData: null == eventData
          ? _value.eventData
          : eventData // ignore: cast_nullable_to_non_nullable
              as EventList,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventResult implements _EventResult {
  _$_EventResult({required this.status, required this.eventData});

  factory _$_EventResult.fromJson(Map<String, dynamic> json) =>
      _$$_EventResultFromJson(json);

  @override
  final bool status;
  @override
  final EventList eventData;

  @override
  String toString() {
    return 'EventResult(status: $status, eventData: $eventData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventResult &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.eventData, eventData) ||
                other.eventData == eventData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, eventData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventResultCopyWith<_$_EventResult> get copyWith =>
      __$$_EventResultCopyWithImpl<_$_EventResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventResultToJson(
      this,
    );
  }
}

abstract class _EventResult implements EventResult {
  factory _EventResult(
      {required final bool status,
      required final EventList eventData}) = _$_EventResult;

  factory _EventResult.fromJson(Map<String, dynamic> json) =
      _$_EventResult.fromJson;

  @override
  bool get status;
  @override
  EventList get eventData;
  @override
  @JsonKey(ignore: true)
  _$$_EventResultCopyWith<_$_EventResult> get copyWith =>
      throw _privateConstructorUsedError;
}
