// To parse this JSON data, do
//
//     final othersContactModel = othersContactModelFromMap(jsonString);

import 'dart:convert';

import 'package:sau_directory/model/employee_model.dart';

List<OthersContactModel> othersContactModelFromMap(String str) => List<OthersContactModel>.from(json.decode(str).map((x) => OthersContactModel.fromMap(x)));

String othersContactModelToMap(List<OthersContactModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OthersContactModel {
  int id;
  String name;
  dynamic about;

  List<Employee> memberList;

  OthersContactModel({
    required this.id,
    required this.name,
    this.about,

    required this.memberList,
  });

  factory OthersContactModel.fromMap(Map<String, dynamic> json) => OthersContactModel(
    id: json["id"],
    name: json["name"],
    about: json["about"],

    memberList: List<Employee>.from(json["memberList"].map((x) => Employee.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "about": about,

    "memberList": List<dynamic>.from(memberList.map((x) => x.toMap())),
  };
}

