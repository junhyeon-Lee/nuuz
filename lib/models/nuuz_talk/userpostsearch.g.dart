// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userpostsearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserPostSearch _$$_UserPostSearchFromJson(Map<String, dynamic> json) =>
    _$_UserPostSearch(
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => UserPost.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
    );

Map<String, dynamic> _$$_UserPostSearchToJson(_$_UserPostSearch instance) =>
    <String, dynamic>{
      'records': instance.records,
      'count': instance.count,
    };
