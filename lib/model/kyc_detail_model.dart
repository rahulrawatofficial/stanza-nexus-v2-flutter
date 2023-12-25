// To parse this JSON data, do
//
//     final kycDetailModel = kycDetailModelFromJson(jsonString);

import 'dart:convert';

KycDetailModel kycDetailModelFromJson(String str) =>
    KycDetailModel.fromJson(json.decode(str));

String kycDetailModelToJson(KycDetailModel data) => json.encode(data.toJson());

class KycDetailModel {
  KycDetailModel({
    this.paytmNumber,
    this.vpaAddress,
    this.accountNumber,
    this.accountName,
    this.ifscCode,
    this.panName,
    this.panNumber,
    this.panImage,
    this.preferredPaymentMode,
    this.maxTds,
  });

  String paytmNumber;
  String vpaAddress;
  String accountNumber;
  String accountName;
  String ifscCode;
  String panName;
  String panNumber;
  String panImage;
  String preferredPaymentMode;
  bool maxTds;

  factory KycDetailModel.fromJson(Map<String, dynamic> json) => KycDetailModel(
        paytmNumber: json["paytmNumber"],
        vpaAddress: json["vpaAddress"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        ifscCode: json["ifscCode"],
        panName: json["panName"],
        panNumber: json["panNumber"],
        panImage: json["panImage"],
        preferredPaymentMode: json["preferredPaymentMode"],
        maxTds: json["maxTds"],
      );

  Map<String, dynamic> toJson() => {
        "paytmNumber": paytmNumber,
        "vpaAddress": vpaAddress,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "ifscCode": ifscCode,
        "panName": panName,
        "panNumber": panNumber,
        "panImage": panImage,
        "preferredPaymentMode": preferredPaymentMode,
        "maxTds": maxTds,
      };
}
