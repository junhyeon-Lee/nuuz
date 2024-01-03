import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:nuuz/models/nuuz_talk/comment_model.dart';
import 'package:nuuz/models/nuuz_talk/comment_success_model.dart';
import 'package:nuuz/models/nuuz_talk/comments.dart';
import 'package:nuuz/models/nuuz_talk/react_model.dart';
import 'package:nuuz/models/nuuz_talk/trendlist.dart';
import 'package:nuuz/models/nuuz_talk/userpost.dart';
import 'package:nuuz/models/user_info/connectionlist.dart';
import 'package:nuuz/models/user_info/userdata.dart';
import 'package:nuuz/ui/loader.dart';
import 'package:nuuz/ui/loader_screen.dart';
import 'package:nuuz/util/dio/api_constants.dart';
import 'package:nuuz/util/dio/dio_api.dart';
import 'package:nuuz/util/log_print.dart';
import 'package:nuuz/util/toast_helper.dart';

import '../../../../../models/user_info/loginresponse.dart';
import '../../../../../repository/local_repository/local_db.dart';

class UserPostRepository {
  static final UserPostRepository _repository = UserPostRepository._intrnal();

  factory UserPostRepository() => _repository;

  UserPostRepository._intrnal();

  Dio dio = HttpService().to();

  Future<UserPost> getUserPost(String postId) async {
    try {
      final response = await dio.get('/post/get', queryParameters: {"postId": postId});
      if (response.statusCode == 200) {
        safePrint("getUserPost====$response");
        var body = response.data;

        return (body["postData"]["records"] as List).map((e) => UserPost.fromJson(e)).toList().first;
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }

  Future<List<UserPost>> getPosts(String category, token, skipData,BuildContext context) async {
    try {
      safePrint("skip data===>$skipData");
      var queryParameters = category.tr() == "Prog_Part_0012".tr()
          ? {
              "limit": 5,
              "page": skipData,
            }
          : {"limit": 5, "page": skipData, "category": category};
      final response = await dio.get('post/all', queryParameters: queryParameters, options: Options(headers: {"token": token}));
      safePrint("getPosts===home=>$response");
      if (response.statusCode == 200) {
        var body = response.data;
        safePrint("getPosts====>length---->${(body['postData']['records']  as List).map((e) => UserPost.fromJson(e)).toList().length}");


        return (body['postData']['records'] as List).map((e) => UserPost.fromJson(e)).toList();
      } else {
        AppToast.showSnackBar(message: response.data['message'], context: context);
        return [];
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }

  Future<List<UserPost>> getAllPosts({required BuildContext context}) async {
    try {
      final response = await dio.get(
        APIConstants.getPost, /*queryParameters: {"limit": 10, "page":1}*/
      );
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("getPosts====>${response.data}");
        return (body["postData"]['records'] as List).map((e) => UserPost.fromJson(e)).toList();
      } else {
        AppToast.showSnackBar(message: response.data['message'], context: context);
        return [];
      }
    } catch (e) {

      safePrint(e);

      rethrow;
    }
  }

  Future<List<UserPost>> getPopularPosts() async {
    try {
      final response = await dio.get(
        APIConstants.getPost, queryParameters: {
        "limit": 1000,
        "page": 1,
      }
      );
      if (response.statusCode == 200) {
        var body = response.data;
        safePrint("getPosts====>${response.data}");
        return (body["postData"]['records'] as List).map((e) => UserPost.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      safePrint(e);

      rethrow;
    }







  }

  Future<bool?> deleteUserPost({required String token, required String postId,required BuildContext context}) async {
    try {
      appLoader(context);
      final response = await dio.delete("${APIConstants.deletePost}/$postId", options: Options(headers: {"token": token}));
      removeAppLoader();
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("deleteUserPost====>${response.data}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      safePrint(e);
      removeAppLoader();
      return false;
    }
  }

  Future<bool?> updateReviewResult(Map<String, dynamic> data, resultId) async {
    LocalDB localDB = LocalDB();
    LoginResponse? loginResponse = await localDB.findAuthInfo();
    try {
      final response = await dio.put("${APIConstants.updateReviewResult}/$resultId",
          data: data, options: Options(headers: {"token": loginResponse!.accessToken}));
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("updateReviewResult====>${response.data}");
        return true;
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);

      rethrow;
    }
  }

  Future<bool?> createPost(Map<String, dynamic> data, token,BuildContext context) async {
    try {
      safePrint("createPost----data---->$data   \n tkoen-->$token");
      final response = await dio.post(APIConstants.createPost,
          data: json.encode(data),
          options: Options(
            headers: {
              "token": token,
              'accept': 'application/json',
            },
            contentType: 'application/json',
          ));
      safePrint("createPost---->$response");
      if (response.statusCode == 200) {
        safePrint("createPost--200-->${response.data['status']}");
        if(response.data['status']==true){
          return true;
        }else {
          // ignore: use_build_context_synchronously
          AppToast.showSnackBar(message: response.data['message'] ?? '', context: context);
          return false;
        }
      } else {
       // AppToast.showSnackBar(message: response.data['message'] ?? '', context: context);
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint("createPost error====>$e");
      rethrow;
    }
  }

  Future<bool?> updatePost({required Map<String, dynamic> data,required String token,required String postId}) async {
    try {
      final response = await dio.put(APIConstants.updatePost+postId,
          data: json.encode(data),
          options: Options(
            headers: {
              "token": token,
              'accept': 'application/json',
            },
            contentType: 'application/json',
          ));
      safePrint("createPost---->$response");
      if (response.statusCode == 200) {
        safePrint("createPost--200-->${response.data}");
        return true;
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint("createPost error====>$e");
      rethrow;
    }
  }

  Future<List<UserComment>> getComments({required String token,required Map<String,dynamic> body}) async {
    try {
      final response = await dio.get(APIConstants.getComment+APIConstants.getParamsFromBody(body),
          options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("commentData====>${response.data}");
        return (body["commentData"] as List).map((e) => UserComment.fromJson(e)).toList();
      } else {
       // throw Exception("Error Status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      safePrint(e);
      return [];
     // rethrow;
    }
  }

  Future<CommentModel> getCommentsToUserId(String userId, String token) async {
    try {
      final response = await dio.get('${APIConstants.getComment}?userId=$userId',
          options: Options(headers: {"token": token}));
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("commentData====>${response.data}");
       // safePrint("commentData====>${(body["commentData"] as List).map((e) => UserComment.fromJson(e)).toList().length}");
        return CommentModel.fromJson(response.data);
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }



  Future<List<UserPost>> getPostUsingFilter({required String token,required Map<String,dynamic> body}) async {
    try {

      final response = await dio.get(
        APIConstants.getSpecificPost+APIConstants.getParamsFromBody(body), options: Options(headers: {"token": token})
      );

      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("getPosts====>${response.data}");
        return (body["postData"]['records'] as List).map((e) => UserPost.fromJson(e)).toList();
      } else {
        //throw Exception("Error Status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      safePrint(e);
     // rethrow;
      return [];
    }
  }

  Future<CommentSuccessModel> addComments({required String token, required Map<String, dynamic> data,required BuildContext context}) async {
    try {
      appLoader(context);
      final response = await dio.post(APIConstants.addComment,
          options: Options(headers: {"token": token}), data: data
      );
      removeAppLoader();
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint("commentData====>${response.data}");
        removeAppLoader();
        return CommentSuccessModel.fromJson(jsonDecode(response.data));
      } else {
        removeAppLoader();
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      removeAppLoader();
      safePrint(e);
      removeAppLoader();
      rethrow;
    }
  }


  Future<CommentSuccessModel> updateComments({required BuildContext context, required String commentId, required String comment}) async {
    try {
      appLoader(context);

      LocalDB localDB = LocalDB();
      LoginResponse? loginResponse = await localDB.findAuthInfo();
      final response = await dio.put(APIConstants.updateComment+commentId,
          data: {
            'description' : comment
          },
          options: Options(headers: {"token": loginResponse?.accessToken ?? '','Content-Type':'application/json','accept' : 'application/json'}),
      );
      removeAppLoader();
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint("commentData====>${response.data}");
        return CommentSuccessModel.fromJson(response.data);
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      removeAppLoader();
      safePrint(e);
      rethrow;
    }
  }


  Future<CommentSuccessModel> deleteComments({required String token, required String commentId, required BuildContext context}) async {
    try {

      appLoader(context);
      final response = await dio.delete(APIConstants.deleteComment+commentId,
          options: Options(headers: {"token": token,'Content-Type':'application/json','accept':'application/json'})
      );
      removeAppLoader();
      if (response.statusCode == 200) {
        safePrint("commentData====>${response.data}");
        return CommentSuccessModel.fromJson(response.data);
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      removeAppLoader();
      rethrow;
    }
  }



  Future<CommentSuccessModel> reportComment(String token,Map<String, dynamic> data,BuildContext context) async {
    try {
      appLoader(context);
      final response = await dio.post(APIConstants.createReport,
          options: Options(headers: {"token": token}), data: data
      );
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint("commentData====>${response.data}");
        return CommentSuccessModel.fromJson(response.data);
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }finally{
      removeAppLoader();
    }
  }



  Future<UserData> getUserProfile({required String userId, required String token}) async {
    try {
      final response = await dio.get('${APIConstants.getUserProfile}userId=$userId',
          options: Options(headers: {"token": token}));
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("userData====>${response.data}");
        if(body["status"]){
          return UserData.fromJson(body['userData']);
        }else{
          throw Exception("Error Status code ${response.statusCode}");
        }

      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }


  Future<CommentSuccessModel> connectionUpdate({required String token, required Map<String, dynamic> body, required BuildContext context}) async {
    try {
     // appLoader(context);
      final response = await dio.post(APIConstants.connectionUpdate,
          options: Options(headers: {"token": token}), data: body
      );
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint("commentData====>${response.data}");
        return CommentSuccessModel.fromJson(response.data);
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }finally{
     // removeAppLoader();
    }
  }

  Future<List<ConnectionList>> getUserConnection({required Map<String, dynamic> body, required String token}) async {
    try {
      final response = await dio.get(APIConstants.getConnection+APIConstants.getParamsFromBody(body),
          options: Options(headers: {"token": token}));
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("userData====>${response.data}");
        if(body["status"]){
          return (response.data["connections"]['result'] as List).map((e) => ConnectionList.fromJson(e)).toList();
        }else{
          throw Exception("Error Status code ${response.statusCode}");
        }

      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }


  Future<CommentSuccessModel> createReact({required String token, required Map<String, dynamic> body}) async {
    try {
      final response = await dio.post(APIConstants.createReaction,
          options: Options(headers: {"token": token}), data: body
      );

      safePrint("reactionData====>${response.toString()}");
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint("reactionData====>${response.data}");
        return CommentSuccessModel.fromJson(response.data);
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }finally{
    }
  }


  Future<CommentSuccessModel> deleteReact({required String token, required Map<String, dynamic> body,required String reactId}) async {
    try {
      final response = await dio.delete(APIConstants.deleteReaction+reactId,
          options: Options(headers: {"token": token}), data: body
      );
      if (response.statusCode == 200) {
        safePrint(response);
        safePrint("commentData====>${response.data}");
        return CommentSuccessModel.fromJson(response.data);
      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }finally{
    }
  }



  Future<List<TrendList>?> getTrend({required String token,required BuildContext context}) async {
    try {
      final response = await dio.get(APIConstants.getTrend,
          options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;

        if(body["status"]){
          return (response.data["trendData"] as List).map((e) => TrendList.fromJson(e)).toList();
        }else{
          AppToast.showSnackBar(message: response.data['message'] ?? '', context: context);
          return [];
        }

      }else {
        return null;
      }
    } catch (e) {
      safePrint(e);
      return null;
    }
  }


  Future<List<ReactModel>> getReaction({required String token,required Map<String, dynamic> body}) async {
    try {
      final response = await dio.get(APIConstants.getReaction+APIConstants.getParamsFromBody(body),
          options: Options(headers: {"token": token,'accept' : 'application/json'}));
      if (response.statusCode == 200) {
        safePrint(response);
        var body = response.data;
        safePrint("userData====>${response.data}");
        if(body["status"]){
          return (response.data["reactData"] as List).map((e) => ReactModel.fromJson(e)).toList();
        }else{
          throw Exception("Error Status code ${response.statusCode}");
        }

      } else {
        throw Exception("Error Status code ${response.statusCode}");
      }
    } catch (e) {
      safePrint(e);
      rethrow;
    }
  }
}
