import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/home/banner.dart';
import 'package:nuuz/models/home/bannerlist.dart';
import 'package:nuuz/models/home/cheerupuser.dart';
import 'package:nuuz/modules/home/nuuz_home/home_appbar.dart';
import 'package:nuuz/modules/home/service_providers/banner/banner_service.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/util/log_print.dart';

final bannerProvider = StateNotifierProvider<BannerProvider, List<bool>>((ref) {
  return BannerProvider();
});

class BannerProvider extends StateNotifier<List<bool>> {
  BannerProvider() : super([false, false, false, false]);

  changeIndex(int index) {
    if (index == 0) {
      state = [true, false, false, false];
    }
    else if (index == 1) {
      state = [false, true, false, false];
    }
    else if (index == 2) {
      state = [false, false, true, false];
    }
    else {
      state = [false, false, false, true];
    }
  }

}

final bannerIndexProvider = StateNotifierProvider<BannerIndexProvider, int>((ref) {
  return BannerIndexProvider();
});

class BannerIndexProvider extends StateNotifier<int> {
  BannerIndexProvider() : super(0);

  changeBannerIndex(int index) {
    state = index;
  }

}

final bannerListProvider = StateNotifierProvider<BannerListProvider, List<Banner>>((ref) {
  return BannerListProvider();
});

class BannerListProvider extends StateNotifier<List<Banner>> {
  BannerListProvider() : super([]);
  BannerRepository repository = BannerRepository();

  List<String> bgImage = [];
  List<String> bannerImage =[];
  List<bool> bannerState = [];
  List<BannerImage> bannerImagesList=[];
  List<Banner> bannerList=[];



  getBannerList() async {
    bannerList = await repository.getBannerList()??[];

   state = bannerList!;

   if(state.isNotEmpty){
     for(int i=0; i<state.length; i++){
       bannerImage.add(state[i].banner_image!);
     }
     for(int i =0; i<state.length;i++){
       switch(i%4){
         case 0 : bgImage.add(IconPath.homeBanner_01); break;
         case 1 : bgImage.add(IconPath.homeBanner_02); break;
         case 2 : bgImage.add(IconPath.homeBanner_03); break;
         case 3 : bgImage.add(IconPath.homeBanner_04); break;
       }
       bannerImagesList.add(BannerImage(bannerImage[i], bgImage[i], state[i].link_value, state[i].link));
       if(i==0){
         bannerState.add(true);
       }else{
         bannerState.add(false);
       }
     }
   }
   // else{
   //   bannerImage = [IconPath.banner01,IconPath.banner02,IconPath.banner03,IconPath.banner04];
   //   for(int i =0; i<bannerImage.length;i++){
   //     switch(i%4){
   //       case 0 : bgImage.add(IconPath.homeBanner_01); break;
   //       case 1 : bgImage.add(IconPath.homeBanner_02); break;
   //       case 2 : bgImage.add(IconPath.homeBanner_03); break;
   //       case 3 : bgImage.add(IconPath.homeBanner_04); break;
   //     }
   //     bannerImagesList.add(BannerImage(bannerImage[i], bgImage[i],state[i].link_value, state[i].link));
   //     if(i==0){
   //       bannerState.add(true);
   //     }else{
   //       bannerState.add(false);
   //     }
   //   }
   //
   // }

   for(int i=0; i<state.length; i++){
     safePrint('배너 id $i');
     safePrint(state[i].banner_id);
   }
  }

}




final cheerUpProvider = StateNotifierProvider<CheerUpProvider, List<double>>((ref) {
  return CheerUpProvider();
});

class CheerUpProvider extends StateNotifier<List<double>> {
  CheerUpProvider() : super([1, 1, 1,1,1, 1, 1, 1,1, 1]);

  setInitData(int length){
    for(int i=0; i<length; i++){
      state[i] =1;
    }
  }

  itemDelete(int index){
    state[index] = 0;
  }
}

final cheerUpFadeProvider = StateNotifierProvider<CheerUpFadeProvider, List<bool>>((ref) {
  return CheerUpFadeProvider();
});

class CheerUpFadeProvider extends StateNotifier<List<bool>> {
  CheerUpFadeProvider() : super([true, true, true,true,true, true, true, true,true, true]);

  setInitData(int length){
    for(int i=0; i<length; i++){
      state[i] =true;
    }
  }

  itemDelete(int index){
    state[index] = false;
  }

  bool check(){
    int counter = 0;
    for(int i=0; i<10; i++){
      if(state[i]==false){
        counter++;
      }
    }
    if(counter==9){
      return false;
    }else{
      return true;
    }
  }

}

final cheerVisibleProvider = StateNotifierProvider<CheerVisibleProvider, bool>((ref) {
  return CheerVisibleProvider();
});

class CheerVisibleProvider extends StateNotifier<bool> {
  CheerVisibleProvider() : super(true);


  visible(bool value){
    state = value;
  }



}





