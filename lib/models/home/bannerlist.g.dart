// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bannerlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BannerList _$$_BannerListFromJson(Map<String, dynamic> json) =>
    _$_BannerList(
      status: json['status'] as bool,
      resultData: (json['resultData'] as List<dynamic>?)
          ?.map((e) => Banner.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BannerListToJson(_$_BannerList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'resultData': instance.resultData,
    };
