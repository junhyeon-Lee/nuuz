
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuuz/models/partdetail.dart';

part 'subprogram.freezed.dart';
part 'subprogram.g.dart';

@freezed
class Subprogram with _$Subprogram {
  factory Subprogram({
    required String cartridgeType,
    int? expectedShots,
    required String? timeInMin,
    required String? imageUrl,
    required List<String> areas,
    required List<PartDetail> partDetails,
  }) = _Subprogram;
	
  factory Subprogram.fromJson(Map<String, dynamic> json) =>
			_$SubprogramFromJson(json);
}
