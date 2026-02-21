import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  static const _key = 'isDarkTheme';

  bool _isDarkTheme = false;
  SharedPreferences? _prefs;

  bool get isDarkTheme => _isDarkTheme;

  ThemeNotifier() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkTheme = _prefs!.getBool(_key) ?? false;
    notifyListeners();
  }

  Future<void> setDarkTheme(bool value) async {
    _isDarkTheme = value;
    await _prefs?.setBool(_key, value);
    notifyListeners();
  }

  Future<void> toggleTheme() => setDarkTheme(!_isDarkTheme);

  ThemeData get currentTheme =>
      _isDarkTheme ? Themes.darkTheme : Themes.lightTheme;
}
