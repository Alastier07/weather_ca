import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static const _mainFont = 'WorkSans';
  static const _isMaterial3 = true;

  final _appMainTheme = ThemeData(
    useMaterial3: _isMaterial3,
    fontFamily: _mainFont,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
  );

  final _appDarkTheme = ThemeData(
    useMaterial3: _isMaterial3,
    fontFamily: _mainFont,
    brightness: Brightness.dark,
  );

  bool? _isDarkMode;

  ThemeData get mainTheme => _appMainTheme;
  ThemeData get darkTheme => _appDarkTheme;
  bool? get isDarkMode => _isDarkMode;

  void setThemeMode(bool toDarkMode) {
    _isDarkMode = toDarkMode;
    notifyListeners();
  }
}
