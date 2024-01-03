// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favprogramlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavProgramList _$$_FavProgramListFromJson(Map<String, dynamic> json) =>
    _$_FavProgramList(
      status: json['status'] as bool,
      favouriteData: (json['favouriteData'] as List<dynamic>)
          .map((e) => FavProgramModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FavProgramListToJson(_$_FavProgramList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'favouriteData': instance.favouriteData,
    };
