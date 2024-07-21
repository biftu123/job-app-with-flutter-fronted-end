import 'dart:convert';

class ResponseForGetChat {
  final String id;
  final String chatName;
  final bool groupChat;
  final List<User> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LatestMessage latestMessage;

  ResponseForGetChat({
    required this.id,
    required this.chatName,
    required this.groupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.latestMessage,
  });

  factory ResponseForGetChat.fromJson(Map<String, dynamic> json) =>
      ResponseForGetChat(
        id: json["_id"],
        chatName: json["chatname"],
        groupChat: json["groupchat"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestMessage: LatestMessage.fromJson(json["latestMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatname": chatName,
        "groupchat": groupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestMessage": latestMessage.toJson(),
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

  LatestMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
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
      };
}

class User {
  final String id;
  final String username;
  final String email;
  final String phoneNumber;
  final String location;
  final bool isAdmin;
  final bool isAgent;
  final List<dynamic> skill;
  final String profile;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.location,
    required this.isAdmin,
    required this.isAgent,
    required this.skill,
    required this.profile,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phonenumber"],
        location: json["location"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skill: List<dynamic>.from(json["skill"].map((x) => x)),
        profile: json["Profile"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "phonenumber": phoneNumber,
        "location": location,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skill": List<dynamic>.from(skill.map((x) => x)),
        "Profile": profile,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

List<ResponseForGetChat> responseForGetChatFromJson(String str) =>
    List<ResponseForGetChat>.from(
        json.decode(str).map((x) => ResponseForGetChat.fromJson(x)));

String responseForGetChatToJson(List<ResponseForGetChat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));