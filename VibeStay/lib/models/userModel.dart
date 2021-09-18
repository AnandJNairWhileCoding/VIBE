// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.eMail,
        this.name,
        this.photoUrl,
    });

    String? eMail;
    String? name;
    String? photoUrl;

    factory User.fromJson(Map<String, dynamic> json) => User(
        eMail: json["eMail"],
        name: json["name"],
        photoUrl: json["photoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "eMail": eMail,
        "name": name,
        "photoUrl": photoUrl,
    };
}
