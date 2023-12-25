// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.id,
    this.uuid,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.status,
    this.partnerId,
    this.name,
    this.mobileNumber,
    this.username,
    this.email,
    this.city,
    this.referralCode,
    this.referredBy,
    this.preferredPaymentMode,
    this.commissionLevelOne,
    this.commissionLevelTwo,
    this.token,
    this.imageUrl,
    this.panUploaded,
    this.kycCompleted,
    this.maxTds,
  });

  int id;
  String uuid;
  int createdAt;
  dynamic createdBy;
  int updatedAt;
  dynamic updatedBy;
  bool status;
  String partnerId;
  String name;
  String mobileNumber;
  String username;
  String email;
  String city;
  String referralCode;
  String referredBy;
  String preferredPaymentMode;
  bool commissionLevelOne;
  bool commissionLevelTwo;
  String token;
  String imageUrl;
  bool panUploaded;
  bool kycCompleted;
  bool maxTds;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        uuid: json["uuid"],
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        updatedAt: json["updatedAt"],
        updatedBy: json["updatedBy"],
        status: json["status"],
        partnerId: json["partnerId"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        username: json["username"],
        email: json["email"],
        city: json["city"],
        referralCode: json["referralCode"],
        referredBy: json["referredBy"],
        preferredPaymentMode: json["preferredPaymentMode"],
        commissionLevelOne: json["commissionLevelOne"],
        commissionLevelTwo: json["commissionLevelTwo"],
        token: json["token"],
        imageUrl: json["imageUrl"],
        panUploaded: json["panUploaded"],
        kycCompleted: json["kycCompleted"],
        maxTds: json["maxTds"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "createdAt": createdAt,
        "createdBy": createdBy,
        "updatedAt": updatedAt,
        "updatedBy": updatedBy,
        "status": status,
        "partnerId": partnerId,
        "name": name,
        "mobileNumber": mobileNumber,
        "username": username,
        "email": email,
        "city": city,
        "referralCode": referralCode,
        "referredBy": referredBy,
        "preferredPaymentMode": preferredPaymentMode,
        "commissionLevelOne": commissionLevelOne,
        "commissionLevelTwo": commissionLevelTwo,
        "token": token,
        "imageUrl": imageUrl,
        "panUploaded": panUploaded,
        "kycCompleted": kycCompleted,
        "maxTds": maxTds,
      };
}
