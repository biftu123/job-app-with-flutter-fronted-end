// To parse this JSON data, do
//
//     final loginresposemodel = loginresposemodelFromJson(jsonString);
import 'dart:convert';

Loginresposemodel loginresposemodelFromJson(String str) => Loginresposemodel.fromJson(json.decode(str));

String loginresposemodelToJson(Loginresposemodel data) => json.encode(data.toJson());

class Loginresposemodel {
    final String token;
    final String id;
    final String profile;

    Loginresposemodel({
        required this.token,
        required this.id,
        required this.profile,
    });

    factory Loginresposemodel.fromJson(Map<String, dynamic> json) => Loginresposemodel(
        token: json["token"],
        id: json["_id"],
        profile: json["Profile"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "_id": id,
        "Profile": profile,
    };
}
