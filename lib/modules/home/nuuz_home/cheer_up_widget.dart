import 'dart:math';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuuz/models/home/cheerup.dart';
import 'package:nuuz/models/home/cheeruplist.dart';
import 'package:nuuz/models/home/cheerupuser.dart';
import 'package:nuuz/models/home/mycheerup.dart';
import 'package:nuuz/models/home/mycheeruplist.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/common/padding_sizedbox.dart';
import 'package:nuuz/ui/theme/icon_path.dart';
import 'package:nuuz/ui/theme/text_style.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';

import 'home_controller.dart';

class CheerUpWidget extends ConsumerWidget {
  const CheerUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemState = ref.watch(cheerUpProvider);


    final isVisible = ref.watch(cheerVisibleProvider);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final cheerUpList = ref.watch(cheerUpGetProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'Home_Main_0002'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            hSize(12),
            SizedBox(
              width: 390.w,
              height: 127.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                // shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CheerUpItem(
                    index: index,
                    user: cheerUpList![index]!.user!,
                  );
                },
                itemCount: cheerUpList!.length,
              ),
            ),
            hSize(12),
          ],
        );
      },
    );
  }
}

class CheerUpItem extends StatefulWidget {
  const CheerUpItem({Key? key, required this.index, required this.user}) : super(key: key);

  final CheerUpUser user;
  final int index;

  @override
  State<CheerUpItem> createState() => _CheerUpItemState();
}

