// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userpost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserPost _$UserPostFromJson(Map<String, dynamic> json) {
  return _UserPost.fromJson(json);
}

/// @nodoc
mixin _$UserPost {
  @JsonKey(name: "post_id")
  String get postId => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String? get createdAt => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String>? get hashtag => throw _privateConstructorUsedError;
  List<String>? get items => throw _privateConstructorUsedError;
  @JsonKey(name: "image")
  List<String> get imageUrls => throw _privateConstructorUsedError;
  Category get category => throw _privateConstructorUsedError;
  @JsonKey(name: "product_id")
  List<String> get productIds => throw _privateConstructorUsedError;
  @JsonKey(name: "program_id")
  List<String> get programIds => throw _privateConstructorUsedError;
  @JsonKey(name: "review_id")
  List<String> get reviewIds => throw _privateConstructorUsedError;
  @JsonKey(name: "likes_count")
  int get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: "comments_count")
  int get commentsCount => throw _privateConstructorUsedError;
  @JsonKey(name: "latest_comment")
  LatestComment? get latestComment => throw _privateConstructorUsedError;
  @JsonKey(name: "user")
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(name: "react_id")
  String? get reactId => throw _privateConstructorUsedError;
  @JsonKey(name: "html")
  String? get html => throw _privateConstructorUsedError;
  bool? get isLiked => throw _privateConstructorUsedError;
  int? get is_popular => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPostCopyWith<UserPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPostCopyWith<$Res> {
  factory $UserPostCopyWith(UserPost value, $Res Function(UserPost) then) =
      _$UserPostCopyWithImpl<$Res, UserPost>;
  @useResult
  $Res call(
      {@JsonKey(name: "post_id") String postId,
      @JsonKey(name: "user_id") String userId,
      @JsonKey(name: "created_at") String? createdAt,
      String? title,
      String name,
      List<String>? hashtag,
      List<String>? items,
      @JsonKey(name: "image") List<String> imageUrls,
      Category category,
      @JsonKey(name: "product_id") List<String> productIds,
      @JsonKey(name: "program_id") List<String> programIds,
      @JsonKey(name: "review_id") List<String> reviewIds,
      @JsonKey(name: "likes_count") int likesCount,
      @JsonKey(name: "comments_count") int commentsCount,
      @JsonKey(name: "latest_comment") LatestComment? latestComment,
      @JsonKey(name: "user") User? user,
      @JsonKey(name: "react_id") String? reactId,
      @JsonKey(name: "html") String? html,
      bool? isLiked,
      int? is_popular});

  $CategoryCopyWith<$Res> get category;
  $LatestCommentCopyWith<$Res>? get latestComment;
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserPostCopyWithImpl<$Res, $Val extends UserPost>
    implements $UserPostCopyWith<$Res> {
  _$UserPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? name = null,
    Object? hashtag = freezed,
    Object? items = freezed,
    Object? imageUrls = null,
    Object? category = null,
    Object? productIds = null,
    Object? programIds = null,
    Object? reviewIds = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? latestComment = freezed,
    Object? user = freezed,
    Object? reactId = freezed,
    Object? html = freezed,
    Object? isLiked = freezed,
    Object? is_popular = freezed,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hashtag: freezed == hashtag
          ? _value.hashtag
          : hashtag // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      productIds: null == productIds
          ? _value.productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      programIds: null == programIds
          ? _value.programIds
          : programIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewIds: null == reviewIds
          ? _value.reviewIds
          : reviewIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      latestComment: freezed == latestComment
          ? _value.latestComment
          : latestComment // ignore: cast_nullable_to_non_nullable
              as LatestComment?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      reactId: freezed == reactId
          ? _value.reactId
          : reactId // ignore: cast_nullable_to_non_nullable
              as String?,
      html: freezed == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      is_popular: freezed == is_popular
          ? _value.is_popular
          : is_popular // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LatestCommentCopyWith<$Res>? get latestComment {
    if (_value.latestComment == null) {
      return null;
    }

    return $LatestCommentCopyWith<$Res>(_value.latestComment!, (value) {
      return _then(_value.copyWith(latestComment: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserPostCopyWith<$Res> implements $UserPostCopyWith<$Res> {
  factory _$$_UserPostCopyWith(
          _$_UserPost value, $Res Function(_$_UserPost) then) =
      __$$_UserPostCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "post_id") String postId,
      @JsonKey(name: "user_id") String userId,
      @JsonKey(name: "created_at") String? createdAt,
      String? title,
      String name,
      List<String>? hashtag,
      List<String>? items,
      @JsonKey(name: "image") List<String> imageUrls,
      Category category,
      @JsonKey(name: "product_id") List<String> productIds,
      @JsonKey(name: "program_id") List<String> programIds,
      @JsonKey(name: "review_id") List<String> reviewIds,
      @JsonKey(name: "likes_count") int likesCount,
      @JsonKey(name: "comments_count") int commentsCount,
      @JsonKey(name: "latest_comment") LatestComment? latestComment,
      @JsonKey(name: "user") User? user,
      @JsonKey(name: "react_id") String? reactId,
      @JsonKey(name: "html") String? html,
      bool? isLiked,
      int? is_popular});

  @override
  $CategoryCopyWith<$Res> get category;
  @override
  $LatestCommentCopyWith<$Res>? get latestComment;
  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_UserPostCopyWithImpl<$Res>
    extends _$UserPostCopyWithImpl<$Res, _$_UserPost>
    implements _$$_UserPostCopyWith<$Res> {
  __$$_UserPostCopyWithImpl(
      _$_UserPost _value, $Res Function(_$_UserPost) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? createdAt = freezed,
    Object? title = freezed,
    Object? name = null,
    Object? hashtag = freezed,
    Object? items = freezed,
    Object? imageUrls = null,
    Object? category = null,
    Object? productIds = null,
    Object? programIds = null,
    Object? reviewIds = null,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? latestComment = freezed,
    Object? user = freezed,
    Object? reactId = freezed,
    Object? html = freezed,
    Object? isLiked = freezed,
    Object? is_popular = freezed,
  }) {
    return _then(_$_UserPost(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      hashtag: freezed == hashtag
          ? _value._hashtag
          : hashtag // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      productIds: null == productIds
          ? _value._productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      programIds: null == programIds
          ? _value._programIds
          : programIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reviewIds: null == reviewIds
          ? _value._reviewIds
          : reviewIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      latestComment: freezed == latestComment
          ? _value.latestComment
          : latestComment // ignore: cast_nullable_to_non_nullable
              as LatestComment?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      reactId: freezed == reactId
          ? _value.reactId
          : reactId // ignore: cast_nullable_to_non_nullable
              as String?,
      html: freezed == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      is_popular: freezed == is_popular
          ? _value.is_popular
          : is_popular // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserPost implements _UserPost {
  _$_UserPost(
      {@JsonKey(name: "post_id") required this.postId,
      @JsonKey(name: "user_id") required this.userId,
      @JsonKey(name: "created_at") this.createdAt,
      required this.title,
      required this.name,
      final List<String>? hashtag,
      final List<String>? items,
      @JsonKey(name: "image") required final List<String> imageUrls,
      required this.category,
      @JsonKey(name: "product_id") required final List<String> productIds,
      @JsonKey(name: "program_id") required final List<String> programIds,
      @JsonKey(name: "review_id") required final List<String> reviewIds,
      @JsonKey(name: "likes_count") required this.likesCount,
      @JsonKey(name: "comments_count") required this.commentsCount,
      @JsonKey(name: "latest_comment") this.latestComment,
      @JsonKey(name: "user") this.user,
      @JsonKey(name: "react_id") this.reactId,
      @JsonKey(name: "html") this.html,
      this.isLiked,
      this.is_popular})
      : _hashtag = hashtag,
        _items = items,
        _imageUrls = imageUrls,
        _productIds = productIds,
        _programIds = programIds,
        _reviewIds = reviewIds;

  factory _$_UserPost.fromJson(Map<String, dynamic> json) =>
      _$$_UserPostFromJson(json);

  @override
  @JsonKey(name: "post_id")
  final String postId;
  @override
  @JsonKey(name: "user_id")
  final String userId;
  @override
  @JsonKey(name: "created_at")
  final String? createdAt;
  @override
  final String? title;
  @override
  final String name;
  final List<String>? _hashtag;
  @override
  List<String>? get hashtag {
    final value = _hashtag;
    if (value == null) return null;
    if (_hashtag is EqualUnmodifiableListView) return _hashtag;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _items;
  @override
  List<String>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _imageUrls;
  @override
  @JsonKey(name: "image")
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final Category category;
  final List<String> _productIds;
  @override
  @JsonKey(name: "product_id")
  List<String> get productIds {
    if (_productIds is EqualUnmodifiableListView) return _productIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productIds);
  }

  final List<String> _programIds;
  @override
  @JsonKey(name: "program_id")
  List<String> get programIds {
    if (_programIds is EqualUnmodifiableListView) return _programIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programIds);
  }

  final List<String> _reviewIds;
  @override
  @JsonKey(name: "review_id")
  List<String> get reviewIds {
    if (_reviewIds is EqualUnmodifiableListView) return _reviewIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviewIds);
  }

  @override
  @JsonKey(name: "likes_count")
  final int likesCount;
  @override
  @JsonKey(name: "comments_count")
  final int commentsCount;
  @override
  @JsonKey(name: "latest_comment")
  final LatestComment? latestComment;
  @override
  @JsonKey(name: "user")
  final User? user;
  @override
  @JsonKey(name: "react_id")
  final String? reactId;
  @override
  @JsonKey(name: "html")
  final String? html;
  @override
  final bool? isLiked;
  @override
  final int? is_popular;

  @override
  String toString() {
    return 'UserPost(postId: $postId, userId: $userId, createdAt: $createdAt, title: $title, name: $name, hashtag: $hashtag, items: $items, imageUrls: $imageUrls, category: $category, productIds: $productIds, programIds: $programIds, reviewIds: $reviewIds, likesCount: $likesCount, commentsCount: $commentsCount, latestComment: $latestComment, user: $user, reactId: $reactId, html: $html, isLiked: $isLiked, is_popular: $is_popular)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserPost &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._hashtag, _hashtag) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._productIds, _productIds) &&
            const DeepCollectionEquality()
                .equals(other._programIds, _programIds) &&
            const DeepCollectionEquality()
                .equals(other._reviewIds, _reviewIds) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.latestComment, latestComment) ||
                other.latestComment == latestComment) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.reactId, reactId) || other.reactId == reactId) &&
            (identical(other.html, html) || other.html == html) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.is_popular, is_popular) ||
                other.is_popular == is_popular));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        postId,
        userId,
        createdAt,
        title,
        name,
        const DeepCollectionEquality().hash(_hashtag),
        const DeepCollectionEquality().hash(_items),
        const DeepCollectionEquality().hash(_imageUrls),
        category,
        const DeepCollectionEquality().hash(_productIds),
        const DeepCollectionEquality().hash(_programIds),
        const DeepCollectionEquality().hash(_reviewIds),
        likesCount,
        commentsCount,
        latestComment,
        user,
        reactId,
        html,
        isLiked,
        is_popular
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserPostCopyWith<_$_UserPost> get copyWith =>
      __$$_UserPostCopyWithImpl<_$_UserPost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserPostToJson(
      this,
    );
  }
}

