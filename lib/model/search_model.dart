// To parse this JSON data, do
//
//     final searchModel = searchModelFromMap(jsonString);

import 'dart:convert';

List<SearchModel> searchModelFromMap(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromMap(x)));

String searchModelToMap(List<SearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SearchModel {
  int id;
  String title;
  dynamic data;

  SearchModel({
    required this.id,
    required this.title,
    required this.data,
  });

  factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
    id: json["id"],
    title: json["title"],
    data: json["data"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "data": data,
  };
}

class Datum {
  int id;
  String name;
  int status;
  List<SupervisorData>? memberList;
  String? about;
  List<Title>? title;
  List<Department>? department;

  Datum({
    required this.id,
    required this.name,
    required this.status,
    this.memberList,
    this.about,
    this.title,
    this.department,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    memberList: json["memberList"] == null ? [] : List<SupervisorData>.from(json["memberList"]!.map((x) => SupervisorData.fromMap(x))),
    about: json["about"],
    title: json["title"] == null ? [] : List<Title>.from(json["title"]!.map((x) => Title.fromMap(x))),
    department: json["department"] == null ? [] : List<Department>.from(json["department"]!.map((x) => Department.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "status": status,
    "memberList": memberList == null ? [] : List<dynamic>.from(memberList!.map((x) => x.toMap())),
    "about": about,
    "title": title == null ? [] : List<dynamic>.from(title!.map((x) => x.toMap())),
    "department": department == null ? [] : List<dynamic>.from(department!.map((x) => x.toMap())),
  };
}

class Department {
  int id;
  int facultyId;
  String name;
  String about;
  int status;
  List<Designation> designation;

  Department({
    required this.id,
    required this.facultyId,
    required this.name,
    required this.about,
    required this.status,
    required this.designation,
  });

  factory Department.fromMap(Map<String, dynamic> json) => Department(
    id: json["id"],
    facultyId: json["faculty_id"],
    name: json["name"],
    about: json["about"],
    status: json["status"],
    designation: List<Designation>.from(json["designation"].map((x) => Designation.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "faculty_id": facultyId,
    "name": name,
    "about": about,
    "status": status,
    "designation": List<dynamic>.from(designation.map((x) => x.toMap())),
  };
}

class Designation {
  int id;
  String name;
  String about;
  int status;
  List<SupervisorData> employee;

  Designation({
    required this.id,
    required this.name,
    required this.about,
    required this.status,
    required this.employee,
  });

  factory Designation.fromMap(Map<String, dynamic> json) => Designation(
    id: json["id"],
    name: json["name"],
    about: json["about"],
    status: json["status"],
    employee: List<SupervisorData>.from(json["employee"].map((x) => SupervisorData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "about": about,
    "status": status,
    "employee": List<dynamic>.from(employee.map((x) => x.toMap())),
  };
}

class SupervisorData {
  int? id;
  String name;
  String? about;
  String? phone;
  String mobile;
  String? email;
  String? designation;

  SupervisorData({
    this.id,
    required this.name,
    this.about,
    this.phone,
    required this.mobile,
    this.email,
    this.designation,
  });

  factory SupervisorData.fromMap(Map<String, dynamic> json) => SupervisorData(
    id: json["id"],
    name: json["name"],
    about: json["about"],
    phone: json["phone"],
    mobile: json["mobile"],
    email: json["email"],
    designation: json["designation"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "about": about,
    "phone": phone,
    "mobile": mobile,
    "email": email,
    "designation": designation,
  };
}

class Title {
  int id;
  String name;
  String? about;
  int status;
  List<SupervisorData>? member;
  List<SupervisorData>? employee;

  Title({
    required this.id,
    required this.name,
    this.about,
    required this.status,
    this.member,
    this.employee,
  });

  factory Title.fromMap(Map<String, dynamic> json) => Title(
    id: json["id"],
    name: json["name"],
    about: json["about"],
    status: json["status"],
    member: json["member"] == null ? [] : List<SupervisorData>.from(json["member"]!.map((x) => SupervisorData.fromMap(x))),
    employee: json["employee"] == null ? [] : List<SupervisorData>.from(json["employee"]!.map((x) => SupervisorData.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "about": about,
    "status": status,
    "member": member == null ? [] : List<dynamic>.from(member!.map((x) => x.toMap())),
    "employee": employee == null ? [] : List<dynamic>.from(employee!.map((x) => x.toMap())),
  };
}

class DataClass {
  int? id;
  String? message;
  String? about;
  String? phone;
  String? email;
  String? sauLibrary;
  String? saures;
  String? sauOutreach;
  DateTime? createdAt;
  DateTime? updatedAt;
  ImportantPersons? importantPersons;
  AtAGlance? atAGlance;
  String? location;
  int? vcId;
  String? vcMessage;
  SupervisorData? viceChancellor;
  String? mobile;
  String? details;
  String? owner;
  SupervisorData? supervisorData;

  DataClass({
    this.id,
    this.message,
    this.about,
    this.phone,
    this.email,
    this.sauLibrary,
    this.saures,
    this.sauOutreach,
    this.createdAt,
    this.updatedAt,
    this.importantPersons,
    this.atAGlance,
    this.location,
    this.vcId,
    this.vcMessage,
    this.viceChancellor,
    this.mobile,
    this.details,
    this.owner,
    this.supervisorData,
  });

  factory DataClass.fromMap(Map<String, dynamic> json) => DataClass(
    id: json["id"],
    message: json["message"],
    about: json["about"],
    phone: json["phone"],
    email: json["email"],
    sauLibrary: json["sau_library"],
    saures: json["saures"],
    sauOutreach: json["sau_outreach"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    importantPersons: json["importantPersons"] == null ? null : ImportantPersons.fromMap(json["importantPersons"]),
    atAGlance: json["at_a_glance"] == null ? null : AtAGlance.fromMap(json["at_a_glance"]),
    location: json["location"],
    vcId: json["vc_id"],
    vcMessage: json["vc_message"],
    viceChancellor: json["vice_chancellor"] == null ? null : SupervisorData.fromMap(json["vice_chancellor"]),
    mobile: json["mobile"],
    details: json["details"],
    owner: json["owner"],
    supervisorData: json["supervisor_data"] == null ? null : SupervisorData.fromMap(json["supervisor_data"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "message": message,
    "about": about,
    "phone": phone,
    "email": email,
    "sau_library": sauLibrary,
    "saures": saures,
    "sau_outreach": sauOutreach,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "importantPersons": importantPersons?.toMap(),
    "at_a_glance": atAGlance?.toMap(),
    "location": location,
    "vc_id": vcId,
    "vc_message": vcMessage,
    "vice_chancellor": viceChancellor?.toMap(),
    "mobile": mobile,
    "details": details,
    "owner": owner,
    "supervisor_data": supervisorData?.toMap(),
  };
}

class AtAGlance {
  int faculty;
  int departments;
  int teachers;
  int officers;
  int staff;
  String students;
  int hall;
  int farm;

  AtAGlance({
    required this.faculty,
    required this.departments,
    required this.teachers,
    required this.officers,
    required this.staff,
    required this.students,
    required this.hall,
    required this.farm,
  });

  factory AtAGlance.fromMap(Map<String, dynamic> json) => AtAGlance(
    faculty: json["faculty"],
    departments: json["departments"],
    teachers: json["teachers"],
    officers: json["officers"],
    staff: json["staff"],
    students: json["students"],
    hall: json["hall"],
    farm: json["farm"],
  );

  Map<String, dynamic> toMap() => {
    "faculty": faculty,
    "departments": departments,
    "teachers": teachers,
    "officers": officers,
    "staff": staff,
    "students": students,
    "hall": hall,
    "farm": farm,
  };
}

class ImportantPersons {
  int vcId;
  String vcMessage;
  int proVcId;
  String proVcMessage;
  int treasurerId;
  String treasurerMessage;
  int registrarId;
  String registrarMessage;
  SupervisorData viceChancellor;
  SupervisorData proViceChancellor;
  SupervisorData registrar;
  SupervisorData treasurer;

  ImportantPersons({
    required this.vcId,
    required this.vcMessage,
    required this.proVcId,
    required this.proVcMessage,
    required this.treasurerId,
    required this.treasurerMessage,
    required this.registrarId,
    required this.registrarMessage,
    required this.viceChancellor,
    required this.proViceChancellor,
    required this.registrar,
    required this.treasurer,
  });

  factory ImportantPersons.fromMap(Map<String, dynamic> json) => ImportantPersons(
    vcId: json["vc_id"],
    vcMessage: json["vc_message"],
    proVcId: json["pro_vc_id"],
    proVcMessage: json["pro_vc_message"],
    treasurerId: json["treasurer_id"],
    treasurerMessage: json["treasurer_message"],
    registrarId: json["registrar_id"],
    registrarMessage: json["registrar_message"],
    viceChancellor: SupervisorData.fromMap(json["vice_chancellor"]),
    proViceChancellor: SupervisorData.fromMap(json["pro_vice_chancellor"]),
    registrar: SupervisorData.fromMap(json["registrar"]),
    treasurer: SupervisorData.fromMap(json["treasurer"]),
  );

  Map<String, dynamic> toMap() => {
    "vc_id": vcId,
    "vc_message": vcMessage,
    "pro_vc_id": proVcId,
    "pro_vc_message": proVcMessage,
    "treasurer_id": treasurerId,
    "treasurer_message": treasurerMessage,
    "registrar_id": registrarId,
    "registrar_message": registrarMessage,
    "vice_chancellor": viceChancellor.toMap(),
    "pro_vice_chancellor": proViceChancellor.toMap(),
    "registrar": registrar.toMap(),
    "treasurer": treasurer.toMap(),
  };
}
