// To parse this JSON data, do
//
//     final facultyModel = facultyModelFromMap(jsonString);

import 'dart:convert';

import 'package:sau_directory/model/employee_model.dart';

List<FacultyModel> facultyModelFromMap(String str) => List<FacultyModel>.from(
    json.decode(str).map((x) => FacultyModel.fromMap(x)));

String facultyModelToMap(List<FacultyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class FacultyModel {
  int id;
  String name;
  String? about;
  List<Department> department;
  FacultyModel({
    required this.id,
    required this.name,
    this.about,
    required this.department,
  });

  factory FacultyModel.fromMap(Map<String, dynamic> json) => FacultyModel(
        id: json["id"],
        name: json["name"],
        about: json["about"],
        department: List<Department>.from(
            json["department"].map((x) => Department.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "about": about,

        "department": List<dynamic>.from(department.map((x) => x.toMap())),
      };
}

class Department {
  int id;
  String name;
  dynamic about;
  List<Designation> designation;

  Department({
    required this.id,
    required this.name,
    this.about,
    required this.designation,
  });

  factory Department.fromMap(Map<String, dynamic> json) => Department(
        id: json["id"],

        name: json["name"],
        about: json["about"],

        designation: List<Designation>.from(
            json["designation"].map((x) => Designation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "about": about,

        "designation": List<dynamic>.from(designation.map((x) => x.toMap())),
      };
}

class Designation {
  int id;
  String name;
  String? about;
  List<Employee> employee;

  Designation({
    required this.id,
    required this.name,
    this.about,

    required this.employee,
  });

  factory Designation.fromMap(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        about: json["about"],

        employee: List<Employee>.from(
            json["employee"].map((x) => Employee.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "about": about,

        "employee": List<dynamic>.from(employee.map((x) => x.toMap())),
      };
}

