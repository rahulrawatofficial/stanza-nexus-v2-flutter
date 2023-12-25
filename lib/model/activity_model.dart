// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

List<ActivityModel> activityModelFromJson(String str) =>
    List<ActivityModel>.from(
        json.decode(str).map((x) => ActivityModel.fromJson(x)));

String activityModelToJson(List<ActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  ActivityModel({
    this.activityId,
    this.activityName,
    this.activityType,
    this.transactionCount,
  });

  int activityId;
  String activityName;
  String activityType;
  int transactionCount;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        activityId: json["activityId"],
        activityName: json["activityName"],
        activityType: json["activityType"],
        transactionCount: json["transactionCount"],
      );

  Map<String, dynamic> toJson() => {
        "activityId": activityId,
        "activityName": activityName,
        "activityType": activityType,
        "transactionCount": transactionCount,
      };
}
