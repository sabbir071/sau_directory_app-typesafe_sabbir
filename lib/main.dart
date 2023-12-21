import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/config/theme_constants.dart';
import 'package:sau_directory/database/db_helper.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/provider/search_provider.dart';
import 'package:sau_directory/provider/theme_mode.dart';
import 'package:sau_directory/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var myAppInstance = MyApp();
  await myAppInstance.checkForUpdate();


  runApp(MultiProvider(

    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()..initialize()),
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),

    ],
    child: const MyApp(),
  ));


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
      builder: (context,provider,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SAU Directory',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: provider.themeMode,
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: (settings) {
              final Function? builders=
              RouteName().routes(arg: settings.arguments)[settings.name];
              if(builders!=null){
                return PageRouteBuilder(
                  settings: settings,
                  pageBuilder: (context, animation, secondaryAnimation) => builders(context),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // Start position of the new page
                    const end = Offset.zero; // End position of the new page
                    final tween = Tween(begin: begin, end: end);
                    final offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                );
              }else{
                return MaterialPageRoute(
                    builder: (_) =>
                        Scaffold(
                          appBar: AppBar(
                            title: const Text('Error'),
                          ),
                          body: Center(
                            child: Text('Page not found for ${settings.name}'),
                          ),
                        ));
              }
          },

        );
      }
    );

  }

 /* Future<void> checkForUpdate() async {
    print('Checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
       {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          print('Update Available');
          update();
        }
      };
    }).catchError((e) {
      print(e.toString());
    });
  }

  void update() async {
    print('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }*/


  Future<void> checkForUpdate() async {
    print('Checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        print('Update Available');
        update();
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  void update() async {
    print('Updating');
    await InAppUpdate.startFlexibleUpdate();
    try {
      await InAppUpdate.completeFlexibleUpdate();
      print('Update completed successfully!');
    } catch (e) {
      print('Error completing update: $e');
    }
  }






}


