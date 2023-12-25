// To parse this JSON data, do
//
//     final cityLocalityModel = cityLocalityModelFromJson(jsonString);

import 'dart:convert';

List<CityLocalityModel> cityLocalityModelFromJson(String str) =>
    List<CityLocalityModel>.from(
        json.decode(str).map((x) => CityLocalityModel.fromJson(x)));

String cityLocalityModelToJson(List<CityLocalityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityLocalityModel {
  CityLocalityModel({
    this.cityId,
    this.name,
    this.code,
    this.stateId,
    this.stateName,
    this.microMarket,
  });

  int cityId;
  String name;
  String code;
  int stateId;
  String stateName;
  List<MicroMarket> microMarket;

  factory CityLocalityModel.fromJson(Map<String, dynamic> json) =>
      CityLocalityModel(
        cityId: json["cityId"],
        name: json["name"],
        code: json["code"],
        stateId: json["stateId"],
        stateName: json["stateName"],
        microMarket: List<MicroMarket>.from(
            json["microMarket"].map((x) => MicroMarket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cityId": cityId,
        "name": name,
        "code": code,
        "stateId": stateId,
        "stateName": stateName,
        "microMarket": List<dynamic>.from(microMarket.map((x) => x.toJson())),
      };
}

class MicroMarket {
  MicroMarket({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory MicroMarket.fromJson(Map<String, dynamic> json) => MicroMarket(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
