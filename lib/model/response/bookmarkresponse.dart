
import 'dart:convert';

Bookmarkresponse bookmarkresponseFromJson(String str) => Bookmarkresponse.fromJson(json.decode(str));

String bookmarkresponseToJson(Bookmarkresponse data) => json.encode(data.toJson());

class Bookmarkresponse {
    final Job job;
    final String userId;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;

    Bookmarkresponse({
        required this.job,
        required this.userId,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Bookmarkresponse.fromJson(Map<String, dynamic> json) => Bookmarkresponse(
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "job": job.toJson(),
        "userId": userId,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Job {
    final String id;
    final String title;
    final String location;
    final String descrption;
    final String company;
    final String salary;
    final String period;
    final String contract;
    final List<String> requirments;
    final String imageUrl;
    final int v;

    Job({
        required this.id,
        required this.title,
        required this.location,
        required this.descrption,
        required this.company,
        required this.salary,
        required this.period,
        required this.contract,
        required this.requirments,
        required this.imageUrl,
        required this.v,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        descrption: json["descrption"],
        company: json["company"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirments: List<String>.from(json["requirments"].map((x) => x)),
        imageUrl: json["imageUrl"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "descrption": descrption,
        "company": company,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirments": List<dynamic>.from(requirments.map((x) => x)),
        "imageUrl": imageUrl,
        "__v": v,
    };
}
