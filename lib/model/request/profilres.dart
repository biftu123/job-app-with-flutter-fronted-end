// To parse this JSON data, do
//
//     final profileRes = profileResFromJson(jsonString);


import 'dart:convert';

ProfileRes profileResFromJson(String str) => ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
    final String username;
    final String email;
    final List<String> skill;
    final String profile;
    final String location;
    final String phonenumber;

    ProfileRes({
        required this.username,
        required this.email,
        required this.skill,
        required this.profile,
        required this.location,
        required this.phonenumber,
    });

    factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        username: json["username"],
        email: json["email"],
        skill: List<String>.from(json["skill"].map((x) => x)),
        profile: json["Profile"],
        location: json["location"],
        phonenumber: json["phonenumber"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "skill": List<dynamic>.from(skill.map((x) => x)),
        "Profile": profile,
        "location": location,
        "phonenumber": phonenumber,
    };
}
