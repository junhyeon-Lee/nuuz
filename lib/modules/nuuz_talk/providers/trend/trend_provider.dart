import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/trendlist.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';

import 'dart:async';

final trendProvider = StateNotifierProvider<TrendNotifier, List<TrendList>?>((ref) {
  return TrendNotifier();
});

class TrendNotifier extends StateNotifier<List<TrendList>?> {
  TrendNotifier() : super(null);

  Future<bool> getTrends({required BuildContext context}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    state= await UserPostRepository().getTrend(token: loginResponse?.accessToken ?? '',context: context);
    if(state==null){
      return false;
    }
    return true;
  }
}


final nuuzTrendProvider = StateNotifierProvider<NuuzTrendProvider, List<TrendList>?>((ref) {
  return NuuzTrendProvider();
});

class NuuzTrendProvider extends StateNotifier<List<TrendList>?> {
  NuuzTrendProvider() : super(null);

  Future<bool> getTrends({required BuildContext context}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    state= await UserPostRepository().getTrend(token: loginResponse?.accessToken ?? '',context: context);
    if(state==null){
      return false;
    }
    return true;
  }

}