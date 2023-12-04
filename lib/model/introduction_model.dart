// To parse this JSON data, do
//
//     final introductionModel = introductionModelFromMap(jsonString);

import 'dart:convert';

IntroductionModel introductionModelFromMap(String str) => IntroductionModel.fromMap(json.decode(str));

String introductionModelToMap(IntroductionModel data) => json.encode(data.toMap());

class IntroductionModel {
  int id;
  String? message;
  String location;
  String about;
  String phone;
  String email;
  String sauLibrary;
  String saures;
  String sauOutreach;
  DateTime createdAt;
  DateTime updatedAt;
  ImportantPersons importantPersons;
  AtAGlance atAGlance;

  IntroductionModel({
    required this.id,
    required this.message,
    required this.location,
    required this.about,
    required this.phone,
    required this.email,
    required this.sauLibrary,
    required this.saures,
    required this.sauOutreach,
    required this.createdAt,
    required this.updatedAt,
    required this.importantPersons,
    required this.atAGlance,
  });

  factory IntroductionModel.fromMap(Map<String, dynamic> json) => IntroductionModel(
    id: json["id"],
    message: json["message"],
    location: json["location"],
    about: json["about"],
    phone: json["phone"],
    email: json["email"],
    sauLibrary: json["sau_library"],
    saures: json["saures"],
    sauOutreach: json["sau_outreach"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    importantPersons: ImportantPersons.fromMap(json["importantPersons"]),
    atAGlance: AtAGlance.fromMap(json["at_a_glance"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "message": message,
    "location": location,
    "about": about,
    "phone": phone,
    "email": email,
    "sau_library": sauLibrary,
    "saures": saures,
    "sau_outreach": sauOutreach,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "importantPersons": importantPersons.toMap(),
    "at_a_glance": atAGlance.toMap(),
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
  String vcMessage;
  dynamic proVcMessage;
  dynamic treasurerMessage;
  dynamic registrarMessage;
  ProViceChancellor viceChancellor;
  ProViceChancellor proViceChancellor;
  ProViceChancellor registrar;
  ProViceChancellor treasurer;

  ImportantPersons({
    required this.vcMessage,
     this.proVcMessage,
     this.treasurerMessage,
     this.registrarMessage,
    required this.viceChancellor,
    required this.proViceChancellor,
    required this.registrar,
    required this.treasurer,
  });

  factory ImportantPersons.fromMap(Map<String, dynamic> json) => ImportantPersons(

    vcMessage: json["vc_message"],

    proVcMessage: json["pro_vc_message"],

    treasurerMessage: json["treasurer_message"],

    registrarMessage: json["registrar_message"],
    viceChancellor: ProViceChancellor.fromMap(json["vice_chancellor"]),
    proViceChancellor: ProViceChancellor.fromMap(json["pro_vice_chancellor"]),
    registrar: ProViceChancellor.fromMap(json["registrar"]),
    treasurer: ProViceChancellor.fromMap(json["treasurer"]),
  );

  Map<String, dynamic> toMap() => {

    "vc_message": vcMessage,

    "pro_vc_message": proVcMessage,

    "treasurer_message": treasurerMessage,

    "registrar_message": registrarMessage,
    "vice_chancellor": viceChancellor.toMap(),
    "pro_vice_chancellor": proViceChancellor.toMap(),
    "registrar": registrar.toMap(),
    "treasurer": treasurer.toMap(),
  };
}

class ProViceChancellor {
  dynamic id;
  String name;
  String? phone;
  String mobile;
  String? email;

  ProViceChancellor({
    required this.id,
    required this.name,
    this.phone,
    required this.mobile,
    this.email,
  });

  factory ProViceChancellor.fromMap(Map<String, dynamic> json) => ProViceChancellor(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone,
    "mobile": mobile,
    "email": email,
  };
}