class _CheerUpItemState extends State<CheerUpItem> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.index == 0 ? 20.w : 0),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final isState = ref.watch(cheerUpProvider);
          final isVisible = ref.watch(cheerUpFadeProvider);
          return GestureDetector(
            onTap: () async {
              ref.watch(cheerUpGetProvider.notifier).cheerUpPost(widget.user.user_id??"");
              await ref.watch(cheerUpProvider.notifier).itemDelete(widget.index);
              bool visible = ref.watch(cheerUpFadeProvider.notifier).check();
              setState(() {
                ref.watch(cheerVisibleProvider.notifier).visible(visible);
              });
              await Future.delayed(const Duration(milliseconds: 300),(){
                ref.watch(cheerUpGetProvider.notifier).deleteCheerUpstate();
              });
              setState(() {});
            },
            child: Visibility(
              visible: isVisible[widget.index],
              child: AnimatedScale(
                onEnd: () {
                  setState(() {
                    isVisible[widget.index] = false;
                  });
                },
                scale: isState[widget.index],
                curve: Curves.ease,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    width: 113.w,
                    height: 127.h,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Column(
                      children: [
                        Container(
                          width: 110.w,
                          height: 82.h,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(14)),
                              image: DecorationImage(image:
                              NetworkImage(
                                  widget.user.profile_image==null?
                                  IconPath.nuuzDefaultImage:
                                  widget.user.profile_image==''?
                                  IconPath.nuuzDefaultImage:
                                  widget.user.profile_image!
                                  )


                                  , fit: BoxFit.cover)
                          ),
                          child: Center(
                            child: SvgPicture.asset(IconPath.cheerUp),
                          ),
                        ),
                        hSize(4),
                        Text(
                           widget.user.nick_name??"",
                          style: CustomTextStyle.nicknameM,
                        ),
                        // Text(
                        //   'Comm_Time_0000'.tr().replaceAll('%time', widget.user.time.toString()),
                        //   style: CustomTextStyle.iconS,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


final cheerUpGetProvider = StateNotifierProvider<CheerUpGetProvider, List<CheerUp>>((ref) {
  return CheerUpGetProvider();
});

class CheerUpGetProvider extends StateNotifier<List<CheerUp>> {
  CheerUpGetProvider() : super([]);
  final cheerUpRepository = CheerUpRepository();
  LocalDB localDB = LocalDB();
  List<bool> cheerUpstate = [];


  getAvailableCheerUp() async {
    safePrint('함수 들어간다.');
     CheerUpList? respon = await cheerUpRepository.getAvailableCheerUp();

    LocalDB localDB = LocalDB();
    UserData? userData =await localDB.findUserInfo();

    List<CheerUp>? listData = respon?.data?.where((element) =>
    element!.user_id != userData?.user_id
    )
        .toList();


    if(listData!=null){
      state = listData;
    }

     if(state!=null){
       for(int i=0; i<state!.length; i++){
         cheerUpstate.add(false);

       }
     }

  }



  deleteCheerUpstate(){
    cheerUpstate.removeAt(0);
    safePrint('상태 지우기 함수 실행');
    safePrint(cheerUpstate.length);
    if(cheerUpstate.isEmpty){
      safePrint('리스트 초기화');
      state=[];
    }
  }


  cheerUpPost(String userId){
    cheerUpRepository.postCheerUp(userId);
  }

}


final myCheerUpGetProvider = StateNotifierProvider<MyCheerUpGetProvider, List<MyCheerUp>?>((ref) {
  return MyCheerUpGetProvider();
});

class MyCheerUpGetProvider extends StateNotifier<List<MyCheerUp>?> {
  MyCheerUpGetProvider() : super(null);
  final cheerUpRepository = CheerUpRepository();
  List<String> cheerUpImageList = [];
  getCheerUp() async {
    MyCheerUpList? respon = await cheerUpRepository.getCheerUp();


    safePrint(respon?.data.result.length);
    int index = respon!.data.result.length!>10?10:respon.data.result.length;
    for(int i=0; i<index; i++){
      cheerUpImageList.add(respon.data.result[i].user?.profile_image??IconPath.nuuzDefaultImage);
    }

    safePrint(respon?.data.count);
    safePrint(respon?.data.result.length);
    state = respon?.data.result??[];
  }



  cheerUpPost(String userId){
    cheerUpRepository.postCheerUp(userId);
  }

}





class CheerUpRepository {
  static final CheerUpRepository _repository = CheerUpRepository._intrnal();

  factory CheerUpRepository() => _repository;

  CheerUpRepository._intrnal();

  Dio dio = HttpService().to();
  LocalDB localDB = LocalDB();

  Future<CheerUpList?> getAvailableCheerUp() async {
    try {
      final response = await dio.get(APIConstants.getAvailableCheerUp,);
      if (response.statusCode == 200) {
        LocalDB localDB = LocalDB();
        UserData? userData =await localDB.findUserInfo();
        CheerUpList result = CheerUpList.fromJson(response.data);







        // for(int i=0; i<result.data.length; i++){
        //   safePrint('원시 데이터');
        //   safePrint(result.data.length);
        //   safePrint(result.data[i].user_id);
        //   if(userData!.user_id == result.data[i].user_id){
        //     result.data.removeAt(i);
        //   }
        // }
        Future.delayed(const Duration(milliseconds: 200));
        return result;

      }else{
        return null;
      }
    } catch (e) {
      safePrint('응원하기 에러');
      safePrint(e);
      return null;
    }
  }

   postCheerUp(String userId,) async {
    try {
      final response = await dio.post(APIConstants.cheerUp,
        data: {
          "userId": userId
        },
      );
      if (response.statusCode == 200) {
        safePrint('응원하기 성공');
      }
    } catch (e) {
      safePrint(e);
      if (CancelToken.isCancel(e as DioError)) {
        safePrint('응원하기 보내기 에러');
      }
    }
  }


  Future<MyCheerUpList?> getCheerUp() async {
    try {
      safePrint('나의 응원하기 레파지토리');
      final response = await dio.get(APIConstants.getCheerUp,);
      if (response.statusCode == 200) {
        safePrint(response);


        final result = MyCheerUpList.fromJson(response.data);



        return result;

      }else{
        return null;
      }
    } catch (e) {
      safePrint('나의 응원하기 에러');
      safePrint(e);
      return null;
    }
  }
}

