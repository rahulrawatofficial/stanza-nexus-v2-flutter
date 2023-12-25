// To parse this JSON data, do
//
//     final earnMore = earnMoreFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<EarnMore> earnMoreFromJson(String str) =>
    List<EarnMore>.from(json.decode(str).map((x) => EarnMore.fromJson(x)));

String earnMoreToJson(List<EarnMore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EarnMore {
  EarnMore({
    @required this.id,
    @required this.uuid,
    @required this.createdAt,
    @required this.createdBy,
    @required this.updatedAt,
    @required this.updatedBy,
    @required this.status,
    @required this.name,
    @required this.type,
    @required this.event,
    @required this.description,
    @required this.points,
    @required this.prioritySequence,
    @required this.commissionLevelOne,
    @required this.commissionLevelTwo,
  });

  int id;
  String uuid;
  int createdAt;
  dynamic createdBy;
  int updatedAt;
  dynamic updatedBy;
  bool status;
  String name;
  Type type;
  String event;
  String description;
  int points;
  int prioritySequence;
  bool commissionLevelOne;
  bool commissionLevelTwo;

  factory EarnMore.fromJson(Map<String, dynamic> json) => EarnMore(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        createdBy: json["createdBy"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        updatedBy: json["updatedBy"],
        status: json["status"] == null ? null : json["status"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        event: json["event"] == null ? null : json["event"],
        description: json["description"] == null ? null : json["description"],
        points: json["points"] == null ? null : json["points"],
        prioritySequence:
            json["prioritySequence"] == null ? null : json["prioritySequence"],
        commissionLevelOne: json["commissionLevelOne"] == null
            ? null
            : json["commissionLevelOne"],
        commissionLevelTwo: json["commissionLevelTwo"] == null
            ? null
            : json["commissionLevelTwo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "createdAt": createdAt == null ? null : createdAt,
        "createdBy": createdBy,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "updatedBy": updatedBy,
        "status": status == null ? null : status,
        "name": name == null ? null : name,
        "type": type == null ? null : typeValues.reverse[type],
        "event": event == null ? null : event,
        "description": description == null ? null : description,
        "points": points == null ? null : points,
        "prioritySequence": prioritySequence == null ? null : prioritySequence,
        "commissionLevelOne":
            commissionLevelOne == null ? null : commissionLevelOne,
        "commissionLevelTwo":
            commissionLevelTwo == null ? null : commissionLevelTwo,
      };
}

enum Type { REFERRAL, SELF }

final typeValues = EnumValues({"REFERRAL": Type.REFERRAL, "SELF": Type.SELF});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
