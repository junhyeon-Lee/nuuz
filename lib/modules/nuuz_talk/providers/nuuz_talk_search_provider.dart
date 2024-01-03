
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';

final nuuzTalkSearchProvider = StateNotifierProvider.autoDispose<NuuzTalkSearchProvider, String>((ref) {
  return NuuzTalkSearchProvider();
});
class NuuzTalkSearchProvider extends StateNotifier<String> {
  NuuzTalkSearchProvider() : super('');
  bool isCallReactAPI=false;




  Future<bool> createReaction(
      {UserPost? userPost, required int index}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().createReact(body: body, token: loginResponse?.accessToken ?? '');

      if (model.status ?? false) {
        return true;
      }
    }
    isCallReactAPI=false;
    return false;
  }




  Future<bool> deleteReaction(
      {UserPost? userPost,required int index}) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    if (userPost?.postId != null) {
      Map<String, dynamic> body = {'postId': userPost?.postId, 'react': 'like'};

      CommentSuccessModel model = await UserPostRepository().deleteReact(body: body, token: loginResponse?.accessToken ?? '',reactId: userPost?.reactId ?? '');
      if (model.status ?? false) {
        return true;
      }
    }
    isCallReactAPI=false;
    return false;
  }

}