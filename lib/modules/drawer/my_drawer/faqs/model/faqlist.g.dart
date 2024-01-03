// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FaqList _$$_FaqListFromJson(Map<String, dynamic> json) => _$_FaqList(
      status: json['status'] as bool,
      resultData: (json['resultData'] as List<dynamic>)
          .map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FaqListToJson(_$_FaqList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'resultData': instance.resultData,
    };
