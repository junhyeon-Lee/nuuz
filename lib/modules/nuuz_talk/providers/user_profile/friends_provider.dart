
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/user_info/connectionlist.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_service.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';

final followingNotifier = StateNotifierProvider.family<FollowingNotifier, List<ConnectionList>?,String>((ref,id){
  return FollowingNotifier();
});


class FollowingNotifier extends StateNotifier<List<ConnectionList>?> {
  FollowingNotifier() : super(null);
  final myNuuzRepository = MyNuuzRepository();

  Future<void> getUserConnection({required String userId,required bool isFollower}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String,dynamic> body={
      "userId" : userId,
      "myFollower" : isFollower
    };
    state= await UserPostRepository().getUserConnection(body: body,token: loginResponse?.accessToken ?? '' );
  }


  Future<bool> connectionUpdate({required String userId,required int index,required BuildContext context}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String,dynamic> body={
      "followee" : userId,
      "follow" : false,
    };
    CommentSuccessModel model= await UserPostRepository().connectionUpdate(body: body,token: loginResponse?.accessToken ?? '',context: context );
    if(model.status ?? false){
      state?.removeAt(index);
      state=[...?state];
    }
    return false;
  }

}



final followerNotifier = StateNotifierProvider.family<FollowerNotifier, List<ConnectionList>?,String>((ref,id){
  return FollowerNotifier();
});


class FollowerNotifier extends StateNotifier<List<ConnectionList>?> {
  FollowerNotifier() : super(null);
  final myNuuzRepository = MyNuuzRepository();

  Future<void> getUserConnection({required String userId,required bool isFollower}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String,dynamic> body={
      "userId" : userId,
      "myFollower" : isFollower
    };
    state= await UserPostRepository().getUserConnection(body: body,token: loginResponse?.accessToken ?? '' );
  }

}


