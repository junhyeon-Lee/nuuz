// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eventlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventList _$EventListFromJson(Map<String, dynamic> json) {
  return _EventList.fromJson(json);
}

/// @nodoc
mixin _$EventList {
  int get count => throw _privateConstructorUsedError;
  List<Event> get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventListCopyWith<EventList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventListCopyWith<$Res> {
  factory $EventListCopyWith(EventList value, $Res Function(EventList) then) =
      _$EventListCopyWithImpl<$Res, EventList>;
  @useResult
  $Res call({int count, List<Event> result});
}

/// @nodoc
class _$EventListCopyWithImpl<$Res, $Val extends EventList>
    implements $EventListCopyWith<$Res> {
  _$EventListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventListCopyWith<$Res> implements $EventListCopyWith<$Res> {
  factory _$$_EventListCopyWith(
          _$_EventList value, $Res Function(_$_EventList) then) =
      __$$_EventListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int count, List<Event> result});
}

/// @nodoc
class __$$_EventListCopyWithImpl<$Res>
    extends _$EventListCopyWithImpl<$Res, _$_EventList>
    implements _$$_EventListCopyWith<$Res> {
  __$$_EventListCopyWithImpl(
      _$_EventList _value, $Res Function(_$_EventList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? result = null,
  }) {
    return _then(_$_EventList(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      result: null == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventList implements _EventList {
  _$_EventList({required this.count, required final List<Event> result})
      : _result = result;

  factory _$_EventList.fromJson(Map<String, dynamic> json) =>
      _$$_EventListFromJson(json);

  @override
  final int count;
  final List<Event> _result;
  @override
  List<Event> get result {
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_result);
  }

  @override
  String toString() {
    return 'EventList(count: $count, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventList &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, count, const DeepCollectionEquality().hash(_result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventListCopyWith<_$_EventList> get copyWith =>
      __$$_EventListCopyWithImpl<_$_EventList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventListToJson(
      this,
    );
  }
}

abstract class _EventList implements EventList {
  factory _EventList(
      {required final int count,
      required final List<Event> result}) = _$_EventList;

  factory _EventList.fromJson(Map<String, dynamic> json) =
      _$_EventList.fromJson;

  @override
  int get count;
  @override
  List<Event> get result;
  @override
  @JsonKey(ignore: true)
  _$$_EventListCopyWith<_$_EventList> get copyWith =>
      throw _privateConstructorUsedError;
}
