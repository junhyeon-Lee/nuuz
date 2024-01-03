import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/nuuz_talk/comments.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/home/nuuz_my/nuuz_my_service.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/constants.dart';
import 'package:nuuz/util/log_print.dart';

final latestCommentNotifier = StateNotifierProvider.family<LatestCommentNotifier, List<UserComment>?,String>((ref,id) {
  return LatestCommentNotifier();
});

class LatestCommentNotifier extends StateNotifier<List<UserComment>?> {
  LatestCommentNotifier() : super(null);
  final myNuuzRepository = MyNuuzRepository();

  bool isReactionApiCall=false;

  Future<void> getLatestComment({required String commentId}) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      Map<String, dynamic> body = {'commentId': commentId};
      state = await UserPostRepository().getComments(body: body, token: loginResponse?.accessToken ?? '');
      if (state != null) {
        safePrint(state);
      }
    } catch (e) {
      safePrint(e);
    }
  }



  Future<void> likeUnlike(
      {UserComment? comment, required BuildContext context}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();

    if (comment?.reactId == null) {
      Map<String, dynamic> body = {'commentId': comment?.comment_id, 'react': 'like'};

      CommentSuccessModel model =
          await UserPostRepository().createReact(body: body, token: loginResponse?.accessToken ?? '');
      if (model.status ?? false) {
       /* state?[0] = comment!.copyWith(is_liked: Constants.isLiked);
        state = [...?state];*/
        await getLatestComment(commentId: comment?.comment_id ?? '');
      }
    } else {
      Map<String, dynamic> body = {'react': 'unlike'};
      CommentSuccessModel model = await UserPostRepository()
          .deleteReact(body: body, token: loginResponse?.accessToken ?? '', reactId: comment?.reactId ?? '');
      if (model.status ?? false) {
        state?[0] =
            comment!.copyWith(is_liked: Constants.isUnLiked, reactId: null, reactions: (comment.reactions ?? 0) - 1);
        state = [...?state];
      }
    }

    isReactionApiCall=false;
  }
}
