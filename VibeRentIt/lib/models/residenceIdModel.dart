// To parse this JSON data, do
//
//     final residenceIdModel = residenceIdModelFromJson(jsonString);

import 'dart:convert';

ResidenceIdModel residenceIdModelFromJson(String str) => ResidenceIdModel.fromJson(json.decode(str));

String residenceIdModelToJson(ResidenceIdModel data) => json.encode(data.toJson());

class ResidenceIdModel {
    ResidenceIdModel({
        this.residenceId,
    });

    String residenceId;

    factory ResidenceIdModel.fromJson(Map<String, dynamic> json) => ResidenceIdModel(
        residenceId: json["residenceId"],
    );

    Map<String, dynamic> toJson() => {
        "residenceId": residenceId,
    };
}
