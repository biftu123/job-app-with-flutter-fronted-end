import 'dart:convert';

ProfileRes profileResFromJson(String str) => ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  final String username;
  final String email;
  final String location;
  final List<String> skill;
  final String phonenumber;
  final String profile;

  ProfileRes({
    required this.username,
    required this.email,
    required this.location,
    required this.skill,
    required this.phonenumber,
    required this.profile,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        username: json["username"],
        email: json["email"],
        location: json["location"],
        skill: List<String>.from(json["skill"].map((x) => x)),
        phonenumber: json["phonenumber"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "location": location,
        "skill": List<dynamic>.from(skill.map((x) => x)),
        "phonenumber": phonenumber,
        "profile": profile,
      };
}

// Example usage:
