// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FormList _$$_FormListFromJson(Map<String, dynamic> json) => _$_FormList(
      status: json['status'] as bool?,
      resultData: json['resultData'] == null
          ? null
          : TermsList.fromJson(json['resultData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FormListToJson(_$_FormList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'resultData': instance.resultData,
    };
