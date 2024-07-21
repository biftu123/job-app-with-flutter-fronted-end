
import 'dart:convert';

Responseforsinitmessage responseforsinitmessageFromJson(String str) => Responseforsinitmessage.fromJson(json.decode(str));

String responseforsinitmessageToJson(Responseforsinitmessage data) => json.encode(data.toJson());

class Responseforsinitmessage {
    final String id;
    final String chatname;
    final bool groupchat;
    final List<User> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Responseforsinitmessage({
        required this.id,
        required this.chatname,
        required this.groupchat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Responseforsinitmessage.fromJson(Map<String, dynamic> json) => Responseforsinitmessage(
        id: json["_id"],
        chatname: json["chatname"],
        groupchat: json["Groupchat"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatname": chatname,
        "Groupchat": groupchat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class User {
    final String id;
    final String username;
    final String email;
    final String phonenumber;
    final String location;
    final bool isAdmin;
    final bool isAgent;
    final List<dynamic> skill;
    final String profile;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    User({
        required this.id,
        required this.username,
        required this.email,
        required this.phonenumber,
        required this.location,
        required this.isAdmin,
        required this.isAgent,
        required this.skill,
        required this.profile,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        location: json["location"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skill: List<dynamic>.from(json["skill"].map((x) => x)),
        profile: json["Profile"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "phonenumber": phonenumber,
        "location": location,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skill": List<dynamic>.from(skill.map((x) => x)),
        "Profile": profile,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
