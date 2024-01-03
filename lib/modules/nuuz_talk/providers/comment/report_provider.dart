import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/user_info/loginresponse.dart';
import 'package:nuuz/modules/nuuz_talk/providers/user_post/repository/user_post_repository.dart';
import 'package:nuuz/repository/local_repository/local_db.dart';
import 'package:nuuz/util/log_print.dart';

final reportNotifier = StateNotifierProvider<ReportNotifier, CommentSuccessModel?>((ref) {
  return ReportNotifier();
});

class ReportNotifier extends StateNotifier<CommentSuccessModel?> {
  ReportNotifier() : super(null);

  Future<CommentSuccessModel?> createReport({required Map<String,dynamic> body,required BuildContext context}) async {
    try {
      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      return await UserPostRepository().reportComment(loginResponse?.accessToken ?? '', body,context);
    } catch (e) {
      safePrint(e);
    }
    return null;
  }
}
