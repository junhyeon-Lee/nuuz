import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/partdetail.dart';
import 'package:nuuz/models/program.dart';
import 'package:nuuz/modules/nuzz_care/care_program/service/care_program_service.dart';
import 'package:nuuz/ui/theme/icon_path.dart';

class ProgramProvider extends AsyncNotifier<List<Program>> {
  // static final areas = jsonDecode('["neck care", "neck wrinkles"]');
  // static final areas2 = jsonDecode('["face care", "forehead"]');
  // static final partDetails = jsonDecode(
  //     '{"partName": "cheek","imageUrl": "https://lorempicsum.com","cartridgeType": "3mm","shots": 30}');
  // static final subprogram1 = jsonEncode( {
  //   "cartridgeType": "3mm",
  //   "expectedShots": 300,
  //   "timeInMin":"18",
  //   "areas": areas2,
  //   "partDetails": [partDetails, partDetails],
  //   "imageUrl": "https://text.com",
  // });
  // static final subprogram2 = jsonEncode( {
  //   "cartridgeType": "2mm",
  //   "timeInMin":"8",
  //   "areas": areas,
  //   "partDetails": [partDetails, partDetails],
  //   "imageUrl": "https://text.com",
  // });
  // final programList = [
  //   {
  //     "name": "Prog_Titl_0005".tr(),
  //     "description":"Prog_Desc_0000".tr(),
  //     "recommendation": "1 week",
  //     "image" : IconPath.programImage1,
  //     "subprograms":[
  //       jsonDecode(subprogram1),
  //       jsonDecode(subprogram2)
  //     ]
  //   },
  //   {
  //     "name": "Prog_Titl_0006".tr(),
  //     "description": "Prog_Desc_0001".tr(),
  //     "recommendation": "1 week",
  //     "image" : IconPath.programImage2,
  //     "subprograms":[
  //       jsonDecode(subprogram1),
  //       jsonDecode(subprogram2)
  //     ]
  //   },
  //   {
  //     "name": "Prog_Titl_0007".tr(),
  //     "description": "Prog_Desc_0002".tr(),
  //     "recommendation": "1 week",
  //     "image" : IconPath.programImage3,
  //     "subprograms":[
  //       jsonDecode(subprogram1),
  //       jsonDecode(subprogram2)
  //     ]
  //   },
  //   {
  //     "name": "Prog_Titl_0008".tr(),
  //     "description":"Prog_Desc_0003".tr(),
  //     "recommendation": "1 week",
  //     "image" : IconPath.programImage1,
  //     "subprograms":[
  //       jsonDecode(subprogram1),
  //       jsonDecode(subprogram2)
  //     ]
  //   },
  // ];
  final careProgramRepository = CareProgramRepository();
  @override
  FutureOr<List<Program>> build() {
    return _fetchPrograms();
  }

  _fetchPrograms() {
    return careProgramRepository.getCareProgramData();
    // return Future.delayed(
    //     const Duration(milliseconds: 500),
    //     () => programList.map((e) {
    //           return Program.fromJson(e);
    //         }).toList());
  }

  Future<Program?> getProgramByID(String id) {
    return careProgramRepository.getCareProgramById(id);
  }
}

final programController = AsyncNotifierProvider<ProgramProvider, List<Program>>(() => ProgramProvider());
