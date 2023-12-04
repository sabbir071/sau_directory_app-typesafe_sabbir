import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sau_directory/database/db_helper.dart';
import 'package:sau_directory/model/about_sau_directory.dart';
import 'package:sau_directory/model/aboutvc_model.dart';
import 'package:sau_directory/model/academic_calender.dart';
import 'package:sau_directory/model/association_model.dart';
import 'package:sau_directory/model/deans_model.dart';
import 'package:sau_directory/model/directory_division_model.dart';
import 'package:sau_directory/model/employee_model.dart';
import 'package:sau_directory/model/faculty_model.dart';
import 'package:sau_directory/model/introduction_model.dart';
import 'package:sau_directory/model/offices_model.dart';
import 'package:sau_directory/model/others_contact_model.dart';
import 'package:sau_directory/model/student_hall_model.dart';
import 'package:sau_directory/model/syndicate_model.dart';
import 'package:sau_directory/model/title_model.dart';

class SearchProvider extends ChangeNotifier {
  DBHelper dbHelper = DBHelper();
  late List<Map<String, Object?>> data;

  IntroductionModel? introductionModel;
  List<DeansModel>? deansModelList;
  List<FacultyModel>? facultyModelList;
  List<DirectoryDivisionModel>? directoryDivisionList;
  List<OfficesModel>? officesList;
  AcademicCalendar? academicCalendar;
  List<OthersContactModel>? othersContactList;
  List<AssociationModel>? associationList;
  List<StudentHallModel>? studentHallList;
  AboutVcModel? aboutVCModel;
  List<SyndicateModel>? syndicateList;
  AboutSauDirectory? aboutSauDirectory;

  final TextEditingController _textEditingController = TextEditingController();

  TextEditingController get textEditingController => _textEditingController;

  final List<Employee> _employeeList = [];

  List<Employee> _searchEmployeeList = [];

  List<Employee> get searchEmployeeList => _searchEmployeeList;

  Future<void> textWatcher(String text) async {
    if (text.isEmpty) {
      _searchEmployeeList = _employeeList;
    }
    _searchEmployeeList = searchEmployees(_employeeList, text);
    notifyListeners();
  }

  getSearch() async {
    await dbHelper
        .getDataColumn()
        .then((value) => {data = value!})
        .onError((error, stackTrace) => {});
    await analyzeData();
  }

  Future<void> analyzeData() async {
    for (int i = 0; i < data.length; i++) {
      if (data[i]['title'] == 'introduction') {
        introductionModel =
            introductionModelFromMap(data[i]['data'].toString());
        await introDataDesign();
      } else if (data[i]['title'] == 'aboutvc') {
        aboutVCModel = aboutVcModelFromMap(data[i]['data'].toString());
        await aboutVcDataDesign();
      } else if (data[i]['title'] == 'syndicate') {
        syndicateList = syndicateModelFromMap(data[i]['data'].toString());
        await syndicateDataDesign();
      } else if (data[i]['title'] == 'deans') {
        deansModelList = deansModelFromMap(data[i]['data'].toString());
        await deansDataDesign();
      } else if (data[i]['title'] == 'facultydepartment') {
        facultyModelList = facultyModelFromMap(data[i]['data'].toString());
        facultyDataDesign();
      } else if (data[i]['title'] == 'directory_division') {
        directoryDivisionList =
            directoryDivisionModelFromMap(data[i]['data'].toString());
        await directorateDataDesign();
      } else if (data[i]['title'] == 'offices') {
        officesList = officesModelFromMap(data[i]['data'].toString());
        await officesDataDesign();
      } else if (data[i]['title'] == 'academic') {
        academicCalendar = academicCalendarFromJson(data[i]['data'].toString());
        await academicDataDesign();
      } else if (data[i]['title'] == 'others_contact') {
        othersContactList =
            othersContactModelFromMap(data[i]['data'].toString());
        await othersContactDataDesign();
      } else if (data[i]['title'] == 'associations') {
        associationList = associationModelFromMap(data[i]['data'].toString());
        await associationsDataDesign();
      } else if (data[i]['title'] == 'studenthall') {
        studentHallList = studentHallModelFromMap(data[i]['data'].toString());
        await studentHallDataDesign();
      } else if (data[i]['title'] == 'about') {
        aboutSauDirectory =
            aboutSauDirectoryFromJson(data[i]['data'].toString());
        await aboutSauDataDesign();
      }
    }

    notifyListeners();
  }

