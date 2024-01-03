import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_model.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/nuuz_talk/comments.dart';
import 'package:nuuz/models/nuuz_talk/react_model.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/user_info/connectionlist.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_service.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/user_post_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_profile/friends_provider.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/ui/loader.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:collection/collection.dart' as Collection;

final userProfilePostNotifier = StateNotifierProvider.family<UserProfilePostNotifier, List<UserPost>?, String>((ref, id) {
  return UserProfilePostNotifier();
});

class UserProfilePostNotifier extends StateNotifier<List<UserPost>?> {
  UserProfilePostNotifier() : super(null);
  final myNuuzRepository = MyNuuzRepository();

  bool isCallReactAPI=false;

  Future<void> getPosts({required String userId}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String, dynamic> body = {"userId": userId};
    state = await UserPostRepository().getPostUsingFilter(body: body, token: loginResponse?.accessToken ?? '');
  }



  Future<void> createReaction(
      {UserPost? userPost, required BuildContext context,required int index,required WidgetRef ref}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().createReact(body: body, token: loginResponse?.accessToken ?? '');

      if (model.status ?? false) {


        List<UserPost> pos =
        await ref.watch(userPostsProvider.notifier).getPosts(postId: userPost?.postId ?? '',userId: userPost?.userId ?? '');

        print('------=====---->${pos.length}');
        if (pos.length > 0) {
          state?[index] =
              userPost!.copyWith(isLiked: true, likesCount: userPost.likesCount + 1,reactId: pos[0].reactId);
          state=[...?state];
        } else {
          state?[index] =
              userPost!.copyWith(isLiked: true, likesCount: userPost.likesCount + 1);
          state=[...?state];
        }


      }
    }
    isCallReactAPI=false;
  }



  Future<void> deleteReaction(
      {UserPost? userPost, required BuildContext context,required int index}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
      /*  Map<String, dynamic> body1 = {"postId": userPost?.postId};
      List<ReactModel> reactList= await UserPostRepository().getReaction(body: body1,token: loginResponse?.accessToken ?? '');
      UserData? userData =await localDB.findUserInfo();
      ReactModel? reactModel = reactList.firstWhere((element) => element.userId ==userData?.user_id && element.postId==userPost?.postId);
*/
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().deleteReact(body: body, token: loginResponse?.accessToken ?? '',reactId: userPost?.reactId ?? '');
      if (model.status ?? false) {
        state?[index] = userPost!.copyWith(isLiked: false, likesCount: userPost.likesCount - 1,reactId: null);
        state=[...?state];
      }
    }
    isCallReactAPI=false;
  }

}

final profileNotifier = StateNotifierProvider.family<ProfileNotifier,UserData?, String>((ref,id) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<UserData?> {
  ProfileNotifier() : super(null);

  Future<void> getUserProfile({required String userId}) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();

      state = await UserPostRepository().getUserProfile(userId: userId, token: loginResponse?.accessToken ?? '');
      if (state != null) {
        safePrint(state);
      }
    } catch (e) {
      safePrint(e);
    }
  }
}

final followUnfollowNotifier = StateNotifierProvider.family<FollowUnFollowNotifier, bool,String>((ref,id) {
  return FollowUnFollowNotifier();
});

class FollowUnFollowNotifier extends StateNotifier<bool> {
  FollowUnFollowNotifier() : super(false);

  Future<void> getUserConnection({required String currentUserId, required String userId}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String, dynamic> body = {"userId": currentUserId, "myFollower": false};
    List<ConnectionList> list = await UserPostRepository().getUserConnection(body: body, token: loginResponse?.accessToken ?? '');

    final index1 = list.indexWhere((element) => element.user_id == userId);
    if (index1 != -1) {
      state = true;
    } else {
      state = false;
    }
  }

