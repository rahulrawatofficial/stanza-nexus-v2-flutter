// To parse this JSON data, do
//
//     final partnerListModel = partnerListModelFromJson(jsonString);

import 'dart:convert';

List<PartnerListModel> partnerListModelFromJson(String str) =>
    List<PartnerListModel>.from(
        json.decode(str).map((x) => PartnerListModel.fromJson(x)));

String partnerListModelToJson(List<PartnerListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PartnerListModel {
  PartnerListModel({
    this.name,
    this.image,
    this.mobile,
    this.id,
    this.transactionPoints,
    this.referralCount,
    this.transactionCount,
  });

  String name;
  dynamic image;
  String mobile;
  String id;
  int transactionPoints;
  int referralCount;
  int transactionCount;

  factory PartnerListModel.fromJson(Map<String, dynamic> json) =>
      PartnerListModel(
        name: json["name"],
        image: json["image"],
        mobile: json["mobile"],
        id: json["id"],
        transactionPoints: json["transactionPoints"],
        referralCount: json["referralCount"],
        transactionCount: json["transactionCount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "mobile": mobile,
        "id": id,
        "transactionPoints": transactionPoints,
        "referralCount": referralCount,
        "transactionCount": transactionCount,
      };
}
