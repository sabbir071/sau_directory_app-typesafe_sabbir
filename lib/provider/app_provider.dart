import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sau_directory/api/api.dart';
import 'package:sau_directory/api/private_api.dart';
import 'package:sau_directory/config/constant.dart';
import 'package:sau_directory/database/db_helper.dart';
import 'package:sau_directory/model/about_sau_directory.dart';
import 'package:sau_directory/model/aboutvc_model.dart';
import 'package:sau_directory/model/academic_calender.dart';
import 'package:sau_directory/model/association_model.dart';
import 'package:sau_directory/model/data_model.dart';
import 'package:sau_directory/model/deans_model.dart';
import 'package:sau_directory/model/directory_division_model.dart';
import 'package:sau_directory/model/faculty_model.dart';
import 'package:sau_directory/model/introduction_model.dart';
import 'package:sau_directory/model/offices_model.dart';
import 'package:sau_directory/model/others_contact_model.dart';
import 'package:sau_directory/model/sections_model.dart';
import 'package:sau_directory/model/student_hall_model.dart';
import 'package:sau_directory/model/syndicate_model.dart';
import 'package:sau_directory/res/app_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends PrivateAPI with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  DBHelper dbHelper = DBHelper();
  List<SectionModel>? sectionList;
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

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  bool isUpdate = false;

  bool isPdf = false;

  File? pdfFile;

  //var data;

  initConnectivity(BuildContext context) async {
    var status = await _connectivity.checkConnectivity();
    if (status == ConnectivityResult.none) {
      await showData(context);
      notifyListeners();
    } else {
      await getSectionData();
      await getIntroductionData();
      await getAboutVCData();
      await getSyndicateData();
      await getDeansData();
      await getFacultyDepartmentData();
      await getDirectoryDivisionData();
      await getOfficesData();
      await getAcademic();
      await getStudentHallData();
      await getAssociationData();
      await getOthersContactData();
      await getAboutSAUDirectory();
      await showData(context);
      notifyListeners();
    }
  }

  Future<void> showData(BuildContext context) async {

    await showSectionData();
    await showIntroductionData();
    await showAboutVCData();
    await showSyndicateData();
    await showDeansData();
    await showFacultyDepartmentData();
    await showDirectoryDivisionData();
    await showOfficesData();
    await showAcademicCalendarData();
    await showStudentHallData();
    await showAssociationsData();
    await showOtherContactData();
    await showAboutSAUDirectory();
    if (isUpdate) {
      isUpdate = false;
      Navigator.pop(context);
    }
    setLoading(false);
  }

  setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  Future<void> getVersionCheck(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var currentVersion = pref.getString("current_version");
    if (currentVersion != null) {
      log("offline version:$currentVersion");
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        initConnectivity(context);
        notifyListeners();
      } else {
        var response = await get(API.versionCheck);
        if (response.statusCode == 200) {
          var decoded = json.decode(response.body);
          log("online version:${decoded["version"]}");
          if (currentVersion != decoded["version"]) {
            await showAlertDialog(context, decoded);
          } else {
            if (await dbHelper.isAppsDataTableEmpty()) {
              await initConnectivity(context);
            } else {
              showData(context);
            }
          }
        }
      }
    } else {
      log("version empty");
      var response = await get(API.versionCheck);
      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('current_version', decoded["version"]);
        pref.setString('last_update_date', decoded["last_update"]);
      }
      initConnectivity(context);
    }
  }

  Future<void> getCheckNewVersion(BuildContext context) async {
    showCheckingAlertProgress(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var currentVersion = pref.getString("current_version");
    log(currentVersion!);
    var response = await get(API.versionCheck);

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      log(decoded["version"]);
      if (currentVersion != decoded["version"]) {
        log('update needed');
        Navigator.pop(context);
        await showAlertDialog(context, decoded);
      } else {
        Navigator.pop(context);
        var snackBar = const SnackBar(content: Text('There is no new version'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      var snackBar = const SnackBar(content: Text('There is no new version'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  showAlertDialog(BuildContext context, var decoded) async {
    // set up the button
    Widget laterButton = TextButton(
      child: const Text("LATER"),
      onPressed: () async {
        showData(context);
        Navigator.of(context).pop();
      },
    );

    Widget yesButton = TextButton(
      child: const Text("YES"),
      onPressed: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('current_version', decoded["version"]);
        pref.setString('last_update_date', decoded["last_update"]);
        Navigator.of(context).pop();
        showAlertProgress(context);
        await dbHelper.deleteDB();
        isUpdate = true;
        await initConnectivity(context);
        Navigator.of(context).pop();

      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Update notice!!"),
      content: const Text(
          "New data version has been arrived. Do you want to update app data?"),
      actions: [laterButton, yesButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertProgress(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = const AlertDialog(
        title: Text("Update notice!!"),
        content: Row(
          children: [Text("Fetching data.... "), CircularProgressIndicator()],
        ));
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showCheckingAlertProgress(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = const AlertDialog(
        title: Text("Update Checking!!"),
        content: Row(
          children: [Text("loading.... "), CircularProgressIndicator()],
        ));
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getSectionData() async {
    var response = await get(API.section);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'section', data: response.body))
          .then((value) => {print('section data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getIntroductionData() async {
    var response = await get(API.introduction);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'introduction', data: response.body))
          .then((value) => {print('data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getAboutVCData() async {
    var response = await get(API.aboutVc);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'aboutvc', data: response.body))
          .then((value) => {print('data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getSyndicateData() async {
    var response = await get(API.syndicates);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'syndicate', data: response.body))
          .then((value) => {print('syndicate get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getDeansData() async {
    var response = await get(API.deans);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'deans', data: response.body))
          .then((value) => {print('data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getFacultyDepartmentData() async {
    var response = await get(API.facultyDepartment);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'facultydepartment', data: response.body))
          .then((value) => {print('faculty_department data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getDirectoryDivisionData() async {
    var response = await get(API.directoryDivision);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'directory_division', data: response.body))
          .then((value) => {print('directory_division data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getOfficesData() async {
    var response = await get(API.offices);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'offices', data: response.body))
          .then((value) => {print('office data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getAcademic() async {

    Directory? dir;

    var response = await get(API.academicCalendar);
    if (response.statusCode == 200) {
      if (json.decode(response.body)['file'] != null) {
        String link = json.decode(response.body)['file'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        // Find the last dot in the URL
        int lastIndex = link.lastIndexOf('.');

        if (lastIndex != -1) {
          // Extract the file extension
          String extension = link.substring(lastIndex);

          if(extension == ".pdf"){
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setBool('isPDF', true);

            if (Platform.isAndroid) {
               dir = await getExternalStorageDirectory();
            } else {
               dir = await getApplicationDocumentsDirectory();
            }

            String savename = "file.pdf";
            String savePath = dir!.path + "/$savename";
            print(savePath);
            //output:  /storage/emulated/0/Download/banner.png
            print('check this url : $fileUrl$link');

            try {
              await Dio().download('$fileUrl$link', savePath,
                  onReceiveProgress: (received, total) {
                    if (total != -1) {
                      print((received / total * 100).toStringAsFixed(0) + "%");
                      //you can build progressbar feature too
                    }
                  });
              print("File is saved to download folder.");
            } on DioError catch (e) {
              print(e.message);
              print('check this url : $fileUrl$link');
            }
          }else{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setBool('isPDF', false);  //false

            if (Platform.isAndroid) {
              dir = await getExternalStorageDirectory();
            } else {
              dir = await getApplicationDocumentsDirectory();
            }

            String savename = "file.png";
            String savePath = dir!.path + "/$savename";
            print(savePath);
            //output:  /storage/emulated/0/Download/banner.png

            try {
              await Dio().download('$fileUrl$link', savePath,
                  onReceiveProgress: (received, total) {
                    if (total != -1) {
                      print((received / total * 100).toStringAsFixed(0) + "%");
                      //you can build progressbar feature too
                    }
                  });
              print("File is saved to download folder.");
            } on DioError catch (e) {
              print(e.message);
            }

          }

        }

        await dbHelper
            .insert(DataModel(title: 'academic', data: response.body))
            .then((value) => {print('academic data get and insert')})
            .onError((error, stackTrace) => {print(error.toString())});
      }
    }
  }

  getOthersContactData() async {
    var response = await get(API.othersContact);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'others_contact', data: response.body))
          .then((value) => {print('office data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getAssociationData() async {
    var response = await get(API.associations);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'associations', data: response.body))
          .then((value) => {print('associations data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getStudentHallData() async {
    var response = await get(API.studentHall);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'studenthall', data: response.body))
          .then((value) => {print('studenet hall data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  getAboutSAUDirectory() async {
    var response = await get(API.aboutSAUDirectory);
    if (response.statusCode == 200) {
      await dbHelper
          .insert(DataModel(title: 'about', data: response.body))
          .then((value) => {print('about directory data get and insert')})
          .onError((error, stackTrace) => {print(error.toString())});
    }
  }

  // show

  showSectionData() async {
    print("showSectionData");
    await dbHelper
        .getDataByTitle('section')
        .then((value) => {
              sectionList = sectionModelFromMap(value['data'].toString()),
              log('success'),
            })
        .onError((error, stackTrace) => {print(
        "error ${error.toString()}")});
    notifyListeners();
  }

  showIntroductionData() async {
    await dbHelper
        .getDataByTitle('introduction')
        .then((value) => {
              introductionModel =
                  introductionModelFromMap(value['data'].toString()),
            })
        .onError((error, stackTrace) => {});
    notifyListeners();
  }

  showAboutVCData() async {
    await dbHelper
        .getDataByTitle('aboutvc')
        .then((value) => {
              log(value['data'].toString()),
              aboutVCModel = aboutVcModelFromMap(value['data'].toString()),
            })
        .onError((error, stackTrace) => {});
    notifyListeners();
  }

  showSyndicateData() async {
    await dbHelper
        .getDataByTitle('syndicate')
        .then((value) => {
              syndicateList = syndicateModelFromMap(value['data'].toString()),
            })
        .onError((error, stackTrace) => {});
    notifyListeners();
  }

  showDeansData() async {
    await dbHelper
        .getDataByTitle('deans')
        .then((value) => {
              //  data=value['data'].toString(),
              deansModelList = deansModelFromMap(value['data'].toString()),
            })
        .onError((error, stackTrace) => {});

    notifyListeners();
  }

  showFacultyDepartmentData() async {
    await dbHelper
        .getDataByTitle('facultydepartment')
        .then((value) => {
              facultyModelList = facultyModelFromMap(value['data'].toString()),
            })
        .onError((error, stackTrace) => {});
    notifyListeners();
  }

  showDirectoryDivisionData() async {
    await dbHelper
        .getDataByTitle('directory_division')
        .then((value) => {
              directoryDivisionList =
                  directoryDivisionModelFromMap(value['data'].toString())
            })
        .onError((error, stackTrace) => {});
    notifyListeners();
  }

  showOfficesData() async {
    await dbHelper
        .getDataByTitle('offices')
        .then((value) => {
              log('office::'),
              officesList = officesModelFromMap(value['data'].toString())
            })
        .onError((error, stackTrace) => {log("null in office: ${error.toString()}")});
    notifyListeners();
  }

  showAcademicCalendarData() async {
    await dbHelper
        .getDataByTitle('academic')
        .then((value) => {
              log(value['data'].toString()),
              academicCalendar =
                  academicCalendarFromJson(value['data'].toString()),
            })
        .onError((error, stackTrace) => {log("null in academic: ${error.toString()}")});
    notifyListeners();
  }


  Future<void> convertFileFromData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isPdf= sharedPreferences.getBool('isPDF')?? false;
    log(isPdf.toString());

    Directory? dir;

    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    if(isPdf){
      pdfFile=File(dir!.path+'/file.pdf');
    }else{
      pdfFile=File(dir!.path+'/file.png');
    }
    log(pdfFile!.path);
    notifyListeners();
  }

  showOtherContactData() async {
    await dbHelper
        .getDataByTitle('others_contact')
        .then((value) => {
              log('othersContact::'),
              othersContactList =
                  othersContactModelFromMap(value['data'].toString())
            })
        .onError((error, stackTrace) => {log("null in other contact: ${error.toString()}")});
    notifyListeners();
  }

  showAssociationsData() async {
    await dbHelper
        .getDataByTitle('associations')
        .then((value) => {
              log('associations::'),
              associationList =
                  associationModelFromMap(value['data'].toString())
            })
        .onError((error, stackTrace) => {log("null in associations: ${error.toString()}")});
    notifyListeners();
  }

  showStudentHallData() async {
    await dbHelper
        .getDataByTitle('studenthall')
        .then((value) => {
              studentHallList =
                  studentHallModelFromMap(value['data'].toString())
            })
        .onError((error, stackTrace) => {});
    notifyListeners();
  }

/*  setData() async {
    //  log(data);
    try {
      studentHallList = studentHallModelFromMap(data);
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }*/

  showAboutSAUDirectory() async {
    await dbHelper
        .getDataByTitle('about')
        .then((value) => {
              aboutSauDirectory =
                  aboutSauDirectoryFromJson(value['data'].toString()),
            })
        .onError((error, stackTrace) => {});
    notifyListeners();
  }

  String getIcon(int id) {
    switch (id) {
      case 1:
        {
          return AppIcon.introIcon;
        }
      case 2:
        {
          return AppIcon.aboutVc;
        }
      case 3:
        {
          return AppIcon.syndicate;
        }
      case 4:
        {
          return AppIcon.deans;
        }
      case 5:
        {
          return AppIcon.faculty;
        }
      case 6:
        {
          return AppIcon.directory;
        }
      case 7:
        {
          return AppIcon.office;
        }
      case 8:
        {
          return AppIcon.academic;
        }
      case 9:
        {
          return AppIcon.studentHall;
        }
      case 10:
        {
          return AppIcon.associations;
        }
      case 11:
        {
          return AppIcon.othersContact;
        }
      case 12:
        {
          return AppIcon.aboutDirectory;
        }

      default:
        {
          return '';
        }
    }
  }
}
