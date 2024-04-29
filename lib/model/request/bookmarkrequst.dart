
import 'dart:convert';

Bookmarkrequest bookmarkrequestFromJson(String str) => Bookmarkrequest.fromJson(json.decode(str));

String bookmarkrequestToJson(Bookmarkrequest data) => json.encode(data.toJson());

class Bookmarkrequest {
    final String job;

    Bookmarkrequest({
        required this.job,
    });

    factory Bookmarkrequest.fromJson(Map<String, dynamic> json) => Bookmarkrequest(
        job: json["job"],
    );

    Map<String, dynamic> toJson() => {
        "job": job,
    };
}
