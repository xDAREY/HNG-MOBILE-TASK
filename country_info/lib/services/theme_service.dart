import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryInfoThemeService {
  static const String _themeKey = 'isDarkMode';

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool(_themeKey) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setThemeMode(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }
}