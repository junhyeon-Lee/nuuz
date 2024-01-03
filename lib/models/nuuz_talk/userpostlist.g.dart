// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userpostlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserPostList _$$_UserPostListFromJson(Map<String, dynamic> json) =>
    _$_UserPostList(
      status: json['status'] as bool,
      postData: json['postData'] == null
          ? null
          : UserPostSearch.fromJson(json['postData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserPostListToJson(_$_UserPostList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'postData': instance.postData,
    };
