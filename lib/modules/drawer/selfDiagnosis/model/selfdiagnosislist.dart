
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:nuuz/modules/drawer/my_drawer/notice/model/notice.dart';
import 'package:nuuz/modules/drawer/selfDiagnosis/model/selfdiagnosis.dart';

part 'selfdiagnosislist.freezed.dart';

part 'selfdiagnosislist.g.dart';

@freezed
class SelfDiagnosisList with _$SelfDiagnosisList {
  factory SelfDiagnosisList({
    required bool status,
    required List<SelfDiagnosisModel> selfDiagnosis,
  }) = _SelfDiagnosisList;

  factory SelfDiagnosisList.fromJson(Map<String, dynamic> json) => _$SelfDiagnosisListFromJson(json);
}
