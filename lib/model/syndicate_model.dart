// To parse this JSON data, do
//
//     final syndicateModel = syndicateModelFromMap(jsonString);

import 'dart:convert';

import 'package:sau_directory/model/employee_model.dart';

List<SyndicateModel> syndicateModelFromMap(String str) => List<SyndicateModel>.from(json.decode(str).map((x) => SyndicateModel.fromMap(x)));

String syndicateModelToMap(List<SyndicateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SyndicateModel {
  int id;
  String name;

  List<Employee> memberList;

  SyndicateModel({
    required this.id,
    required this.name,

    required this.memberList,
  });

  factory SyndicateModel.fromMap(Map<String, dynamic> json) => SyndicateModel(
    id: json["id"],
    name: json["name"],

    memberList: List<Employee>.from(
        json["memberList"].map((x) => Employee.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,

    "memberList": List<dynamic>.from(memberList.map((x) => x.toMap())),
  };
}

