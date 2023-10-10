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
}
