// To parse this JSON data, do
//
//     final signupmodel = signupmodelFromJson(jsonString);


import 'dart:convert';

Signupmodel signupmodelFromJson(String str) => Signupmodel.fromJson(json.decode(str));

String signupmodelToJson(Signupmodel data) => json.encode(data.toJson());

class Signupmodel {
    final String username;
    final String email;
    final String password;

    Signupmodel({
        required this.username,
        required this.email,
        required this.password,
    });

    factory Signupmodel.fromJson(Map<String, dynamic> json) => Signupmodel(
        username: json["username"],
        email: json["email"],
        password: json["Password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "Password": password,
    };
}
