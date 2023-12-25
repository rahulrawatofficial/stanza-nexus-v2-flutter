// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  SignupModel({
    this.city,
    this.cityId,
    this.email,
    this.mobileNumber,
    this.name,
    this.uuid,
    this.referredBy,
    this.username,
    this.otp,
  });

  String city;
  int cityId;
  String email;
  String mobileNumber;
  String name;
  String uuid;
  String referredBy;
  String username;
  String otp;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        city: json["city"],
        cityId: json["cityId"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        uuid: json["uuid"],
        referredBy: json["referredBy"],
        username: json["username"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "cityId": cityId,
        "email": email,
        "mobileNumber": mobileNumber,
        "name": name,
        "uuid": uuid,
        "referredBy": referredBy,
        "username": username,
        "otp": otp,
      };
}
