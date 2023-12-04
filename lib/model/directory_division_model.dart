// To parse this JSON data, do
//
//     final directoryDivisionModel = directoryDivisionModelFromMap(jsonString);

import 'dart:convert';
import 'package:sau_directory/model/title_model.dart';

List<DirectoryDivisionModel> directoryDivisionModelFromMap(String str) =>
    List<DirectoryDivisionModel>.from(
        json.decode(str).map((x) => DirectoryDivisionModel.fromMap(x)));

String directoryDivisionModelToMap(List<DirectoryDivisionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DirectoryDivisionModel {
  int id;
  String name;
  dynamic about;

  List<TitleModel> title;

  DirectoryDivisionModel({
    required this.id,
    required this.name,
    this.about,

    required this.title,
  });

  factory DirectoryDivisionModel.fromMap(Map<String, dynamic> json) =>
      DirectoryDivisionModel(
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
