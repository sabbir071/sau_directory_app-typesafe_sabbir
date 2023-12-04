// To parse this JSON data, do
//
//     final academicCalendar = academicCalendarFromJson(jsonString);

import 'dart:convert';

AcademicCalendar academicCalendarFromJson(String str) => AcademicCalendar.fromJson(json.decode(str));

String academicCalendarToJson(AcademicCalendar data) => json.encode(data.toJson());

class AcademicCalendar {
  int id;
  String mobile;
  String phone;
  String details;
  String? file;
  DateTime createdAt;
  DateTime updatedAt;

  AcademicCalendar({
    required this.id,
    required this.mobile,
    required this.phone,
    required this.details,
     this.file,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcademicCalendar.fromJson(Map<String, dynamic> json) => AcademicCalendar(
    id: json["id"],
    mobile: json["mobile"],
    phone: json["phone"],
    details: json["details"],
    file: json["file"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "phone": phone,
    "details": details,
    "file": file,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
