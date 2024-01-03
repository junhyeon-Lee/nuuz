import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/nuuz_talk/comments.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';

final addCommentNotifier = StateNotifierProvider<AddCommentNotifier, CommentSuccessModel?>((ref) {
  return AddCommentNotifier();
});

class AddCommentNotifier extends StateNotifier<CommentSuccessModel?> {
  AddCommentNotifier() : super(null);

  Future<void> addComment({required String postId, required String description,required BuildContext context}) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      Map<String, dynamic> body={
        'postId' : postId,
        'description' : description
      };
      state = await UserPostRepository().addComments(token: loginResponse?.accessToken ?? '', data: body,context: context);
      if (state != null) {
        safePrint("state");
      }
    } catch (e) {
      safePrint(e);
    }
  }
}



final getCommentNotifier = StateNotifierProvider<GetCommentNotifier, List<UserComment>?>((ref) {
  return GetCommentNotifier();
});

class GetCommentNotifier extends StateNotifier<List<UserComment>?> {
  GetCommentNotifier() : super(null);
  bool isCallReactAPI=false;

  Future<void> getComment({required String postId}) async {
    try {

      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();

      Map<String,dynamic> body={
        'postId' : postId
      };
      List<UserComment> commentList = await UserPostRepository().getComments(body: body,token:loginResponse?.accessToken ?? '');
      commentList.sort((a, b){ //sorting in ascending order
        return DateTime.parse(a.created_at ?? DateTime.now().toString()).compareTo(DateTime.parse(b.created_at ?? DateTime.now().toString()));
      });
      state=commentList;
      if(state!=null){
        safePrint(state);
      }
    } catch (e) {
      safePrint(e);
    }
  }


  Future<void> likeUnlike({required int position, required UserComment comment,required BuildContext context,required String postId}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();

    if(comment.reactId==null ) {
      Map<String, dynamic> body = {
        'commentId': comment.comment_id,
        'react': 'like'
      };

      CommentSuccessModel model = await UserPostRepository().createReact(
          body: body, token: loginResponse?.accessToken ?? '',);
      if (model.status ?? false) {
        Map<String, dynamic> body1 = {
          'postId': comment.post_id,
          'commentId': comment.comment_id,
        };
        List<UserComment> list=await UserPostRepository().getComments(body: body1,token:loginResponse?.accessToken ?? '');
        state?[position] = comment.copyWith(is_liked: Constants.isLiked,reactId: list.length>0 ?list[0].reactId : null,reactions: (comment.reactions ?? 0)+1);
        state = [...?state];
      }
    }else{
      Map<String, dynamic> body = {
        'react': 'unlike'
      };
      CommentSuccessModel model = await UserPostRepository().deleteReact(
          body: body, token: loginResponse?.accessToken ?? '', reactId: comment.reactId ?? '');
      if (model.status ?? false) {
        state?[position] = comment.copyWith(is_liked: Constants.isUnLiked,reactId: null,reactions: (comment.reactions ?? 0)-1);
        state = [...?state];
      }
    }

    isCallReactAPI=false;
  }

}

