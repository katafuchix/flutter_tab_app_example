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

/*
class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeNotifier() {
    _loadTheme();
  }

  // Загружаем тему из SharedPreferences

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  // Переключаем тему
  void toggleTheme() async {
    _isDarkTheme = !_isDarkTheme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
    notifyListeners();
  }

  // Возвращаем текущую тему
  ThemeData get currentTheme =>
      _isDarkTheme ? Themes.darkTheme : Themes.lightTheme;
}

*/
