import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/nuuz_talk/comments.dart';
import 'package:nuuz/models/nuuz_talk/react_model.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/drawer/my_drawer/my_drawer_controller.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_service.dart';
import 'package:nuuz/modules/nuuz_talk/providers/latest_comment/latest_comment_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/log_print.dart';

final previewPostNotifier = StateNotifierProvider.family<PreviewPostNotifier, UserPost?,String>((ref,id) {
  return PreviewPostNotifier();
});

class PreviewPostNotifier extends StateNotifier<UserPost?> {
  PreviewPostNotifier() : super(null);
  final myNuuzRepository = MyNuuzRepository();

  bool isReactionApiCall=false;


  Future<void> setUserPost({required UserPost userPost}) async {
    try {
      state = userPost;
      if (state != null) {
        safePrint(state);
      }
    } catch (e) {
      safePrint(e);
    }
  }

  Future<List<ReactModel>> getReaction({required String postId}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String, dynamic> body = {"postId": postId};
    return await UserPostRepository().getReaction(body: body, token: loginResponse?.accessToken ?? '');
  }


  Future<void> createReaction(
      {UserPost? userPost, required BuildContext context,required WidgetRef ref}) async {
    LocalDB localDB = LocalDB();
    isReactionApiCall=true;
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().createReact(body: body, token: loginResponse?.accessToken ?? '');

      if (model.status ?? false) {
        List<UserPost> postList = await getPosts(postId: userPost?.postId ?? '',userId: userPost?.userId ?? '');
        if(postList.length>0) {
          state=userPost?.copyWith(isLiked: true,likesCount: userPost.likesCount+1,reactId: postList[0].reactId);
        }
      }
    }
    isReactionApiCall=false;
  }


  Future<List<UserPost>> getPosts({required String postId,required String userId}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String, dynamic> body = {"postId": postId,"userId": userId};
    List<UserPost> postList = await UserPostRepository().getPostUsingFilter(body: body, token: loginResponse?.accessToken ?? '');

    return postList;
  }

  Future<void> deleteReaction(
      {UserPost? userPost, required BuildContext context,required String reactionId,int? index}) async {
    isReactionApiCall=true;
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().deleteReact(body: body, token: loginResponse?.accessToken ?? '',reactId: reactionId);
      if (model.status ?? false) {
        state=userPost?.copyWith(isLiked: false,likesCount: userPost.likesCount-1,reactId: null);
      }
    }
    isReactionApiCall=false;
  }

}