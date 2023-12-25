// To parse this JSON data, do
//
//     final redeemTdsModel = redeemTdsModelFromJson(jsonString);

import 'dart:convert';

RedeemTdsModel redeemTdsModelFromJson(String str) =>
    RedeemTdsModel.fromJson(json.decode(str));

String redeemTdsModelToJson(RedeemTdsModel data) => json.encode(data.toJson());

class RedeemTdsModel {
  RedeemTdsModel({
    this.brokerMobile,
    this.transactionId,
    this.earningAmount,
    this.firstAmount,
    this.firstTdsPercent,
    this.firstTdsAmount,
    this.currentTdsPercent,
    this.currentTdsAmount,
    this.netPayout,
    this.remainingAmount,
    this.diffInAmountWithAndWithoutPan,
  });

  String brokerMobile;
  dynamic transactionId;
  String earningAmount;
  dynamic firstAmount;
  dynamic firstTdsPercent;
  dynamic firstTdsAmount;
  dynamic currentTdsPercent;
  dynamic currentTdsAmount;
  String netPayout;
  dynamic remainingAmount;
  dynamic diffInAmountWithAndWithoutPan;

  factory RedeemTdsModel.fromJson(Map<String, dynamic> json) => RedeemTdsModel(
        brokerMobile: json["brokerMobile"],
        transactionId: json["transactionId"],
        earningAmount: json["earningAmount"],
        firstAmount: json["firstAmount"],
        firstTdsPercent: json["firstTdsPercent"],
        firstTdsAmount: json["firstTdsAmount"],
        currentTdsPercent: json["currentTdsPercent"],
        currentTdsAmount: json["currentTdsAmount"],
        netPayout: json["netPayout"],
        remainingAmount: json["remainingAmount"],
        diffInAmountWithAndWithoutPan: json["diffInAmountWithAndWithoutPan"],
      );

  Map<String, dynamic> toJson() => {
        "brokerMobile": brokerMobile,
        "transactionId": transactionId,
        "earningAmount": earningAmount,
        "firstAmount": firstAmount,
        "firstTdsPercent": firstTdsPercent,
        "firstTdsAmount": firstTdsAmount,
        "currentTdsPercent": currentTdsPercent,
        "currentTdsAmount": currentTdsAmount,
        "netPayout": netPayout,
        "remainingAmount": remainingAmount,
        "diffInAmountWithAndWithoutPan": diffInAmountWithAndWithoutPan,
      };
}
