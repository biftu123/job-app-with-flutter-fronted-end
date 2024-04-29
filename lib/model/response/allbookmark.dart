import 'dart:convert';

List<AllbookMark> allbookMarkFromJson(String str) =>
    List<AllbookMark>.from(json.decode(str).map((x) => AllbookMark.fromJson(x)));

String allbookMarkToJson(List<AllbookMark> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllbookMark {
  final String id;
  final Job job;
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AllbookMark({
    required this.id,
    required this.job,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AllbookMark.fromJson(Map<String, dynamic> json) => AllbookMark(
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
  final String description;
  final String company;
  final String salary;
  final String period;
  final String contract;
  final List<String> requirements;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.company,
    required this.salary,
    required this.period,
    required this.contract,
    required this.requirements,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        description: json["description"],
        company: json["company"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirements: List<String>.from(json["requirements"] ?? []),
        imageUrl: json["imageUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "description": description,
        "company": company,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "imageUrl": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}