import 'package:flutter/material.dart';

const Color _darkPrimaryColor = Colors.black;
const Color _darkSecondaryColor = Colors.white;
const Color _lightPrimaryColor = Color(0xFF32691C);

const Color _lightPrimary = Color(0xFF207E24);

// item content card
const Color cardDarkColor = Color(0xFF222222);
const Color cardLightColor = _darkSecondaryColor;

// item card
const Color cardItemDarkColor = Color(0xFF222222);
const Color cardItemLightColor = _lightPrimaryColor;

const Color cardItemDark = Color(0xFF222222);
const Color cardItem = _lightPrimary;


ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,

    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white),
        color: _lightPrimaryColor,
        iconTheme: IconThemeData(
          color: _darkSecondaryColor,
        )),
    textTheme: const TextTheme(
        headline1: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 14,
            fontStyle: FontStyle.normal),
        headline2: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        headline3: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        headline5: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        )),
    cardColor: cardLightColor,
    cardTheme: CardTheme(
      color: cardItem,
      elevation: 5,
      shadowColor: Colors.grey
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: _darkPrimaryColor,
    appBarTheme: const AppBarTheme(
        color: _darkPrimaryColor,
        iconTheme: IconThemeData(
          color: _darkSecondaryColor,
        )),
    textTheme: const TextTheme(
        headline1: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal),
        headline2: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        )),
    cardColor: cardDarkColor,
    cardTheme: CardTheme(
      color: cardItemDarkColor,
      elevation: 5,
        shadowColor: Colors.black
    ),
);
