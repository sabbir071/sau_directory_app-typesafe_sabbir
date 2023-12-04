// To parse this JSON data, do
//
//     final deansModel = deansModelFromMap(jsonString);

import 'dart:convert';

import 'package:sau_directory/model/employee_model.dart';

List<DeansModel> deansModelFromMap(String str) => List<DeansModel>.from(json.decode(str).map((x) => DeansModel.fromMap(x)));

String deansModelToMap(List<DeansModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DeansModel {
  int id;
  String name;
  String? about;
  List<DeansModel>? title;
  List<Employee>? member;

  DeansModel({
    required this.id,
    required this.name,
    this.about,
    this.title,
    this.member,
  });

  factory DeansModel.fromMap(Map<String, dynamic> json) => DeansModel(
    id: json["id"],
    name: json["name"],
    about: json["about"],

    title: json["title"] == null ? [] : List<DeansModel>.from(json["title"]!.map((x) => DeansModel.fromMap(x))),
    member: json["member"] == null ? [] : List<Employee>.from(json["member"]!.map((x) => Employee.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "about": about,
    "title": title == null ? [] : List<dynamic>.from(title!.map((x) => x.toMap())),
    "member": member == null ? [] : List<dynamic>.from(member!.map((x) => x.toMap())),
  };
}

