// To parse this JSON data, do
//
//     final associationModel = associationModelFromMap(jsonString);

import 'dart:convert';

import 'package:sau_directory/model/title_model.dart';

List<AssociationModel> associationModelFromMap(String str) =>
    List<AssociationModel>.from(
        json.decode(str).map((x) => AssociationModel.fromMap(x)));

String associationModelToMap(List<AssociationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class AssociationModel {
  int id;
  String name;
  dynamic about;

  List<TitleModel> title;

  AssociationModel({
    required this.id,
    required this.name,
    this.about,

    required this.title,
  });

  factory AssociationModel.fromMap(Map<String, dynamic> json) =>
      AssociationModel(
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


