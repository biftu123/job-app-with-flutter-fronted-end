
import 'dart:convert';

RequestForSendMessege requestForSendMessegeFromJson(String str) => RequestForSendMessege.fromJson(json.decode(str));

String requestForSendMessegeToJson(RequestForSendMessege data) => json.encode(data.toJson());

class RequestForSendMessege {
    final String chatId;
    final String content;
    final String receiver;

    RequestForSendMessege({
        required this.chatId,
        required this.content,
        required this.receiver,
    });

    factory RequestForSendMessege.fromJson(Map<String, dynamic> json) => RequestForSendMessege(
        chatId: json["chatId"],
        content: json["content"],
        receiver: json["receiver"],
    );

    Map<String, dynamic> toJson() => {
        "chatId": chatId,
        "content": content,
        "receiver": receiver,
    };
}
