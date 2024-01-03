class WithDrawModel {
  String? reason;
  String? inconvenience;

  WithDrawModel({this.reason, this.inconvenience});

  WithDrawModel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    inconvenience = json['inconvenience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['inconvenience'] = this.inconvenience;
    return data;
  }
}
