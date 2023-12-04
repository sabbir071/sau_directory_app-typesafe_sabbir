import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/provider/search_provider.dart';
import 'package:sau_directory/res/app_icon.dart';
import 'package:sau_directory/routes.dart';
import 'package:sau_directory/widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showIntroductionPage() {
    Navigator.pushNamed(context, RouteName.introductionScreen);
    print('Item 1 clicked!');
  }

  void showAboutVCPage() {
    Navigator.pushNamed(context, RouteName.aboutVc);
    print('Item 2 clicked!');
  }

  void showTheSyndicatePage() {
    // Logic for item 1 click event
    Navigator.pushNamed(context, RouteName.theSyndicateScreen);
    print('Item 1 clicked!');
  }

  void showDeansPage() {
    // Logic for item 2 click event

    Navigator.pushNamed(context, RouteName.deansScreen);
    print('Item 2 clicked!');
  }

  void showFacultyDepartmentTeachers() {
    // Logic for item 1 click event
    Navigator.pushNamed(context, RouteName.facultyScreen);
    print('Item 1 clicked!');
  }

  void showDirectorateDivisions() {
    // Logic for item 2 click event

    Navigator.pushNamed(context, RouteName.directoryDivision);
    print('Item 2 clicked!');
  }

  void showOfficesPage() {
    // Logic for item 1 click event
    Navigator.pushNamed(context, RouteName.offices);
    print('Item 1 clicked!');
  }

  void showAcademicCalenderClassRoutine() {
    // Logic for item 2 click event
    Navigator.pushNamed(context, RouteName.academic);
    print('Item 2 clicked!');
  }

  void showStudentHallPage() {
    Navigator.pushNamed(context, RouteName.studentHall);
    print('Item 1 clicked!');
  }

  void showAssociationsPage() {
    // Logic for item 2 click event
    Navigator.pushNamed(context, RouteName.associations);
    print('Item 2 clicked!');
  }

  void showOthersContactPage() {
    // Logic for item 1 click event
    Navigator.pushNamed(context, RouteName.othersContact);
    print('Item 1 clicked!');
  }

  void showAboutSAUDirectoryPage() {
    Navigator.pushNamed(context, RouteName.about);
    // Logic for item 2 click event
    print('Item 2 clicked!');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<AppProvider>(context, listen: false);
    provider.getVersionCheck(context);
    Provider.of<SearchProvider>(context, listen: false).getSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Consumer<AppProvider>(builder: (context, provider, child) {
        return DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to exit')),
          child: provider.isLoading || provider.sectionList == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 1,
                    maxCrossAxisExtent: 300,
                  ),
                  itemCount: provider.sectionList!.length,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      child: HomeItem(
                        name: provider.sectionList![position].name ?? '',
                        icon: getIcon(provider.sectionList![position].id),
                      ),
                      onTap: () {
                        navigatePage(provider.sectionList![position].id);
                      },
                    );
                  }),
        );
      }),
      drawer: const CustomDrawer(),
    );
  }

  getIcon(int i) {
    switch (i) {
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
    }
  }

  void navigatePage(int id) {
    switch (id) {
      case 1:
        {
          Navigator.pushNamed(context, RouteName.introductionScreen);
        }
      case 2:
        {
          Navigator.pushNamed(context, RouteName.aboutVc);
        }
      case 3:
        {
          Navigator.pushNamed(context, RouteName.theSyndicateScreen);
        }
      case 4:
        {
          Navigator.pushNamed(context, RouteName.deansScreen);
        }
      case 5:
        {
          Navigator.pushNamed(context, RouteName.facultyScreen);
        }
      case 6:
        {
          Navigator.pushNamed(context, RouteName.directoryDivision);
        }
      case 7:
        {
          Navigator.pushNamed(context, RouteName.offices);
        }
      case 8:
        {
          Navigator.pushNamed(context, RouteName.academic);
        }
      case 9:
        {
          Navigator.pushNamed(context, RouteName.studentHall);
        }
      case 10:
        {
          Navigator.pushNamed(context, RouteName.associations);
        }
      case 11:
        {
          Navigator.pushNamed(context, RouteName.othersContact);
        }
      case 12:
        {
          Navigator.pushNamed(context, RouteName.about);
        }
    }
  }
}
