import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/app_provider.dart';
import 'package:sau_directory/provider/theme_mode.dart';
import 'package:sau_directory/res/app_icon.dart';
import 'package:sau_directory/routes.dart';

import 'widget.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List imageList = [
    {"id": 1, "image_path": AppIcon.slide1},
    {"id": 2, "image_path": AppIcon.slide2},
    {"id": 3, "image_path": AppIcon.slide3}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            child: Stack(
              children: [
                /* Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/drawer_bg.jpg'),
                    ),
                  ),
                ),*/
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: CarouselSlider(
                    items: imageList
                        .map((item) => Image.asset(
                              item['image_path'],
                              fit: BoxFit.contain,
                            ))
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        enlargeCenterPage: false,
                        viewportFraction: 1.0),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  child: SizedBox(
                    width: 40,
                    height: 50,
                    child: Image.asset('assets/images/sau_app_icon.png'),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  left: 20,
                  child: SimpleText(
                    text: 'Sher-e-Bangla Agricultural University',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: SizedBox(
              width: 25,
              height: 35,
              child: Image.asset('assets/images/Web.png'),
            ),
            title: const SimpleText(text: 'www.sau.edu.bd'),
            onTap: () {
              Navigator.pushNamed(context, RouteName.webScreen);
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: SimpleText(
              text: 'Preferences',
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: SizedBox(
              width: 25,
              height: 35,
              child: Image.asset('assets/images/Theme.png'),
            ),
            title: const SimpleText(text: 'Theme'),
            onTap: () {
              Navigator.pushNamed(context, RouteName.themeChangeScreen);
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 25,
              height: 35,
              child: Image.asset('assets/images/Font.png'),
            ),
            title: const SimpleText(text: 'Font appearance'),
            onTap: () {
              _showDialogSimple(context);
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: SimpleText(
              text: 'About',
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: SizedBox(
              width: 25,
              height: 35,
              child: Image.asset('assets/images/About.png'),
            ),
            title: const SimpleText(text: 'About SAU Directory'),
            onTap: () {
              Navigator.pushNamed(context, RouteName.about);
            },
          ),
          ListTile(
            leading: SizedBox(
              width: 25,
              height: 35,
              child: Image.asset('assets/images/Rate.png'),
            ),
            title: const SimpleText(text: 'Rate & Review'),
            onTap: () async {
              await LaunchReview.launch(
                  androidAppId: "com.saudirectory");
            },
          ),
          Consumer<AppProvider>(builder: (context, provider, child) {
            return ListTile(
              leading: SizedBox(
                width: 25,
                height: 35,
                child: Image.asset('assets/images/Update.png'),
              ),
              title: const SimpleText(text: 'Check Update'),
              onTap: () async {
                await provider.getCheckNewVersion(context);
              },
            );
          }),
        ],
      ),
    );
  }

  void _showDialogSimple(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            title: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: const Center(
                  child:
                      SimpleText(text: 'Font Appearance', color: Colors.white)),
            ),
            content: Container(
                height: 200,
                color: Colors.grey,
                child: Consumer<ThemeProvider>(
                    builder: (context, provider, child) {
                  return Center(
                    child: Column(
                      children: [
                        for (int i = 0; i < provider.fontValue.length; i++)
                          customRadioButton(
                              context,
                              provider.fontName[i],
                              provider.fontValue[i],
                              provider.currentValue,
                              (p0) => {provider.changeValue(p0)})
                      ],
                    ),
                  );
                })),
          );
        });
  }

  Widget customRadioButton(BuildContext dialogContext, String name,
      double value, double groupValue, Function(double) onValueChange) {
    return Center(
      child: ListTile(
        title: Text(name),
        leading: Radio(
          value: value,
          groupValue: groupValue,
          onChanged: (data) {
            onValueChange(data!);
            Navigator.pop(context);
          },
        ),
        onTap: () {
          onValueChange(value);
          Navigator.pop(context);
        },
      ),
    );
  }
}