  introDataDesign() async {
    if (introductionModel != null) {
      Employee employee = Employee(

          name: introductionModel!.importantPersons.viceChancellor.name,
          phone: introductionModel!.importantPersons.viceChancellor.phone,
          mobile: introductionModel!.importantPersons.viceChancellor.mobile,
          email: introductionModel!.importantPersons.viceChancellor.email);
      Employee employee1 = Employee(

          name: introductionModel!.importantPersons.proViceChancellor.name,
          phone: introductionModel!.importantPersons.proViceChancellor.phone,
          mobile: introductionModel!.importantPersons.proViceChancellor.mobile,
          email: introductionModel!.importantPersons.proViceChancellor.email);
      Employee employee2 = Employee(

          name: introductionModel!.importantPersons.treasurer.name,
          phone: introductionModel!.importantPersons.treasurer.phone,
          mobile: introductionModel!.importantPersons.treasurer.mobile,
          email: introductionModel!.importantPersons.treasurer.email);
      Employee employee3 = Employee(

          name: introductionModel!.importantPersons.registrar.name,
          phone: introductionModel!.importantPersons.registrar.phone,
          mobile: introductionModel!.importantPersons.registrar.mobile,
          email: introductionModel!.importantPersons.registrar.email);
      _employeeList.add(employee);
      _employeeList.add(employee1);
      _employeeList.add(employee2);
      _employeeList.add(employee3);
    }
  }

  aboutVcDataDesign() async {
    if (aboutVCModel != null) {
      Employee employee = Employee(
          name: aboutVCModel!.viceChancellor.name,
          phone: aboutVCModel!.viceChancellor.phone,
          mobile: aboutVCModel!.viceChancellor.mobile,
          email: aboutVCModel!.viceChancellor.email);
      _employeeList.add(employee);
    }
  }

  syndicateDataDesign() async {
    if (syndicateList != null) {
      for (SyndicateModel syndicateModel in syndicateList!) {
        _employeeList.addAll(syndicateModel.memberList);
      }
    }
  }

  deansDataDesign() async {
    if (deansModelList != null) {
      for (DeansModel deans in deansModelList!) {
        _employeeList.addAll(deans.member!);
      }
    }
  }

  facultyDataDesign() async {
    if (facultyModelList != null) {
      for (FacultyModel facultyModel in facultyModelList!) {
        for (Department department in facultyModel.department) {
          for (Designation designation in department.designation) {
            _employeeList.addAll(designation.employee);
          }
        }
      }
    }
  }

  directorateDataDesign() async {
    if (directoryDivisionList != null) {
      for (DirectoryDivisionModel directoryModel in directoryDivisionList!) {
        for (TitleModel title in directoryModel.title) {
          _employeeList.addAll(title.employee);
        }
      }
    }
  }

  officesDataDesign() async {
    if (officesList != null) {
      for (OfficesModel officeModel in officesList!) {
        for (TitleModel title in officeModel.title) {
          _employeeList.addAll(title.employee);
        }
      }
    }
  }

  academicDataDesign() async {
    if (academicCalendar != null) {
      Employee employee = Employee(
          name: "Academic Calender",
          phone: academicCalendar!.phone,
          mobile: academicCalendar!.mobile,
          email: academicCalendar!.details);
      _employeeList.add(employee);
    }
  }

  studentHallDataDesign() async {
    if (studentHallList != null) {
      for (StudentHallModel studentHall in studentHallList!) {
        for (TitleModel title in studentHall.title!) {
          _employeeList.addAll(title.employee);
        }
      }
    }
  }

  associationsDataDesign() async {
    if (associationList != null) {
      for (AssociationModel associateModel in associationList!) {
        for (TitleModel title in associateModel.title) {
          _employeeList.addAll(title.employee);
        }
      }
    }
  }

  othersContactDataDesign() async {
    if (othersContactList != null) {
      for (OthersContactModel othersContact in othersContactList!) {
        _employeeList.addAll(othersContact.memberList);
      }
    }
  }

  aboutSauDataDesign() async {
    if (aboutSauDirectory != null) {
      Employee employee = Employee(
        about: aboutSauDirectory!.supervisorData.about,
        name: aboutSauDirectory!.supervisorData.name,
        phone: aboutSauDirectory!.supervisorData.phone,
        mobile: aboutSauDirectory!.supervisorData.mobile,
        email: aboutSauDirectory!.supervisorData.email,
      );
      _employeeList.add(employee);
    }
  }
}
