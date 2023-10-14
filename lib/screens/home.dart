import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/util.dart';
import '../providers/country_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/home/current_weather_widget.dart';
import '../widgets/home/forecast_weather_widget.dart';
import '../widgets/home/location_widget.dart';
import 'error.dart';
import 'loading.dart';

class HomeScreen extends StatefulWidget {
  // static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Util {
  Future? _futureCountryData;

  @override
  void initState() {
    super.initState();

    _futureCountryData = Future(
      () async {
        // Fetch Country List Data
        context.read<CountryProvider>().fetchCountries();
        // Retreive Cached Location & Fetch Weather Data
        await context.read<CountryProvider>().retrieveCachedLocation().then(
              (_) async => await context.read<WeatherProvider>().fetchForecast(
                    city: context.read<CountryProvider>().city,
                  ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final countryWatchProvider = context.watch<CountryProvider>();
    final weatherWatchProvider = context.watch<WeatherProvider>();
    final weatherReadProvider = context.read<WeatherProvider>();
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FutureBuilder(
      future: _futureCountryData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          _futureCountryData = null;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Local Weather'),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
                onPressed: () => _refreshFunction(
                  weatherReadProvider,
                  countryWatchProvider,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.dark_mode,
                ),
                onPressed: () {
                  final themeProvider = context.read<ThemeProvider>();

                  themeProvider.setThemeMode(
                    themeProvider.isDarkMode == null
                        ? ThemeMode.system == ThemeMode.dark
                            ? true
                            : false
                        : !themeProvider.isDarkMode!,
                  );
                },
              ),
            ],
          ),
          body: weatherWatchProvider.forecastWeather.isNotEmpty
              ? isPortrait
                  ? Column(
                      children: <Widget>[
                        LocationWidget(
                          city: countryWatchProvider.city,
                          lastUpdate:
                              weatherWatchProvider.currentWeather.lastUpdate,
                        ),
                        CurrentWeatherWidget(
                          weather: weatherWatchProvider.currentWeather,
                        ),
                        ForecastWeatherWidget(
                          weathers: weatherWatchProvider.forecastWeather,
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Row(
                        children: [
                          CurrentWeatherWidget(
                            weather: weatherWatchProvider.currentWeather,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                LocationWidget(
                                  city: countryWatchProvider.city,
                                  lastUpdate: weatherWatchProvider
                                      .currentWeather.lastUpdate,
                                ),
                                ForecastWeatherWidget(
                                  weathers:
                                      weatherWatchProvider.forecastWeather,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
              : ErrorScreen(
                  refreshFunction: () => _refreshFunction(
                    weatherReadProvider,
                    countryWatchProvider,
                  ),
                ),
        );
      },
    );
  }

  void _refreshFunction(
    WeatherProvider weatherReadProvider,
    CountryProvider countryWatchProvider,
  ) async {
    showLoading(context);
    await weatherReadProvider
        .fetchForecast(
          city: countryWatchProvider.city,
        )
        .then(
          (_) => Navigator.pop(context),
        );
  }
}
