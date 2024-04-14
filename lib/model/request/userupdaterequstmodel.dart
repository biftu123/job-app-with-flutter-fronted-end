// To parse this JSON data, do
//
//     final userupdaterequstModel = userupdaterequstModelFromJson(jsonString);


import 'dart:convert';

UserupdaterequstModel userupdaterequstModelFromJson(String str) => UserupdaterequstModel.fromJson(json.decode(str));

String userupdaterequstModelToJson(UserupdaterequstModel data) => json.encode(data.toJson());

class UserupdaterequstModel {
    final String location;
    final List<String> skill;
    final String phonenumber;
    final String profile;

    UserupdaterequstModel({
        required this.location,
        required this.skill,
        required this.phonenumber,
        required this.profile,
    });

    factory UserupdaterequstModel.fromJson(Map<String, dynamic> json) => UserupdaterequstModel(
        location: json["location"],
        skill: List<String>.from(json["skill"].map((x) => x)),
        phonenumber: json["phonenumber"],
        profile: json["Profile"],
    );

    Map<String, dynamic> toJson() => {
        "location": location,
        "skill": List<dynamic>.from(skill.map((x) => x)),
        "phonenumber": phonenumber,
        "Profile": profile,
    };
}
