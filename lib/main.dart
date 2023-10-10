import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/country_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/weather_provider.dart';
import 'weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const appTitle = 'Weather CA';
  final String? cachedLocation =
      await CountryProvider().retrieveCachedLocation();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CountryProvider>(
          create: (ctx) => CountryProvider(),
        ),
        ChangeNotifierProvider<WeatherProvider>(
          create: (ctx) => WeatherProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (ctx) => ThemeProvider(),
        ),
      ],
      child: WeatherApp(
        title: appTitle,
        showIntro: cachedLocation == null ? true : false,
      ),
    ),
  );
}
