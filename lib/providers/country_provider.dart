import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/country_model.dart';

class CountryProvider with ChangeNotifier {
  List<Country>? _countries;
  String _city = 'Manila'; // Manila ~ Default Location

  List<Country>? get countries => _countries;
  String get city => _city;

  Future<void> fetchCountries() async {
    final url = Uri.parse('https://countriesnow.space/api/v0.1/countries');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData['error']) {
        throw ('Extracting Error');
      }

      final finalData =
          (extractedData['data'] as List).cast<Map<String, dynamic>>();

      _countries =
          finalData.map<Country>((json) => Country.fromJson(json)).toList();

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  // Future<void> getIpLocation() async {
  //   final url = Uri.parse('http://ip-api.com/json');

  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;

  //     if (extractedData['status'] == 'success') {
  //       // _country = extractedData['country'] as String;
  //       _city = extractedData['city'] as String;
  //       // _iso = extractedData['countryCode'] as String;
  //       notifyListeners();
  //     } else {
  //       throw ('Extracting Error');
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  void setLocation(String local) {
    _city = local;
    cacheLocation(_city);
    notifyListeners();
  }

  void cacheLocation(String local) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('city', local);
  }

  Future<String?> retrieveCachedLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _city = prefs.getString('city') ?? _city;
    return prefs.getString('city');
  }
}
