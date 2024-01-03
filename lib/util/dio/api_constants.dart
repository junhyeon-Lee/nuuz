class APIConstants {
  //static const String baseUrl = 'https://f5efytktg0.execute-api.us-east-1.amazonaws.com/dev/'; // Dev/
  // static const String baseUrl = 'https://28yg0g9he4.execute-api.ap-northeast-2.amazonaws.com/dev/'; // Dev new url
  static const String baseUrl = 'https://muletne3lf.execute-api.ap-northeast-2.amazonaws.com/prod/'; // live ner url
  // static const String baseUrl = 'https://4zsowigbga.execute-api.us-east-1.amazonaws.com/prod/'; // live

  static const String basicToken = 'Basic ';

  ///API
  ///User
  static const String userLogin = '${baseUrl}user/login';
  static const String userGet = '${baseUrl}user/get';
  static const String userUpdate = '${baseUrl}user/update';
  static const String userProfileImage = '${baseUrl}image/uploadImage';

  ///home
  static const String getBanner = '${baseUrl}main_banner/get';

  ///my drawer
  static const String getUserProduct = '${baseUrl}user-product/get';
  static const String getNotice = '${baseUrl}notice/get';
  static const String getEvent = '${baseUrl}event/get';
  static const String getEditProfile = '${baseUrl}user/update';
  static const String getFaq = '${baseUrl}faq/get';
  static const String getCreateFaq = '${baseUrl}faq/create';
  static const String getFavProgram = '${baseUrl}favourite/get';
  static const String getDeleteProgram = '${baseUrl}favourite';
  static const String getWithdraw = '${baseUrl}user/withdrawal';
  static const String getCreateDiagnosis = '${baseUrl}self-diagnosis/create';
  static const String getSelfDiagnosis = '${baseUrl}self-diagnosis/get';
  static const String getUserProductDelete = '${baseUrl}user-product/delete';

  ///cheerUp
  static const String getAvailableCheerUp = '${baseUrl}cheer-up/available/get';
  static const String getCheerUp = '${baseUrl}cheer-up/get';
  static const String cheerUp = '${baseUrl}cheer-up/create';

  /// post
  static const String getPost = '${baseUrl}post/all';
  static const String getSpecificPost = '${baseUrl}post/get';
  static const String createPost = '${baseUrl}post/create';
  static const String deletePost = '${baseUrl}post/delete';
  static const String updatePost = '${baseUrl}post/update/';

  ///result
  static const String updateReviewResult = '${baseUrl}result/update';

  /// comment
  static const String getComment = '${baseUrl}comment/get';
  static const String addComment = '${baseUrl}comment/create';
  static const String updateComment = '${baseUrl}comment/update/';
  static const String deleteComment = '${baseUrl}comment/delete/';
  static const String createReport = '${baseUrl}report/create';

  /// Product
  static const String getProduct = '${baseUrl}product/get';

  static const String getReview = '${baseUrl}result/get';

  static const String getUserProfile = '${baseUrl}user/get?';

  static const String getTrend = '${baseUrl}trend/get';

  static const String connectionUpdate = '${baseUrl}user/connection/update';
  static const String getConnection = '${baseUrl}user/connection/get';

  static const String createReaction = '${baseUrl}react/create';
  static const String deleteReaction = '${baseUrl}react/delete/';
  static const String getReaction = '${baseUrl}react/get';

  static String getParamsFromBody(Map<String, dynamic>? body) {
    String params = '?';
    for (var i = 0; i < body!.keys.length; i++) {
      params += '${List.from(body.keys)[i]}=${List.from(body.values)[i]}';
      if (i != body.keys.length - 1) {
        params += '&';
      }
    }
    return params;
  }
}
