
import 'dart:convert';

Requstforsinitmessage requstforsinitmessageFromJson(String str) => Requstforsinitmessage.fromJson(json.decode(str));

String requstforsinitmessageToJson(Requstforsinitmessage data) => json.encode(data.toJson());

class Requstforsinitmessage {
    final String id;

    Requstforsinitmessage({
        required this.id,
    });

    factory Requstforsinitmessage.fromJson(Map<String, dynamic> json) => Requstforsinitmessage(
        id: json["Id"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
    };
}
