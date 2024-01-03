import 'dart:convert';

class ReservationNoticeModel{
  String title;
  int hour;
  int minute;
  String notificationDes;
  bool isPreDay;

  ReservationNoticeModel({required this.title, required this.hour, required this.minute, required this.notificationDes, required this.isPreDay});


  factory ReservationNoticeModel.fromJson(String str) => ReservationNoticeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());


  factory ReservationNoticeModel.fromMap(Map<String, dynamic> json) =>
      ReservationNoticeModel(
        title: json["title"],
        hour: json["hour"],
        minute: json["minute"],
        notificationDes: json["notificationDes"],
        isPreDay: json["isPreDay"],
      );


  Map<String, dynamic> toMap() => {
    "title": title,
    "hour": hour,
    "minute": minute,
    "notificationDes": notificationDes,
    "isPreDay": isPreDay,
  };
}