import 'package:flutter/material.dart';
import 'package:sau_directory/config/constant.dart';
import 'package:sau_directory/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSelect = false;

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 100), () async {
      setState(() {
        isSelect = true;
      });
    });

    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.popAndPushNamed(context, RouteName.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF7B2), Colors.white],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: Image.asset(
              'assets/images/splash_top.png',
                fit: BoxFit.cover
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFD8D8D8),
            child: Center(
              child: AnimatedAlign(
                curve: Curves.easeIn,
                duration: const Duration(seconds: 1),
                alignment: isSelect ? Alignment.center : Alignment.centerLeft,
                child: const Text(
                  "SAU Directory",
                  style: TextStyle(
                      color: CustomColors.primary,
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedAlign(
              alignment: isSelect ? Alignment.center : Alignment.centerRight,
              curve: Curves.easeIn,
              duration: const Duration(seconds: 1),
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    Image.asset('assets/images/splash_bottom.png'),
                    Container(
                      width: 200,
                      height: .5,
                      color: Colors.grey,
                    ),
                    const Text(
                      'www.sau.edu.bd',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
