// To parse this JSON data, do
//
//     final leadListModel = leadListModelFromJson(jsonString);

import 'dart:convert';

List<LeadListModel> leadListModelFromJson(String str) =>
    List<LeadListModel>.from(
        json.decode(str).map((x) => LeadListModel.fromJson(x)));

String leadListModelToJson(List<LeadListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeadListModel {
  LeadListModel({
    this.name,
    this.phone,
    this.email,
    this.status,
    this.microMarket,
    this.city,
    this.submittedOn,
    this.preBookedOn,
    this.bookedOn,
    this.totalEarnings,
    this.transactionsCount,
  });

  String name;
  String phone;
  String email;
  String status;
  String microMarket;
  String city;
  int submittedOn;
  dynamic preBookedOn;
  int bookedOn;
  int totalEarnings;
  int transactionsCount;

  factory LeadListModel.fromJson(Map<String, dynamic> json) => LeadListModel(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        status: json["status"],
        microMarket: json["microMarket"],
        city: json["city"],
        submittedOn: json["submittedOn"],
        preBookedOn: json["preBookedOn"],
        bookedOn: json["bookedOn"],
        totalEarnings: json["totalEarnings"],
        transactionsCount: json["transactionsCount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "status": status,
        "microMarket": microMarket,
        "city": city,
        "submittedOn": submittedOn,
        "preBookedOn": preBookedOn,
        "bookedOn": bookedOn,
        "totalEarnings": totalEarnings,
        "transactionsCount": transactionsCount,
      };
}
