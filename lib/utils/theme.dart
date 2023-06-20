import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006D39),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF9AF6B3),
  onPrimaryContainer: Color(0xFF00210D),
  secondary: Color(0xFF006D39),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF85FAAA),
  onSecondaryContainer: Color(0xFF00210D),
  tertiary: Color(0xFF326B19),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFB2F491),
  onTertiaryContainer: Color(0xFF062100),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFF8FDFF),
  onBackground: Color(0xFF001F25),
  surface: Color(0xFFF8FDFF),
  onSurface: Color(0xFF001F25),
  surfaceVariant: Color(0xFFDDE5DB),
  onSurfaceVariant: Color(0xFF414941),
  outline: Color(0xFF717971),
  onInverseSurface: Color(0xFFD6F6FF),
  inverseSurface: Color(0xFF00363F),
  inversePrimary: Color(0xFF7FDA99),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006D39),
  outlineVariant: Color(0xFFC1C9BF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF7FDA99),
  onPrimary: Color(0xFF00391B),
  primaryContainer: Color(0xFF005229),
  onPrimaryContainer: Color(0xFF9AF6B3),
  secondary: Color(0xFF68DD90),
  onSecondary: Color(0xFF00391B),
  secondaryContainer: Color(0xFF005229),
  onSecondaryContainer: Color(0xFF85FAAA),
  tertiary: Color(0xFF97D778),
  onTertiary: Color(0xFF0F3900),
  tertiaryContainer: Color(0xFF195200),
  onTertiaryContainer: Color(0xFFB2F491),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF001F25),
  onBackground: Color(0xFFA6EEFF),
  surface: Color(0xFF001F25),
  onSurface: Color(0xFFA6EEFF),
  surfaceVariant: Color(0xFF414941),
  onSurfaceVariant: Color(0xFFC1C9BF),
  outline: Color(0xFF8B938A),
  onInverseSurface: Color(0xFF001F25),
  inverseSurface: Color(0xFFA6EEFF),
  inversePrimary: Color(0xFF006D39),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF7FDA99),
  outlineVariant: Color(0xFF414941),
  scrim: Color(0xFF000000),
);

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  SharedPreferences? prefs;

  ThemeMode get themeMode => _themeMode;
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    prefs!.setBool('isDark', _themeMode == ThemeMode.dark);
    notifyListeners();
  }

  void loadTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs!.getBool('isDark') == null) {
      prefs!.setBool('isDark', false);
    }

    _themeMode =
        prefs!.getBool('isDark') == true ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
