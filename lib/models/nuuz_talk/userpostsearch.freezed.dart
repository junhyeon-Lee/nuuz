// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userpostsearch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserPostSearch _$UserPostSearchFromJson(Map<String, dynamic> json) {
  return _UserPostSearch.fromJson(json);
}

/// @nodoc
mixin _$UserPostSearch {
  List<UserPost>? get records => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPostSearchCopyWith<UserPostSearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPostSearchCopyWith<$Res> {
  factory $UserPostSearchCopyWith(
          UserPostSearch value, $Res Function(UserPostSearch) then) =
      _$UserPostSearchCopyWithImpl<$Res, UserPostSearch>;
  @useResult
  $Res call({List<UserPost>? records, int count});
}

/// @nodoc
class _$UserPostSearchCopyWithImpl<$Res, $Val extends UserPostSearch>
    implements $UserPostSearchCopyWith<$Res> {
  _$UserPostSearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = freezed,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      records: freezed == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<UserPost>?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserPostSearchCopyWith<$Res>
    implements $UserPostSearchCopyWith<$Res> {
  factory _$$_UserPostSearchCopyWith(
          _$_UserPostSearch value, $Res Function(_$_UserPostSearch) then) =
      __$$_UserPostSearchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserPost>? records, int count});
}

/// @nodoc
class __$$_UserPostSearchCopyWithImpl<$Res>
    extends _$UserPostSearchCopyWithImpl<$Res, _$_UserPostSearch>
    implements _$$_UserPostSearchCopyWith<$Res> {
  __$$_UserPostSearchCopyWithImpl(
      _$_UserPostSearch _value, $Res Function(_$_UserPostSearch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? records = freezed,
    Object? count = null,
  }) {
    return _then(_$_UserPostSearch(
      records: freezed == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<UserPost>?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserPostSearch implements _UserPostSearch {
  _$_UserPostSearch({final List<UserPost>? records, required this.count})
      : _records = records;

  factory _$_UserPostSearch.fromJson(Map<String, dynamic> json) =>
      _$$_UserPostSearchFromJson(json);

  final List<UserPost>? _records;
  @override
  List<UserPost>? get records {
    final value = _records;
    if (value == null) return null;
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int count;

  @override
  String toString() {
    return 'UserPostSearch(records: $records, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserPostSearch &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_records), count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserPostSearchCopyWith<_$_UserPostSearch> get copyWith =>
      __$$_UserPostSearchCopyWithImpl<_$_UserPostSearch>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserPostSearchToJson(
      this,
    );
  }
}

abstract class _UserPostSearch implements UserPostSearch {
  factory _UserPostSearch(
      {final List<UserPost>? records,
      required final int count}) = _$_UserPostSearch;

  factory _UserPostSearch.fromJson(Map<String, dynamic> json) =
      _$_UserPostSearch.fromJson;

  @override
  List<UserPost>? get records;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$_UserPostSearchCopyWith<_$_UserPostSearch> get copyWith =>
      throw _privateConstructorUsedError;
}
