
import 'dart:convert';

List<Allbookmark> allbookmarkFromJson(String str) => List<Allbookmark>.from(json.decode(str).map((x) => Allbookmark.fromJson(x)));

String allbookmarkToJson(List<Allbookmark> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allbookmark {
    final String id;
    final Job job;
    final String userId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    Allbookmark({
        required this.id,
        required this.job,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Allbookmark.fromJson(Map<String, dynamic> json) => Allbookmark(
        id: json["_id"],
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "job": job.toJson(),
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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
    final String agentId;
    final DateTime createdAt;
    final DateTime updatedAt;
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
        required this.agentId,
        required this.createdAt,
        required this.updatedAt,
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
        agentId: json["AgentId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
        "AgentId": agentId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