  Future<void> connectionUpdate({required String userId, required bool isFollow, required BuildContext context,required WidgetRef ref}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String, dynamic> body = {
      "followee": userId,
      "follow": isFollow,
    };
    CommentSuccessModel model =
        await UserPostRepository().connectionUpdate(body: body, token: loginResponse?.accessToken ?? '', context: context);
    if (model.status ?? false) {
      state = isFollow;
    }

    if(model.status ?? false){
      if(isFollow){
        ref.watch(followerNotifier(userId).notifier).state?.add(ConnectionList(user_id: '', name: '', email: '', profile_image: '', nick_name: '', introduction: ''));
      }else{
        ref.watch(followerNotifier(userId).notifier).state?.removeAt(0);
      }
    }
  }
}






final userProfileCommentNotifier = StateNotifierProvider.family<UserProfileCommentNotifier, List<UserComment>?,String>((ref, id) {
  return UserProfileCommentNotifier();
});

class UserProfileCommentNotifier extends StateNotifier<List<UserComment>?> {
  UserProfileCommentNotifier() : super(null);

  bool isCallReactAPI=false;

  Future<void> getComment({required String userId }) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();

      Map<String, dynamic> body = {'userId': userId};

      List<UserComment> list = await UserPostRepository().getComments(body: body, token: loginResponse?.accessToken ?? '');

      for(int a=0; a<list.length; a++){
        Map<String, dynamic> body = {"postId": list[a].post_id, "userId": userId};
        List<UserPost> post = await UserPostRepository().getPostUsingFilter(body: body, token: loginResponse?.accessToken ?? '');
        if (post.isNotEmpty) {
          if(post[0].imageUrls.isNotEmpty){
            list[a]= list[a]
                .copyWith(postImage: post[0].imageUrls[0], categoryName: post[0].category.name, categoryId: post[0].category.id);
          }else{
            list[a]=list[0].copyWith(postImage: '', categoryName: post[0].category.name, categoryId: post[0].category.id);
          }
        }
      }
      state = list;
    } catch (e) {
      safePrint(e);
    }
  }




  Future<void> likeUnlike({required int position, required UserComment comment,required BuildContext context}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();

    try {
      if (comment.reactId == null) {
        Map<String, dynamic> body = {
          'commentId': comment.comment_id,
          'react': 'like'
        };

        CommentSuccessModel model = await UserPostRepository().createReact(
            body: body, token: loginResponse?.accessToken ?? '');

        if (model.status ?? false) {
          Map<String, dynamic> body = {'postId': comment.post_id, 'commentId': comment.comment_id};
          List<UserComment> list = await UserPostRepository().getComments(body: body, token: loginResponse?.accessToken ?? '');

          if (list.length > 0) {
            state?[position] =
                comment.copyWith(is_liked: Constants.isLiked, reactions: (comment.reactions ?? 0) + 1, reactId: list[0].reactId);
          } else {
            state?[position] = comment.copyWith(is_liked: Constants.isLiked, reactions: (comment.reactions ?? 0) + 1);
          }
          state = [...?state];
        }
      } else {
        Map<String, dynamic> body = {
          'react': 'unlike'
        };
        CommentSuccessModel model = await UserPostRepository().deleteReact(
            body: body, token: loginResponse?.accessToken ?? '', reactId: comment.reactId ?? '');
        if (model.status ?? false) {
          state?[position] =
              comment.copyWith(is_liked: Constants.isUnLiked, reactId: null, reactions: (comment.reactions ?? 0) - 1);
          state = [...?state];
        }
      }
      isCallReactAPI = false;
    }catch(e) {
      isCallReactAPI = false;
    }
  }


  Future<List<UserPost>> getPosts({required String postId,required BuildContext context,required String userId}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String, dynamic> body = {"postId": postId,"userId": userId};
    appLoader(context);
    List<UserPost> postList = await UserPostRepository().getPostUsingFilter(body: body, token: loginResponse?.accessToken ?? '');
    removeAppLoader();
    return postList;
  }

}
