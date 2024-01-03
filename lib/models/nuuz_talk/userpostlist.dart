import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/nuuz_talk/userpostsearch.dart';


part 'userpostlist.freezed.dart';

part 'userpostlist.g.dart';

@freezed
class UserPostList with _$UserPostList {
  factory UserPostList({

    required bool status,
    UserPostSearch? postData

  }) = _UserPostList;

  factory UserPostList.fromJson(Map<String, dynamic> json) => _$UserPostListFromJson(json);
}
