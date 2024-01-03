class CommentModel {
  bool? status;
  List<CommentData>? commentData;

  CommentModel({this.status, this.commentData});

  CommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['commentData'] != null) {
      commentData = <CommentData>[];
      json['commentData'].forEach((v) {
        commentData!.add(new CommentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.commentData != null) {
      data['commentData'] = this.commentData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentData {
  String? commentId;
  String? postId;
  String? userId;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? isDeleted;
  User? user;
  int? reactions;
  int? isLiked;
  String? postImage;
  String? categoryName;
  String? categoryId;
  String? reactId;

  CommentData(
      {this.commentId,
        this.postId,
        this.userId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isDeleted,
        this.user,
        this.reactions,
        this.isLiked,
        this.postImage,
        this.categoryName,
        this.categoryId,
        this.reactId
      });

  CommentData.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    postId = json['post_id'];
    userId = json['user_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reactions = json['reactions'];
    isLiked = json['is_liked'];
    reactId = json['reactId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['reactions'] = this.reactions;
    data['is_liked'] = this.isLiked;
    data['reactId'] = this.reactId;
    return data;
  }
}

class User {
  String? name;
  String? userId;
  String? nickName;
  String? profileImage;

  User({this.name, this.userId,this.nickName, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    nickName = json['nick_name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['nick_name'] = this.nickName;
    data['profile_image'] = this.profileImage;
    return data;
  }
}