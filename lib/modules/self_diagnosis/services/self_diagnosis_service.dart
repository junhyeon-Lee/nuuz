import 'package:dio/dio.dart';
import 'package:nuuz/util/dio/api_constants.dart';

import '../../../util/dio/dio_api.dart';
import '../../../util/log_print.dart';

class SelfDiagnosisService {
  Dio dio = HttpService().to();
  var jsondata;

  Future<bool> postSelfDiagnosis(Map<String, dynamic> responseData, token) async {
    try {
      safePrint("postSelfDiagnosis==responseData=>$responseData");
      final response = await dio.post(APIConstants.getCreateDiagnosis, data: responseData, options: Options(headers: {"token": token}));
      if (response.statusCode == 200) {
        return true;
      }
      safePrint("postSelfDiagnosis===>$response");
    } catch (e) {
      safePrint("postSelfDiagnosis====error==$e");
    }
    return false;
  }
/*{
  "skinType": "Oily Skin",
  "skinConcerns": [
 "Marionette Lines Wrinkles", "Crow's Feet Wrinkles", "Tear Troughs Wrinkles"
  ],
  "detailedConcern": [
  "Sebum", "Lack of moisture", "Skin blemish", "Blackhead"
  ],
  "frequentlyReplaced": "No",
  "colorMakeup": "Always",
  "skinCareHabits": [
  "
  Care products replace often"
  ]
  }*/
}
