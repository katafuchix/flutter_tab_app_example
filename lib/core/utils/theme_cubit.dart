import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final bool isDark;

  const ThemeState({required this.isDark});
}

class ThemeCubit extends Cubit<ThemeState> {
  static const _key = 'isDarkTheme';
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs)
      : super(ThemeState(isDark: _prefs.getBool(_key) ?? false));

  Future<void> setDark(bool value) async {
    if (state.isDark == value) return;
    emit(ThemeState(isDark: value));
    await _prefs.setBool(_key, value);
  }

  Future<void> toggle() => setDark(!state.isDark);
}
