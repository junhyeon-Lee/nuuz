// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termslist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TermsList _$$_TermsListFromJson(Map<String, dynamic> json) => _$_TermsList(
      form: (json['form'] as List<dynamic>?)
          ?.map((e) => Form.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$$_TermsListToJson(_$_TermsList instance) =>
    <String, dynamic>{
      'form': instance.form,
      'count': instance.count,
    };
