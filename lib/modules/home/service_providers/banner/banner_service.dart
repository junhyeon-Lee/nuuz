import 'package:dio/dio.dart';
import 'package:nuuz/models/home/banner.dart';
import 'package:nuuz/models/home/bannerlist.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

class BannerRepository {
  static final BannerRepository _repository = BannerRepository._intrnal();

  factory BannerRepository() => _repository;

  BannerRepository._intrnal();

  Dio dio = HttpService().to();

  Future<List<Banner>?>? getBannerList() async {
    try {
      final response = await dio.get(APIConstants.getBanner,queryParameters: {"status": "active"});
      if (response.statusCode == 200) {
        List<Banner>? bannerList = BannerList.fromJson(response.data).resultData;
        List<Banner> sortedList=[];
        if(bannerList!=null){
          for(int j=1; j<bannerList.length+1; j++){
            for(int i=0; i<bannerList.length; i++){
              if(j==int.parse(bannerList[i].banner_order!)){
                sortedList.add(bannerList[i]);
              }
            }
          }
        }
        safePrint(sortedList);
       return sortedList;
      }
    } catch (e) {
      safePrint('배너 api error $e');
      return null;
    }
    return null;
  }
}