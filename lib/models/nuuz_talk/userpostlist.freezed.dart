// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userpostlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserPostList _$UserPostListFromJson(Map<String, dynamic> json) {
  return _UserPostList.fromJson(json);
}

/// @nodoc
mixin _$UserPostList {
  bool get status => throw _privateConstructorUsedError;
  UserPostSearch? get postData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPostListCopyWith<UserPostList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPostListCopyWith<$Res> {
  factory $UserPostListCopyWith(
          UserPostList value, $Res Function(UserPostList) then) =
      _$UserPostListCopyWithImpl<$Res, UserPostList>;
  @useResult
  $Res call({bool status, UserPostSearch? postData});

  $UserPostSearchCopyWith<$Res>? get postData;
}

/// @nodoc
class _$UserPostListCopyWithImpl<$Res, $Val extends UserPostList>
    implements $UserPostListCopyWith<$Res> {
  _$UserPostListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? postData = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      postData: freezed == postData
          ? _value.postData
          : postData // ignore: cast_nullable_to_non_nullable
              as UserPostSearch?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserPostSearchCopyWith<$Res>? get postData {
    if (_value.postData == null) {
      return null;
    }

    return $UserPostSearchCopyWith<$Res>(_value.postData!, (value) {
      return _then(_value.copyWith(postData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserPostListCopyWith<$Res>
    implements $UserPostListCopyWith<$Res> {
  factory _$$_UserPostListCopyWith(
          _$_UserPostList value, $Res Function(_$_UserPostList) then) =
      __$$_UserPostListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool status, UserPostSearch? postData});

  @override
  $UserPostSearchCopyWith<$Res>? get postData;
}

/// @nodoc
class __$$_UserPostListCopyWithImpl<$Res>
    extends _$UserPostListCopyWithImpl<$Res, _$_UserPostList>
    implements _$$_UserPostListCopyWith<$Res> {
  __$$_UserPostListCopyWithImpl(
      _$_UserPostList _value, $Res Function(_$_UserPostList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? postData = freezed,
  }) {
    return _then(_$_UserPostList(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
      postData: freezed == postData
          ? _value.postData
          : postData // ignore: cast_nullable_to_non_nullable
              as UserPostSearch?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserPostList implements _UserPostList {
  _$_UserPostList({required this.status, this.postData});

  factory _$_UserPostList.fromJson(Map<String, dynamic> json) =>
      _$$_UserPostListFromJson(json);

  @override
  final bool status;
  @override
  final UserPostSearch? postData;

  @override
  String toString() {
    return 'UserPostList(status: $status, postData: $postData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserPostList &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.postData, postData) ||
                other.postData == postData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, postData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserPostListCopyWith<_$_UserPostList> get copyWith =>
      __$$_UserPostListCopyWithImpl<_$_UserPostList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserPostListToJson(
      this,
    );
  }
}

abstract class _UserPostList implements UserPostList {
  factory _UserPostList(
      {required final bool status,
      final UserPostSearch? postData}) = _$_UserPostList;

  factory _UserPostList.fromJson(Map<String, dynamic> json) =
      _$_UserPostList.fromJson;

  @override
  bool get status;
  @override
  UserPostSearch? get postData;
  @override
  @JsonKey(ignore: true)
  _$$_UserPostListCopyWith<_$_UserPostList> get copyWith =>
      throw _privateConstructorUsedError;
}
