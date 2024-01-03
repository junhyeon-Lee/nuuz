// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get event_id => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get title_text => throw _privateConstructorUsedError;
  String get body_text => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;
  int get is_deleted => throw _privateConstructorUsedError;
  String get invoked_link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String event_id,
      String user_id,
      String image,
      String title_text,
      String body_text,
      String status,
      DateTime created_at,
      DateTime? updated_at,
      int is_deleted,
      String invoked_link});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event_id = null,
    Object? user_id = null,
    Object? image = null,
    Object? title_text = null,
    Object? body_text = null,
    Object? status = null,
    Object? created_at = null,
    Object? updated_at = freezed,
    Object? is_deleted = null,
    Object? invoked_link = null,
  }) {
    return _then(_value.copyWith(
      event_id: null == event_id
          ? _value.event_id
          : event_id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title_text: null == title_text
          ? _value.title_text
          : title_text // ignore: cast_nullable_to_non_nullable
              as String,
      body_text: null == body_text
          ? _value.body_text
          : body_text // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      is_deleted: null == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int,
      invoked_link: null == invoked_link
          ? _value.invoked_link
          : invoked_link // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$_EventCopyWith(_$_Event value, $Res Function(_$_Event) then) =
      __$$_EventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String event_id,
      String user_id,
      String image,
      String title_text,
      String body_text,
      String status,
      DateTime created_at,
      DateTime? updated_at,
      int is_deleted,
      String invoked_link});
}

/// @nodoc
class __$$_EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res, _$_Event>
    implements _$$_EventCopyWith<$Res> {
  __$$_EventCopyWithImpl(_$_Event _value, $Res Function(_$_Event) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event_id = null,
    Object? user_id = null,
    Object? image = null,
    Object? title_text = null,
    Object? body_text = null,
    Object? status = null,
    Object? created_at = null,
    Object? updated_at = freezed,
    Object? is_deleted = null,
    Object? invoked_link = null,
  }) {
    return _then(_$_Event(
      event_id: null == event_id
          ? _value.event_id
          : event_id // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title_text: null == title_text
          ? _value.title_text
          : title_text // ignore: cast_nullable_to_non_nullable
              as String,
      body_text: null == body_text
          ? _value.body_text
          : body_text // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      is_deleted: null == is_deleted
          ? _value.is_deleted
          : is_deleted // ignore: cast_nullable_to_non_nullable
              as int,
      invoked_link: null == invoked_link
          ? _value.invoked_link
          : invoked_link // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event implements _Event {
  _$_Event(
      {required this.event_id,
      required this.user_id,
      required this.image,
      required this.title_text,
      required this.body_text,
      required this.status,
      required this.created_at,
      required this.updated_at,
      required this.is_deleted,
      required this.invoked_link});

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  final String event_id;
  @override
  final String user_id;
  @override
  final String image;
  @override
  final String title_text;
  @override
  final String body_text;
  @override
  final String status;
  @override
  final DateTime created_at;
  @override
  final DateTime? updated_at;
  @override
  final int is_deleted;
  @override
  final String invoked_link;

  @override
  String toString() {
    return 'Event(event_id: $event_id, user_id: $user_id, image: $image, title_text: $title_text, body_text: $body_text, status: $status, created_at: $created_at, updated_at: $updated_at, is_deleted: $is_deleted, invoked_link: $invoked_link)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            (identical(other.event_id, event_id) ||
                other.event_id == event_id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title_text, title_text) ||
                other.title_text == title_text) &&
            (identical(other.body_text, body_text) ||
                other.body_text == body_text) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.is_deleted, is_deleted) ||
                other.is_deleted == is_deleted) &&
            (identical(other.invoked_link, invoked_link) ||
                other.invoked_link == invoked_link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      event_id,
      user_id,
      image,
      title_text,
      body_text,
      status,
      created_at,
      updated_at,
      is_deleted,
      invoked_link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCopyWith<_$_Event> get copyWith =>
      __$$_EventCopyWithImpl<_$_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  factory _Event(
      {required final String event_id,
      required final String user_id,
      required final String image,
      required final String title_text,
      required final String body_text,
      required final String status,
      required final DateTime created_at,
      required final DateTime? updated_at,
      required final int is_deleted,
      required final String invoked_link}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  String get event_id;
  @override
  String get user_id;
  @override
  String get image;
  @override
  String get title_text;
  @override
  String get body_text;
  @override
  String get status;
  @override
  DateTime get created_at;
  @override
  DateTime? get updated_at;
  @override
  int get is_deleted;
  @override
  String get invoked_link;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}
