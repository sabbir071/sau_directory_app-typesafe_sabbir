import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sau_directory/provider/search_provider.dart';
import 'package:sau_directory/routes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: const Text('SAU Directory'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: SizedBox(
            width: 35,
            height: 35,
            child: IconButton(
              icon: Image.asset('assets/images/search.png'),
              onPressed: () {
                Navigator.pushNamed(context, RouteName.searchScreen);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
