// To parse this JSON data, do
//
//     final aboutVcModel = aboutVcModelFromMap(jsonString);

import 'dart:convert';

AboutVcModel aboutVcModelFromMap(String str) => AboutVcModel.fromMap(json.decode(str));

String aboutVcModelToMap(AboutVcModel data) => json.encode(data.toMap());

class AboutVcModel {

  String vcMessage;
  ViceChancellor viceChancellor;

  AboutVcModel({

    required this.vcMessage,
    required this.viceChancellor,
  });

  factory AboutVcModel.fromMap(Map<String, dynamic> json) => AboutVcModel(

    vcMessage: json["vc_message"],
    viceChancellor: ViceChancellor.fromMap(json["vice_chancellor"]),
  );

  Map<String, dynamic> toMap() => {

    "vc_message": vcMessage,
    "vice_chancellor": viceChancellor.toMap(),
  };
}

class ViceChancellor {

  String name;
  dynamic phone;
  String mobile;
  String email;

  ViceChancellor({
    required this.name,
    this.phone,
    required this.mobile,
    required this.email,
  });

  factory ViceChancellor.fromMap(Map<String, dynamic> json) => ViceChancellor(
    name: json["name"],
    phone: json["phone"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "phone": phone,
    "mobile": mobile,
    "email": email,
  };
}
