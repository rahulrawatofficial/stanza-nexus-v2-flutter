// To parse this JSON data, do
//
//     final transactionListModel = transactionListModelFromJson(jsonString);

import 'dart:convert';

List<TransactionListModel> transactionListModelFromJson(String str) =>
    List<TransactionListModel>.from(
        json.decode(str).map((x) => TransactionListModel.fromJson(x)));

String transactionListModelToJson(List<TransactionListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionListModel {
  TransactionListModel({
    this.name,
    this.mobile,
    this.entityId,
    this.activityName,
    this.transactionPoint,
    this.commissionType,
    this.transactionType,
    this.transactionStatus,
    this.creationDate,
  });

  String name;
  String mobile;
  String entityId;
  String activityName;
  int transactionPoint;
  String commissionType;
  String transactionType;
  String transactionStatus;
  int creationDate;

  factory TransactionListModel.fromJson(Map<String, dynamic> json) =>
      TransactionListModel(
        name: json["name"],
        mobile: json["mobile"],
        entityId: json["entityId"],
        activityName: json["activityName"],
        transactionPoint: json["transactionPoint"],
        commissionType: json["commissionType"],
        transactionType: json["transactionType"],
        transactionStatus: json["transactionStatus"],
        creationDate: json["creationDate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "entityId": entityId,
        "activityName": activityName,
        "transactionPoint": transactionPoint,
        "commissionType": commissionType,
        "transactionType": transactionType,
        "transactionStatus": transactionStatus,
        "creationDate": creationDate,
      };
}
