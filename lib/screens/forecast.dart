import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/forecast/weather_widget.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    final countryReadProvider = context.read<CountryProvider>();
    final weatherReadProvider = context.read<WeatherProvider>();
    final forecastWeather = weatherReadProvider.forecastWeather;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${countryReadProvider.city} Forecast',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
              controller: _pageController,
              itemCount: forecastWeather.length,
              itemBuilder: (ctx, weather) {
                return WeatherWidget(
                  weather: forecastWeather[weather],
                  nextPage: () {
                    _pageController!.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  },
                  previousPage: () {
                    _pageController!.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  },
                  isFirstPage: weather == 0 ? true : false,
                  isLastPage:
                      weather == (forecastWeather.length - 1) ? true : false,
                  isPortrait: isPortrait,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
