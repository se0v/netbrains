import 'package:flutter/material.dart';
import 'package:netbrains/themes/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dark_mode.dart';

class ThemeProvider with ChangeNotifier {
  // key for save state theme
  static const String themeKey = "themeMode";

  ThemeData _themeData = lightMode;

  // load save theme on initialization
  ThemeProvider() {
    loadTheme();
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    // save theme on change
    _saveTheme();

    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  // load theme from Shared Preferences
  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(themeKey) ?? false;
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }

  // save theme in Shared Preferences
  Future<void> _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, _themeData == darkMode);
  }
}
