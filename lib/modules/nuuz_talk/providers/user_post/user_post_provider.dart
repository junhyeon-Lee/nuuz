import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/nuuz_talk/react_model.dart';
import 'package:nuuz/models/nuuz_talk/trendlist.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/modules/home/nuuz_talk_screen.dart';
import 'package:nuuz/modules/nuuz_talk/nuuz_talk_controller.dart';
import 'package:nuuz/modules/nuuz_talk/providers/category/category_provider.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/log_print.dart';

import 'package:collection/collection.dart' as Collection;

final singleUserPostProvider = FutureProvider.autoDispose.family<UserPost, String>((ref, postId) {
  return UserPostRepository().getUserPost(postId);
});

// final userPostsProvider = FutureProvider.autoDispose((ref) async {
//   final talkCategory = ref.watch(nuuzTalkProvider);
//   final skipData = ref.watch(paginationSkipProvider);
//   LocalDB localDB = LocalDB();
//   LoginResponse? loginResponse = await localDB.findAuthInfo();
//   return UserPostRepository().getPosts(Category.categories[talkCategory]["category_id"]!,loginResponse?.accessToken,skipData);
// });

final userAllPostNotifier = StateNotifierProvider<UserAllPostNotifier, List<UserPost>?>((ref) {
  return UserAllPostNotifier();
});

class UserAllPostNotifier extends StateNotifier<List<UserPost>?> {
  UserAllPostNotifier() : super(null);

  Future<void> getAllPosts({required BuildContext context}) async {
    try {
      state = await UserPostRepository().getAllPosts(context: context);
      if (state != null) {
        safePrint("state");
      }
    } catch (e) {
      safePrint(e);
    }
  }
}

final userPostsProvider = StateNotifierProvider<UserPostsProvider, List<UserPost>?>((ref) {
  return UserPostsProvider();
});

class UserPostsProvider extends StateNotifier<List<UserPost>?> {
  UserPostsProvider() : super(null);


  bool isCallReactAPI=false;

  Future<void> getAllPosts(category_id, skipData,BuildContext context) async {
    try {
      LocalDB localDB = LocalDB();
      UserData? userData =await localDB.findUserInfo();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      safePrint('loginResponse?.accessToken ${loginResponse?.accessToken}');
      //List<UserPost> postList = await UserPostRepository().getPosts(category_id, loginResponse?.accessToken, skipData,context);
      state = await UserPostRepository().getPosts(category_id, loginResponse?.accessToken, skipData,context);
   /*   for(int i=0; i<postList.length; i++){
        Map<String, dynamic> body = {"postId": postList[i].postId};
        List<ReactModel> reactList= await UserPostRepository().getReaction(body: body,token: loginResponse?.accessToken ?? '');

        ReactModel? reactModel = reactList.firstWhereOrNull((element) => element.user_id ==userData?.user_id);
        if (reactModel != null) {
          postList[i]=postList[i].copyWith(isLiked: true);
        }else{
          postList[i]=postList[i].copyWith(isLiked: false);
        }
      }*/
      // state = postList;
     // state = await UserPostRepository().getPosts(category_id, loginResponse?.accessToken, skipData);
      if (state != null) {
        safePrint("state");
      }
    } catch (e) {
      safePrint(e);
    }
  }


  Future<bool> createReaction(
      {UserPost? userPost, required BuildContext context,required int index}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().createReact(body: body, token: loginResponse?.accessToken ?? '');

      if (model.status ?? false) {


       // state?[index]=userPost!.copyWith(isLiked: true,likesCount: userPost.likesCount+1);
        state=[...?state];

        return true;
      }
    }
    isCallReactAPI=false;
      return false;
  }


  Future<List<UserPost>> getPosts({required String postId,required String userId}) async {
    LocalDB localDB = LocalDB();
    isCallReactAPI=true;
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    Map<String, dynamic> body = {"postId": postId,"userId": userId};
    List<UserPost> postList = await UserPostRepository().getPostUsingFilter(body: body, token: loginResponse?.accessToken ?? '');
    isCallReactAPI=false;
    return postList;
  }




  Future<bool> deleteReaction(
      {UserPost? userPost, required BuildContext context,required int index}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
     /* Map<String, dynamic> body1 = {"postId": userPost?.postId};
      List<ReactModel> reactList= await UserPostRepository().getReaction(body: body1,token: loginResponse?.accessToken ?? '');
      UserData? userData =await localDB.findUserInfo();
      ReactModel? reactModel = reactList.firstWhere((element) => element.userId ==userData?.user_id && element.postId==userPost?.postId);
*/
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().deleteReact(body: body, token: loginResponse?.accessToken ?? '',reactId: userPost?.reactId ?? '');
      if (model.status ?? false) {
        return true;
       // state?[index]=userPost!.copyWith(isLiked: false,likesCount: userPost.likesCount-1);
      }
    }
    isCallReactAPI=false;
    return false;
  }
}




