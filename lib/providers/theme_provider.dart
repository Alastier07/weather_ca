import 'package:flutter/material.dart';

const _mainFont = 'WorkSans';
// const _secondaryFont = 'Galdeano';

class ThemeProvider extends ChangeNotifier {
  final _appMainTheme = ThemeData(
    fontFamily: _mainFont,
    appBarTheme: const AppBarTheme(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
  );

  final _appDarkTheme = ThemeData(
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
