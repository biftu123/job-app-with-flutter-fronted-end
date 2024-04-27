// To parse this JSON data, do
//
//     final getjobres = getjobresFromJson(jsonString);


import 'dart:convert';

Getjobres getjobresFromJson(String str) => Getjobres.fromJson(json.decode(str));

String getjobresToJson(Getjobres data) => json.encode(data.toJson());

class Getjobres {
    final String id;
    final String title;
    final String location;
    final String descrption;
    final String salary;
    final String period;
    final String contract;
    final List<String> requirments;
    final String imageUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Getjobres({
        required this.id,
        required this.title,
        required this.location,
        required this.descrption,
        required this.salary,
        required this.period,
        required this.contract,
        required this.requirments,
        required this.imageUrl,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Getjobres.fromJson(Map<String, dynamic> json) => Getjobres(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        descrption: json["descrption"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirments: List<String>.from(json["requirments"].map((x) => x)),
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "descrption": descrption,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirments": List<dynamic>.from(requirments.map((x) => x)),
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