abstract class _UserPost implements UserPost {
  factory _UserPost(
      {@JsonKey(name: "post_id") required final String postId,
      @JsonKey(name: "user_id") required final String userId,
      @JsonKey(name: "created_at") final String? createdAt,
      required final String? title,
      required final String name,
      final List<String>? hashtag,
      final List<String>? items,
      @JsonKey(name: "image") required final List<String> imageUrls,
      required final Category category,
      @JsonKey(name: "product_id") required final List<String> productIds,
      @JsonKey(name: "program_id") required final List<String> programIds,
      @JsonKey(name: "review_id") required final List<String> reviewIds,
      @JsonKey(name: "likes_count") required final int likesCount,
      @JsonKey(name: "comments_count") required final int commentsCount,
      @JsonKey(name: "latest_comment") final LatestComment? latestComment,
      @JsonKey(name: "user") final User? user,
      @JsonKey(name: "react_id") final String? reactId,
      @JsonKey(name: "html") final String? html,
      final bool? isLiked,
      final int? is_popular}) = _$_UserPost;

  factory _UserPost.fromJson(Map<String, dynamic> json) = _$_UserPost.fromJson;

  @override
  @JsonKey(name: "post_id")
  String get postId;
  @override
  @JsonKey(name: "user_id")
  String get userId;
  @override
  @JsonKey(name: "created_at")
  String? get createdAt;
  @override
  String? get title;
  @override
  String get name;
  @override
  List<String>? get hashtag;
  @override
  List<String>? get items;
  @override
  @JsonKey(name: "image")
  List<String> get imageUrls;
  @override
  Category get category;
  @override
  @JsonKey(name: "product_id")
  List<String> get productIds;
  @override
  @JsonKey(name: "program_id")
  List<String> get programIds;
  @override
  @JsonKey(name: "review_id")
  List<String> get reviewIds;
  @override
  @JsonKey(name: "likes_count")
  int get likesCount;
  @override
  @JsonKey(name: "comments_count")
  int get commentsCount;
  @override
  @JsonKey(name: "latest_comment")
  LatestComment? get latestComment;
  @override
  @JsonKey(name: "user")
  User? get user;
  @override
  @JsonKey(name: "react_id")
  String? get reactId;
  @override
  @JsonKey(name: "html")
  String? get html;
  @override
  bool? get isLiked;
  @override
  int? get is_popular;
  @override
  @JsonKey(ignore: true)
  _$$_UserPostCopyWith<_$_UserPost> get copyWith =>
      throw _privateConstructorUsedError;
}
