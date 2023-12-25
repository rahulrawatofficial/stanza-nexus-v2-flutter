// To parse this JSON data, do
//
//     final tdsInfo = tdsInfoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TdsInfo tdsInfoFromJson(String str) => TdsInfo.fromJson(json.decode(str));

String tdsInfoToJson(TdsInfo data) => json.encode(data.toJson());

class TdsInfo {
  TdsInfo({
    @required this.amount,
    @required this.tdsWithPan,
    @required this.tdsWithoutPan,
  });

  String amount;
  String tdsWithPan;
  String tdsWithoutPan;

  factory TdsInfo.fromJson(Map<String, dynamic> json) => TdsInfo(
        amount: json["amount"] == null ? null : json["amount"],
        tdsWithPan: json["tdsWithPan"] == null ? null : json["tdsWithPan"],
        tdsWithoutPan:
            json["tdsWithoutPan"] == null ? null : json["tdsWithoutPan"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "tdsWithPan": tdsWithPan == null ? null : tdsWithPan,
        "tdsWithoutPan": tdsWithoutPan == null ? null : tdsWithoutPan,
      };
}
