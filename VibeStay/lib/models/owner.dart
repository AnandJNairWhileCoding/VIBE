// To parse this JSON data, do
//
//     final owner = ownerFromJson(jsonString);

import 'dart:convert';

Owner ownerFromJson(String str) => Owner.fromJson(json.decode(str));

String ownerToJson(Owner data) => json.encode(data.toJson());

class Owner {
    Owner({
        this.eMail,
        this.name,
        this.photoUrl,
        this.phoneNumber,
    });

    String? eMail;
    String? name;
    String? photoUrl;
    String? phoneNumber;

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        eMail: json["eMail"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "eMail": eMail,
        "name": name,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
    };
}
