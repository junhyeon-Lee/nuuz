// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partdetail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PartDetail _$PartDetailFromJson(Map<String, dynamic> json) {
  return _PartDetail.fromJson(json);
}

/// @nodoc
mixin _$PartDetail {
  String get partName => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  String? get imageUrl => throw _privateConstructorUsedError;
  String get cartridgeType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<LineGroupDetail> get line_group_details =>
      throw _privateConstructorUsedError;
  int get shots => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartDetailCopyWith<PartDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartDetailCopyWith<$Res> {
  factory $PartDetailCopyWith(
          PartDetail value, $Res Function(PartDetail) then) =
      _$PartDetailCopyWithImpl<$Res, PartDetail>;
  @useResult
  $Res call(
      {String partName,
      String title,
      @JsonKey(name: "image") String? imageUrl,
      String cartridgeType,
      String description,
      List<LineGroupDetail> line_group_details,
      int shots});
}

/// @nodoc
class _$PartDetailCopyWithImpl<$Res, $Val extends PartDetail>
    implements $PartDetailCopyWith<$Res> {
  _$PartDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partName = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? cartridgeType = null,
    Object? description = null,
    Object? line_group_details = null,
    Object? shots = null,
  }) {
    return _then(_value.copyWith(
      partName: null == partName
          ? _value.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cartridgeType: null == cartridgeType
          ? _value.cartridgeType
          : cartridgeType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      line_group_details: null == line_group_details
          ? _value.line_group_details
          : line_group_details // ignore: cast_nullable_to_non_nullable
              as List<LineGroupDetail>,
      shots: null == shots
          ? _value.shots
          : shots // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PartDetailCopyWith<$Res>
    implements $PartDetailCopyWith<$Res> {
  factory _$$_PartDetailCopyWith(
          _$_PartDetail value, $Res Function(_$_PartDetail) then) =
      __$$_PartDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String partName,
      String title,
      @JsonKey(name: "image") String? imageUrl,
      String cartridgeType,
      String description,
      List<LineGroupDetail> line_group_details,
      int shots});
}

/// @nodoc
class __$$_PartDetailCopyWithImpl<$Res>
    extends _$PartDetailCopyWithImpl<$Res, _$_PartDetail>
    implements _$$_PartDetailCopyWith<$Res> {
  __$$_PartDetailCopyWithImpl(
      _$_PartDetail _value, $Res Function(_$_PartDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? partName = null,
    Object? title = null,
    Object? imageUrl = freezed,
    Object? cartridgeType = null,
    Object? description = null,
    Object? line_group_details = null,
    Object? shots = null,
  }) {
    return _then(_$_PartDetail(
      partName: null == partName
          ? _value.partName
          : partName // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cartridgeType: null == cartridgeType
          ? _value.cartridgeType
          : cartridgeType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      line_group_details: null == line_group_details
          ? _value._line_group_details
          : line_group_details // ignore: cast_nullable_to_non_nullable
              as List<LineGroupDetail>,
      shots: null == shots
          ? _value.shots
          : shots // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PartDetail implements _PartDetail {
  _$_PartDetail(
      {required this.partName,
      required this.title,
      @JsonKey(name: "image") required this.imageUrl,
      required this.cartridgeType,
      required this.description,
      required final List<LineGroupDetail> line_group_details,
      required this.shots})
      : _line_group_details = line_group_details;

  factory _$_PartDetail.fromJson(Map<String, dynamic> json) =>
      _$$_PartDetailFromJson(json);

  @override
  final String partName;
  @override
  final String title;
  @override
  @JsonKey(name: "image")
  final String? imageUrl;
  @override
  final String cartridgeType;
  @override
  final String description;
  final List<LineGroupDetail> _line_group_details;
  @override
  List<LineGroupDetail> get line_group_details {
    if (_line_group_details is EqualUnmodifiableListView)
      return _line_group_details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_line_group_details);
  }

  @override
  final int shots;

  @override
  String toString() {
    return 'PartDetail(partName: $partName, title: $title, imageUrl: $imageUrl, cartridgeType: $cartridgeType, description: $description, line_group_details: $line_group_details, shots: $shots)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PartDetail &&
            (identical(other.partName, partName) ||
                other.partName == partName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.cartridgeType, cartridgeType) ||
                other.cartridgeType == cartridgeType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._line_group_details, _line_group_details) &&
            (identical(other.shots, shots) || other.shots == shots));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      partName,
      title,
      imageUrl,
      cartridgeType,
      description,
      const DeepCollectionEquality().hash(_line_group_details),
      shots);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PartDetailCopyWith<_$_PartDetail> get copyWith =>
      __$$_PartDetailCopyWithImpl<_$_PartDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PartDetailToJson(
      this,
    );
  }
}

abstract class _PartDetail implements PartDetail {
  factory _PartDetail(
      {required final String partName,
      required final String title,
      @JsonKey(name: "image") required final String? imageUrl,
      required final String cartridgeType,
      required final String description,
      required final List<LineGroupDetail> line_group_details,
      required final int shots}) = _$_PartDetail;

  factory _PartDetail.fromJson(Map<String, dynamic> json) =
      _$_PartDetail.fromJson;

  @override
  String get partName;
  @override
  String get title;
  @override
  @JsonKey(name: "image")
  String? get imageUrl;
  @override
  String get cartridgeType;
  @override
  String get description;
  @override
  List<LineGroupDetail> get line_group_details;
  @override
  int get shots;
  @override
  @JsonKey(ignore: true)
  _$$_PartDetailCopyWith<_$_PartDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
