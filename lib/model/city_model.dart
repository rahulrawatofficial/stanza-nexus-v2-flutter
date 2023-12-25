// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

List<CityModel> cityModelFromJson(String str) =>
    List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  CityModel({
    this.cityId,
    this.name,
    this.code,
    this.stateId,
    this.stateName,
  });

  int cityId;
  String name;
  String code;
  int stateId;
  String stateName;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cityId: json["cityId"],
        name: json["name"],
        code: json["code"],
        stateId: json["stateId"],
        stateName: json["stateName"],
      );

  Map<String, dynamic> toJson() => {
        "cityId": cityId,
        "name": name,
        "code": code,
        "stateId": stateId,
        "stateName": stateName,
      };
}
