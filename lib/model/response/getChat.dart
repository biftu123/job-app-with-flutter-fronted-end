
import 'dart:convert';

List<Getchat> getchatFromJson(String str) => List<Getchat>.from(json.decode(str).map((x) => Getchat.fromJson(x)));

String getchatToJson(List<Getchat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getchat {
    final String id;
    final String chatname;
    final bool groupchat;
    final List<User> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final LatestMessage latestMessage;

    Getchat({
        required this.id,
        required this.chatname,
        required this.groupchat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.latestMessage,
    });

    factory Getchat.fromJson(Map<String, dynamic> json) => Getchat(
        id: json["_id"],
        chatname: json["chatname"],
        groupchat: json["Groupchat"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: LatestMessage.fromJson(json["LatestMessage"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatname": chatname,
        "Groupchat": groupchat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "LatestMessage": latestMessage.toJson(),
    };
}

class LatestMessage {
    final String id;
    final String sender;
    final String content;
    final String receiver;
    final String chat;
    final List<dynamic> readBy;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    LatestMessage({
        required this.id,
        required this.sender,
        required this.content,
        required this.receiver,
        required this.chat,
        required this.readBy,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: json["sender"],
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "content": content,
        "receiver": receiver,
        "chat": chat,
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
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
