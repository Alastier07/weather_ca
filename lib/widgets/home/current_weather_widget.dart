import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helper/util.dart';
import '../../models/weather_model.dart';

class CurrentWeatherWidget extends StatelessWidget with Util {
  const CurrentWeatherWidget({super.key, required this.weather});

  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    final String lastUpdateDay = convertToDayDisplay(weather.lastUpdate);
    final String lastUpdateTime = convertToDateDisplay(weather.lastUpdate);
    final String imageUrl =
        'https:${weather.conditionIconUrl.replaceAll(RegExp(r'64'), '128')}';
    final String temperature = '${weather.temperatureC.round()}°';
    final String condition = weather.conditionText;
    final String wind = '${weather.windKph.round()} kph';
    final String humidity = '${weather.humidity}%';
    final String cloud = '${weather.cloud}%';

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lastUpdateDay,
              style: textTheme(context).headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              lastUpdateTime,
              style: textTheme(context).titleMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.image_not_supported_rounded),
                    ),
                  ),
                ),
                Text(
                  temperature,
                  style: textTheme(context).displayMedium?.copyWith(
                        color: textTheme(context).bodyMedium?.color,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              condition,
              style: textTheme(context).titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                _otherDetailWidget(
                  title: 'Wind',
                  value: wind,
                  ctx: context,
                ),
                _otherDetailWidget(
                  title: 'Humidity',
                  value: humidity,
                  ctx: context,
                ),
                _otherDetailWidget(
                  title: 'Cloud',
                  value: cloud,
                  ctx: context,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _otherDetailWidget({
    required String title,
    required String value,
    required BuildContext ctx,
  }) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: textTheme(ctx).titleMedium,
              ),
              Text(
                value,
                style: textTheme(ctx)
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}
