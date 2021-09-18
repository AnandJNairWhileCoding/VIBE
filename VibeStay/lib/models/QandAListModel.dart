// To parse this JSON data, do
//
//     final qandAListModel = qandAListModelFromJson(jsonString);

import 'dart:convert';

List<QandAListModel> qandAListModelFromJson(String str) => List<QandAListModel>.from(json.decode(str).map((x) => QandAListModel.fromJson(x)));

String qandAListModelToJson(List<QandAListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QandAListModel {
    QandAListModel({
        this.id,
        this.residence,
        this.user,
        this.question,
        this.answer,
    });

    int? id;
    String? residence;
    String? user;
    String? question;
    String? answer;

    factory QandAListModel.fromJson(Map<String, dynamic> json) => QandAListModel(
        id: json["id"],
        residence: json["residence"],
        user: json["user"],
        question: json["question"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "residence": residence,
        "user": user,
        "question": question,
        "answer": answer,
    };
}
