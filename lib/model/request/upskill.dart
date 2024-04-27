// To parse this JSON data, do
//
//     final upskill = upskillFromJson(jsonString);


import 'dart:convert';

Upskill upskillFromJson(String str) => Upskill.fromJson(json.decode(str));

String upskillToJson(Upskill data) => json.encode(data.toJson());

class Upskill {
    final List<String> skill;

    Upskill({
        required this.skill,
    });

    factory Upskill.fromJson(Map<String, dynamic> json) => Upskill(
        skill: List<String>.from(json["skill"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "skill": List<dynamic>.from(skill.map((x) => x)),
    };
}
