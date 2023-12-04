import 'package:sau_directory/model/employee_model.dart';

class TitleModel {

  String name;
  dynamic about;

  List<Employee> employee;

  TitleModel({
    required this.name,
    this.about,
    required this.employee,
  });

  factory TitleModel.fromMap(Map<String, dynamic> json) => TitleModel(

    name: json["name"],
    about: json["about"],

    employee: List<Employee>.from(
        json["employee"].map((x) => Employee.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "about": about,
    "employee": List<dynamic>.from(employee.map((x) => x.toMap())),
  };
}