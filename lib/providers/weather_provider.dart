import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../api_key.dart';
import '../models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  CurrentWeather _currentWeather = CurrentWeather();
  List<ForeCastWeather> _forecastWeather = [];

  CurrentWeather get currentWeather => _currentWeather;
  List<ForeCastWeather> get forecastWeather => _forecastWeather;

  Future<bool> fetchForecast({required String city}) async {
    final url = Uri(
      scheme: 'https',
      host: 'weatherapi-com.p.rapidapi.com',
      path: 'forecast.json',
      queryParameters: {'q': city, 'days': '3'},
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'X-RapidAPI-Key': weatherKey,
          'X-RapidAPI-Host': 'weatherapi-com.p.rapidapi.com'
        },
      );

      CurrentWeather loadedCurrent = CurrentWeather();
      final List<ForeCastWeather> loadedForecast = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      if (extractedData.containsKey('current') &&
          extractedData.containsKey('forecast')) {
        final currentData = extractedData['current'];
        final forecastDayData = extractedData['forecast']['forecastday'];

        loadedCurrent = CurrentWeather(
          lastUpdate: currentData['last_updated'],
          temperatureC: currentData['temp_c'],
          conditionText: currentData['condition']['text'],
          conditionIconUrl: currentData['condition']['icon'],
          windKph: currentData['wind_kph'],
          cloud: currentData['cloud'],
          humidity: currentData['humidity'],
        );

        for (Map forecast in forecastDayData) {
          loadedForecast.add(
            ForeCastWeather(
              date: forecast['date'],
              averageTemperatureC: forecast['day']['avgtemp_c'],
              maxWindKph: forecast['day']['maxwind_kph'],
              averageHumidity: forecast['day']['avghumidity'],
              conditionText: forecast['day']['condition']['text'],
              conditionIconUrl: forecast['day']['condition']['icon'],
              sunrise: forecast['astro']['sunrise'],
              sunset: forecast['astro']['sunset'],
            ),
          );
        }

        _currentWeather = loadedCurrent;
        _forecastWeather = loadedForecast;

        notifyListeners();
        return true;
      } else {
        throw ('Extracting Error');
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}
