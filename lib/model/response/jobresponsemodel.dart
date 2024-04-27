import 'dart:convert';

List<JobResponse> jobResponseFromJson(String str) => List<JobResponse>.from(
      json.decode(str).map((x) => JobResponse.fromJson(x)),
    );

String jobResponseToJson(List<JobResponse> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class JobResponse {
  final String id;
  final String title;
  final String location;
  final String descrption; 
  final String salary;
  final String period;
  final String contract;
  final List<String> requirments; 
  final String imageUrl;
   
  final String 
company;


  JobResponse( {
    required this.id,
    required this.title,
    required this.location,
    required this.descrption,
    required this.salary,
    required this.period,
    required this.contract,
    required this.requirments,
    required this.imageUrl, 
   required this.company,
  });

  factory JobResponse.fromJson(Map<String, dynamic> json) => JobResponse(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        descrption: json["descrption"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirments: List<String>.from(json["requirments"].map((x) => x)),
        imageUrl: json["imageUrl"],
        company:json["company"],
       
        
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "descrption": descrption,
        "salary": salary,
        "period": period,
        "contract": contract,
        "requirments": List<dynamic>.from(requirments.map((x) => x)),
        "imageUrl": imageUrl,
      "company":company,
        
      };
}
