// To parse this JSON data, do
//
//     final residenceImageModel = residenceImageModelFromJson(jsonString);

import 'dart:convert';

List<ResidenceImageModel> residenceImageModelFromJson(String str) => List<ResidenceImageModel>.from(json.decode(str).map((x) => ResidenceImageModel.fromJson(x)));

String residenceImageModelToJson(List<ResidenceImageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResidenceImageModel {
    ResidenceImageModel({
        this.residence,
        this.image,
    });

    String residence;
    String image;

    factory ResidenceImageModel.fromJson(Map<String, dynamic> json) => ResidenceImageModel(
        residence: json["residence"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "residence": residence,
        "image": image,
    };
}
