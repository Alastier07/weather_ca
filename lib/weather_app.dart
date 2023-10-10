import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';

import 'screens/home.dart';
import 'screens/intro.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({
    required this.title,
    required this.showIntro,
    super.key,
  });

  final String title;
  final bool showIntro;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) {
        return MaterialApp(
          title: title,
          theme: theme.mainTheme,
          darkTheme: theme.darkTheme,
          themeMode: theme.isDarkMode == null
              ? ThemeMode.system
              : theme.isDarkMode!
                  ? ThemeMode.dark
                  : ThemeMode.light,
          home: showIntro ? IntroScreen(title: title) : const HomeScreen(),
          // initialRoute: ,
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
