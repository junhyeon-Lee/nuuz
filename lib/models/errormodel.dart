
import 'package:freezed_annotation/freezed_annotation.dart';

part 'errormodel.freezed.dart';
part 'errormodel.g.dart';

@freezed
class ErrorModel with _$ErrorModel {
  factory ErrorModel({
    required bool status,
    required String message,
  }) = _ErrorModel;

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
}
