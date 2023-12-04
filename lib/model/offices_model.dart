// To parse this JSON data, do
//
//     final officesModel = officesModelFromMap(jsonString);

import 'dart:convert';

import 'package:sau_directory/model/title_model.dart';

List<OfficesModel> officesModelFromMap(String str) => List<OfficesModel>.from(json.decode(str).map((x) => OfficesModel.fromMap(x)));

String officesModelToMap(List<OfficesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OfficesModel {
  int id;
  String name;
  dynamic about;

  List<TitleModel> title;

  OfficesModel({
    required this.id,
    required this.name,
    this.about,

    required this.title,
  });

  factory OfficesModel.fromMap(Map<String, dynamic> json) => OfficesModel(
    id: json["id"],
    name: json["name"],
    about: json["about"],

    title: List<TitleModel>.from(json["title"].map((x) => TitleModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "about": about,

    "title": List<dynamic>.from(title.map((x) => x.toMap())),
  };
}


