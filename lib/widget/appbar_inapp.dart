import 'package:flutter/material.dart';

class CustomAppbarInApp extends StatelessWidget implements PreferredSizeWidget {
  final String? appbarName;

  const CustomAppbarInApp({Key? key, required this.appbarName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.keyboard_double_arrow_left_sharp), // Put icon of your preference.
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      elevation: 0,
      title: Text(
        appbarName!,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
