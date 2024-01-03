class PrivacySettingsModel {
  String? posts;
  String? comments;

  PrivacySettingsModel({this.posts, this.comments});

  PrivacySettingsModel.fromJson(Map<String, dynamic> json) {
    posts = json['posts'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['posts'] = this.posts;
    data['comments'] = this.comments;
    return data;
  }
}

class NotificationSettingsModel {
  String? events;
  String? reservationNotice;
  String? cheeringNotice;

  NotificationSettingsModel(
      {this.events, this.reservationNotice, this.cheeringNotice});

  NotificationSettingsModel.fromJson(Map<String, dynamic> json) {
    events = json['events'];
    reservationNotice = json['reservation_notice'];
    cheeringNotice = json['cheering_notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['events'] = this.events;
    data['reservation_notice'] = this.reservationNotice;
    data['cheering_notice'] = this.cheeringNotice;
    return data;
  }
}