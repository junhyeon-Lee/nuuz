import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';


part 'userpostsearch.freezed.dart';

part 'userpostsearch.g.dart';

@freezed
class UserPostSearch with _$UserPostSearch {
  factory UserPostSearch({

  List<UserPost>? records,
  required int count

}) = _UserPostSearch;

factory UserPostSearch.fromJson(Map<String, dynamic> json) => _$UserPostSearchFromJson(json);
}
