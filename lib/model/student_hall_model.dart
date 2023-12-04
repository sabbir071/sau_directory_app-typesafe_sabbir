// To parse this JSON data, do
//
//     final studentHallModel = studentHallModelFromMap(jsonString);

import 'dart:convert';
import 'package:sau_directory/model/title_model.dart';

List<StudentHallModel> studentHallModelFromMap(String str) => List<StudentHallModel>.from(json.decode(str).map((x) => StudentHallModel.fromMap(x)));

String studentHallModelToMap(List<StudentHallModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class StudentHallModel {
  int? id;
  String? name;
  dynamic about;

  List<TitleModel> title;

  StudentHallModel({
    this.id,
    this.name,
    this.about,

   required this.title,
  });

  factory StudentHallModel.fromMap(Map<String, dynamic> json) => StudentHallModel(
    id: json["id"],
    name: json["name"],
    about: json["about"],
    title: json["title"] == null ? [] : List<TitleModel>.from(json["title"]!.map((x) => TitleModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "about": about,

    "title": title == null ? [] : List<dynamic>.from(title!.map((x) => x.toMap())),
  };
}

