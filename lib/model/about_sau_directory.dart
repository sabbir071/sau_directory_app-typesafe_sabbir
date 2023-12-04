// To parse this JSON data, do
//
//     final aboutSauDirectory = aboutSauDirectoryFromJson(jsonString);

import 'dart:convert';

AboutSauDirectory aboutSauDirectoryFromJson(String str) => AboutSauDirectory.fromJson(json.decode(str));

String aboutSauDirectoryToJson(AboutSauDirectory data) => json.encode(data.toJson());

class AboutSauDirectory {
  String about;
  String owner;
  SupervisorData supervisorData;

  AboutSauDirectory({
    required this.about,
    required this.owner,
    required this.supervisorData,
  });

  factory AboutSauDirectory.fromJson(Map<String, dynamic> json) => AboutSauDirectory(
    about: json["about"],
    owner: json["owner"],
    supervisorData: SupervisorData.fromJson(json["supervisor_data"]),
  );

  Map<String, dynamic> toJson() => {
    "about": about,
    "owner": owner,
    "supervisor_data": supervisorData.toJson(),
  };
}

class SupervisorData {
  String name;
  dynamic about;
  String designation;
  String mobile;
  dynamic phone;
  String email;

  SupervisorData({
    required this.name,
    this.about,
    required this.designation,
    required this.mobile,
    this.phone,
    required this.email,
  });

  factory SupervisorData.fromJson(Map<String, dynamic> json) => SupervisorData(
    name: json["name"],
    about: json["about"],
    designation: json["designation"],
    mobile: json["mobile"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "about": about,
    "designation": designation,
    "mobile": mobile,
    "phone": phone,
    "email": email,
  };
}
