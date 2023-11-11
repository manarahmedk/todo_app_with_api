class StatisticsModel {
  Data? data;
  String? message;
  int? status;

  StatisticsModel({this.data, this.message, this.status});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? New;
  int? outdated;
  int? doing;
  int? compeleted;

  Data({this.New, this.outdated, this.doing, this.compeleted});

  Data.fromJson(Map<String, dynamic> json) {
    New = json['new'];
    outdated = json['outdated'];
    doing = json['doing'];
    compeleted = json['compeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new'] = New;
    data['outdated'] = outdated;
    data['doing'] = doing;
    data['compeleted'] = compeleted;
    return data;
  }
}
