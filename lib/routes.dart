import 'package:flutter/material.dart';
import 'package:sau_directory/model/faculty_model.dart';
import 'package:sau_directory/screen/about/about_screen.dart';
import 'package:sau_directory/screen/aboutvc/aboutvcscreen.dart';
import 'package:sau_directory/screen/academic/academic_screen.dart';
import 'package:sau_directory/screen/associations/associations_screen.dart';
import 'package:sau_directory/screen/deans/deans_screen.dart';
import 'package:sau_directory/screen/directory_division/directory_division_screen.dart';
import 'package:sau_directory/screen/facultydepartment/faculty_screen.dart';
import 'package:sau_directory/screen/facultydepartment/faculty_sub_screen.dart';
import 'package:sau_directory/screen/home/homescreen.dart';
import 'package:sau_directory/screen/introduction/introductionscreen.dart';
import 'package:sau_directory/screen/offices/offices_screen.dart';
import 'package:sau_directory/screen/others_contact/others_contacts_screen.dart';
import 'package:sau_directory/screen/splash/splash_screen.dart';
import 'package:sau_directory/screen/student_hall/student_hall_screen.dart';
import 'package:sau_directory/screen/test_screen.dart';
import 'package:sau_directory/screen/theme/theme_change_screen.dart';
import 'package:sau_directory/screen/thesyndicate/thesyndicatescreen.dart';
import 'package:sau_directory/screen/web/web_view_screen.dart';

class RouteName {
  static String splashScreen = '/';
  static String homeScreen = "/homeScreen";
  static String themeChangeScreen = '/themeChange';
  static String introductionScreen = "/introduction";
  static String aboutVc = '/aboutVc';
  static String deansScreen = "/deans";
  static String theSyndicateScreen = "/theSyndicateScreen";
  static String facultyScreen = '/faculty';
  static String facultySubScreen = '/facultysub';
  static String directoryDivision = '/directory';
  static String offices = '/offices';
  static String associations = '/associations';
  static String studentHall = '/studenthall';
  static String academic = '/academic';
  static String othersContact = '/othersContact';
  static String about = '/about';
  static String webScreen = '/webScreen';
  static String searchScreen = '/search';

  Map<String, WidgetBuilder> routes({Object? arg}) => {
        RouteName.splashScreen: (context) => const SplashScreen(),
        RouteName.homeScreen: (context) => const HomeScreen(),
        RouteName.themeChangeScreen: (context) => const ThemeScreen(),
        RouteName.introductionScreen: (context) => const IntroductionScreen(),
        RouteName.aboutVc: (context) => const AboutVCScreen(),
        RouteName.deansScreen: (context) => const DeansScreen(),
        RouteName.theSyndicateScreen: (context) => const TheSyndicateScreen(),
        RouteName.facultyScreen: (context) => const FacultyScreen(),
        RouteName.facultySubScreen: (context) =>
            FacultySubScreen(facultyModel: arg as FacultyModel),
        RouteName.directoryDivision: (context) => const DirectoryScreen(),
        RouteName.offices: (context) => const OfficesScreen(),
        RouteName.associations: (context) => const AssociationsScreen(),
        RouteName.academic: (context) => const AcademicScreen(),
        RouteName.studentHall: (context) => const StudentHallScreen(),
        RouteName.othersContact: (context) => const OthersContactScreen(),
        RouteName.about: (context) => const AboutScreen(),
        RouteName.webScreen: (context) => const WebViewScreen(),
        RouteName.searchScreen: (context) => const SearchScreen(),
      };

  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final Function? builder =
        routes(arg: routeSettings.arguments)[routeSettings.name];
    if (builder != null) {
      final Route route = MaterialPageRoute(
          settings: routeSettings, builder: (context) => builder(context));
      return route;
    } else {
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                appBar: AppBar(
                  title: const Text('Error'),
                ),
                body: Center(
                  child: Text('Page not found for ${routeSettings.name}'),
                ),
              ));
    }
  }
}
