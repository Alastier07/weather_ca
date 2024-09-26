class CurrentWeather {
  CurrentWeather({
    this.lastUpdate = '',
    this.temperatureC = 0,
    this.conditionText = '',
    this.conditionIconUrl = '',
    this.windKph = 0,
    this.cloud = 0,
    this.humidity = 0,
  });

  final String lastUpdate;
  final num temperatureC;
  final String conditionText;
  final String conditionIconUrl;
  final num windKph;
  final num cloud;
  final num humidity;

  factory CurrentWeather.fromJson(Map<String, dynamic> current) {
    return CurrentWeather(
      lastUpdate: current['last_updated'],
      temperatureC: current['temp_c'],
      conditionText: current['condition']['text'],
      conditionIconUrl: current['condition']['icon'],
      windKph: current['wind_kph'],
      cloud: current['cloud'],
      humidity: current['humidity'],
    );
  }
}

class ForeCastWeather {
  ForeCastWeather({
    required this.date,
    required this.averageTemperatureC,
    required this.maxWindKph,
    required this.averageHumidity,
    required this.conditionText,
    required this.conditionIconUrl,
    required this.sunrise,
    required this.sunset,
  });

  final String date;
  final num averageTemperatureC;
  final num maxWindKph;
  final num averageHumidity;
  final String conditionText;
  final String conditionIconUrl;
  final String sunrise;
  final String sunset;

  factory ForeCastWeather.fromJson(Map<String, dynamic> forecast) {
    return ForeCastWeather(
      date: forecast['date'],
      averageTemperatureC: forecast['day']['avgtemp_c'],
      maxWindKph: forecast['day']['maxwind_kph'],
      averageHumidity: forecast['day']['avghumidity'],
      conditionText: forecast['day']['condition']['text'],
      conditionIconUrl: forecast['day']['condition']['icon'],
      sunrise: forecast['astro']['sunrise'],
      sunset: forecast['astro']['sunset'],
    );
  }
}
