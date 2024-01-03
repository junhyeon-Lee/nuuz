
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/modules/drawer/my_drawer/faqs/model/faq.dart';



part 'faqlist.freezed.dart';

part 'faqlist.g.dart';

@freezed
class FaqList with _$FaqList {
  factory FaqList({
    required bool status,
    required List<FaqModel> resultData,
  }) = _FaqList;

  factory FaqList.fromJson(Map<String, dynamic> json) => _$FaqListFromJson(json);
}
