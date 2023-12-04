import 'package:flutter/material.dart';

import '../../../widget/widget.dart';

class HomeItem extends StatelessWidget {
  final String name;
  final String? icon;

  const HomeItem({
    Key? key,
    required this.name,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Color(0xFF558A2E),
              width: 1.0,
            ),
            bottom: BorderSide(
              color: Color(0xFF558A2E),
              width: 1.0,
            ),
          )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: const Color(0xFF558A2E),
                  borderRadius: BorderRadius.circular(100)),
              child: Image.asset(icon ?? ''),
            ),
            SimpleText3(
              text: name,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
