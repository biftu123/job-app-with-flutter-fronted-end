// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    final String email;
    final String password;

    Login({
        required this.email,
        required this.password,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["Password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "Password": password,
    };
}
