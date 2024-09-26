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

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(extractedData);
      if (extractedData.containsKey('current') &&
          extractedData.containsKey('forecast')) {
        final currentData = extractedData['current'] as Map<String, dynamic>;
        final forecastDayData =
            (extractedData['forecast']['forecastday'] as List)
                .cast<Map<String, dynamic>>();

        _currentWeather = CurrentWeather.fromJson(currentData);
        _forecastWeather = forecastDayData
            .map<ForeCastWeather>((json) => ForeCastWeather.fromJson(json))
            .toList();

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
