// To parse this JSON data, do
//
//     final residenceDetailsListModel = residenceDetailsListModelFromJson(jsonString);

import 'dart:convert';

List<ResidenceDetailsListModel> residenceDetailsListModelFromJson(String str) =>
    List<ResidenceDetailsListModel>.from(
        json.decode(str).map((x) => ResidenceDetailsListModel.fromJson(x)));

String residenceDetailsListModelToJson(List<ResidenceDetailsListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResidenceDetailsListModel {
  ResidenceDetailsListModel({
    this.owner,
    this.residenceId,
    this.residenceName,
    this.residenceType,
    this.bedRooms,
    this.washRooms,
    this.carpetArea,
    this.parking,
    this.cost,
    this.locationLa,
    this.locationLo,
  });

  String? owner;
  String? residenceId;
  String? residenceName;
  String? residenceType;
  String? bedRooms;
  String? washRooms;
  String? carpetArea;
  bool? parking;
  String? cost;
  String? locationLa;
  String? locationLo;

  factory ResidenceDetailsListModel.fromJson(Map<String, dynamic> json) =>
      ResidenceDetailsListModel(
        owner: json["owner"],
        residenceId: json["residenceId"],
        residenceName: json["residenceName"],
        residenceType: json["residenceType"],
        bedRooms: json["bedRooms"],
        washRooms: json["washRooms"],
        carpetArea: json["carpetArea"],
        parking: json["parking"],
        cost: json["cost"],
        locationLa: json["locationLA"],
        locationLo: json["locationLO"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "residenceId": residenceId,
        "residenceName": residenceName,
        "residenceType": residenceType,
        "bedRooms": bedRooms,
        "washRooms": washRooms,
        "carpetArea": carpetArea,
        "parking": parking,
        "cost": cost,
        "locationLA": locationLa,
        "locationLO": locationLo,
      };
}
