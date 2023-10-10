import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helper/util.dart';
import '../../models/weather_model.dart';
import '../../screens/forecast.dart';

class ForecastWeatherWidget extends StatelessWidget with Util {
  const ForecastWeatherWidget({super.key, required this.weathers});

  final List<ForeCastWeather> weathers;

  @override
  Widget build(BuildContext context) {
    int weatherIndex = -1;

    return Column(
      children: <Widget>[
        Column(
          children: weathers.map(
            (weather) {
              weatherIndex += 1;

              final String urlImage = 'https:${weather.conditionIconUrl}';
              final String weatherCondition = weather.conditionText;
              final String temperature =
                  '${weather.averageTemperatureC.round()}°';
              final String date = convertToForcastDateDisplay(weather.date);
              final int index = weatherIndex;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: urlImage,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image_not_supported_rounded),
                  ),
                  title: Text(date),
                  subtitle: Text(weatherCondition),
                  trailing: Text(
                    temperature,
                    style: textTheme(context).titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  tileColor: Theme.of(context).hoverColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return ForecastScreen(initialIndex: index);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
