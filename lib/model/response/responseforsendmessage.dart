
import 'dart:convert';

Responseforsendtmessage responseforsendtmessageFromJson(String str) => Responseforsendtmessage.fromJson(json.decode(str));

String responseforsendtmessageToJson(Responseforsendtmessage data) => json.encode(data.toJson());

class Responseforsendtmessage {
    final String id;
    final Sender sender;
    final String content;
    final String receiver;
    final Chat chat;
    final List<dynamic> readBy;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Responseforsendtmessage({
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

    factory Responseforsendtmessage.fromJson(Map<String, dynamic> json) => Responseforsendtmessage(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: Chat.fromJson(json["chat"]),
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat.toJson(),
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Chat {
    final String id;
    final String chatname;
    final bool groupchat;
    final List<Sender> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Chat({
        required this.id,
        required this.chatname,
        required this.groupchat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        chatname: json["chatname"],
        groupchat: json["Groupchat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
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

class Sender {
    final String id;
    final String username;
    final String email;
    final String profile;

    Sender({
        required this.id,
        required this.username,
        required this.email,
        required this.profile,
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profile: json["Profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "Profile": profile,
    };
}
