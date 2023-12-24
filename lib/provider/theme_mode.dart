import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'light';

  double currentValue = 1.0;

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  List<double> fontValue = <double>[.80, 1.0, 1.50];

  List<String> fontName = <String>['Small', 'Medium', 'Large'];

  changeValue(double data) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble('font', data);
    currentValue = data;
    notifyListeners();
  }

  changeTheme(String theme) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('theme', theme);
    currentTheme = theme;
    notifyListeners();
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentTheme = _prefs.getString('theme') ?? 'light';
    currentValue = _prefs.getDouble('font') ?? 1.0;
    notifyListeners();
  }
}
