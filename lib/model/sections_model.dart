// To parse this JSON data, do
//
//     final sectionModel = sectionModelFromMap(jsonString);

import 'dart:convert';

List<SectionModel> sectionModelFromMap(String str) => List<SectionModel>.from(json.decode(str).map((x) => SectionModel.fromMap(x)));

String sectionModelToMap(List<SectionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SectionModel {
  final int id;
  final String? name;
    dynamic priority;

  SectionModel({
    required this.id,
    this.name,
     this.priority,
  });

  factory SectionModel.fromMap(Map<String, dynamic> json) => SectionModel(
    id: json["id"],
    name: json["name"],
    priority: json["priority"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "priority": priority,
  };
}