final getPostsProvider = StateNotifierProvider<GetPostsProvider, List<UserPost>?>((ref) {
  return GetPostsProvider();
});

class GetPostsProvider extends StateNotifier<List<UserPost>?> {
  GetPostsProvider() : super(null);
  int skip = 1, selectedIndex = 0;
  bool isNextPage= true;
  List<UserPost> preList = [];

  Future<void> setData(List<UserPost> list) async {
    try {

      state = list;
      if (state != null) {
        safePrint("state");
      }
    } catch (e) {
      safePrint(e);
    }
  }

  Future<void> addList(List<UserPost> list) async {
    ///여기서 판단을 해야함 만약 리스트의 크기가 5보다 작으면 컨트롤 변수를 변경해야합니다.
    ///또는 이전 데이터와 동일하다면 컨트롤 변수를 변경해야 합니다.
    isNextPage = true;

    if(state?[0].postId!=list[0].postId){
      if(list!=preList){
        safePrint('돌아?');
        safePrint(state?[0].postId!=list[0].postId);
        safePrint(state?[0].postId);
        safePrint(list[0].postId);
        safePrint(state);
        safePrint('@@@@@@@@');
        safePrint(list);
        try {
          List<UserPost> tempList=[];
          tempList.addAll(state ?? []);
          tempList.addAll(list);
          state=tempList;
          preList = list;
          if (state != null) {
            safePrint("state");
          }
        } catch (e) {
          safePrint(e);
        }
      }else{null;}
    }


  }


  Future<void> updateData({required int index,
    required UserPost userPost,
  }) async {
    try {
      state?[index] = state![index]
          .copyWith(isLiked: userPost.isLiked, likesCount: userPost.likesCount, reactId: userPost.reactId);
      state=[...?state];
    } catch (e) {
      safePrint(e);
    }
  }


  Future<void> updateLikeData({
    required int index,
    required bool isLike,
    String? rectId,
  }) async {
    try {
      if(isLike) {
        state![index] = state![index]
            .copyWith(
            isLiked: false,
            likesCount: (state?[index].likesCount ?? 0) - 1,
            reactId: null);
      }else{
        state![index] = state![index]
            .copyWith(
            isLiked: true,
            likesCount: (state![index].likesCount ?? 0) + 1,
            reactId: rectId ?? state![index].reactId
        );
      }
      state=[...?state];
    } catch (e) {
      safePrint(e);
    }
  }

}










final createPostProvider = StateNotifierProvider<CreatePostProvider, bool?>((ref) {
  return CreatePostProvider();
});

class CreatePostProvider extends StateNotifier<bool?> {
  CreatePostProvider() : super(null);

  Future<void> createPost(
    Map<String, dynamic> data,
      BuildContext context
  ) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      safePrint("createPost  data ====>$data");
      // ignore: use_build_context_synchronously
      state = await UserPostRepository().createPost(
        data,
        loginResponse?.accessToken,
        context
      );
      if (state != null) {
        safePrint("state");
      }
    } catch (e) {
      safePrint(e);
    }
  }

  Future<void> updatePost({
    required Map<String, dynamic> data,required String postId
  }) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      safePrint("createPost  data ====>$data");
      state = await UserPostRepository().updatePost(
        data: data,
        token: loginResponse?.accessToken ?? '', postId: postId,
      );
      if (state != null) {
        safePrint("state");
      }
    } catch (e) {
      safePrint(e);
    }
  }
}

// class UserPostNotifier {
//   final userPostRepository = UserPostRepository();

//   UserPostNotifier

//   // @override
//   // FutureOr<UserPost> build() {
//   //   return _fetchUserPost(postId);
//   // }

//   Future<UserPost> _fetchUserPost(String postId) {
//     return userPostRepository.getUserPost(postId);
//   }
// }

final trendItemProvider = StateNotifierProvider<TrendItemProvider, UserPost?>((ref) {
  return TrendItemProvider();
});

class TrendItemProvider extends StateNotifier<UserPost?> {
  TrendItemProvider() : super(null);

  getTrendItemData(String postId) async {
    state = await UserPostRepository().getUserPost(postId);
  }


}