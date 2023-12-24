import 'dart:developer' as console;
import 'dart:math';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/theme_mode.dart';
import 'package:sau_directory/widget/appbar_inapp.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarInApp(
        appbarName: 'Theme',
      ),
      body: Consumer<ThemeProvider>(builder: (context, provider, child) {
        return Container(
          color: Colors.grey[300],
          child: CircularMenu(
            alignment: Alignment.center,
            startingAngleInRadian: 1.5 * pi,
            endingAngleInRadian: 1.5 * pi,
            curve: Curves.easeOutCirc,
            // animation curve in reverse
            reverseCurve: Curves.easeInCirc,
            toggleButtonColor: Colors.green.shade900,
            toggleButtonBoxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 15,
              ),
            ],
            toggleButtonIconColor: Colors.white,
            toggleButtonMargin: 30.0,
            toggleButtonPadding: 15.0,
            toggleButtonSize: 30.0,
            // first item angle
            items: [
              CircularMenuItem(
                icon: Icons.sunny,
                onTap: () {
                  console.log('light');
                  provider.changeTheme('light');
                  Navigator.pop(context);
                },
                color: Colors.white,
                iconColor: Colors.black,
              ),
              CircularMenuItem(
                icon: Icons.cloud,
                onTap: () {
                  console.log('dark');
                  provider.changeTheme('dark');
                  Navigator.pop(context);
                },
                color: Colors.black,
                iconColor: Colors.white,

              ),
            ],
          ),
        );
      }),
    );
  }
}
