import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helper/util.dart';
import '../../models/weather_model.dart';

class WeatherWidget extends StatelessWidget with Util {
  const WeatherWidget({
    super.key,
    required this.weather,
    required this.nextPage,
    required this.previousPage,
    this.isFirstPage = false,
    this.isLastPage = false,
    required this.isPortrait,
  });

  final ForeCastWeather weather;
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final bool isFirstPage;
  final bool isLastPage;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    final String day = convertToDayDisplay(weather.date);
    final String date = convertToDateDisplay(weather.date);
    final String imageUrl =
        'https:${weather.conditionIconUrl.replaceAll(RegExp(r'64'), '128')}';
    final String temperature = '${weather.averageTemperatureC.round()}°';
    final String condition = weather.conditionText;
    final String wind = '${weather.maxWindKph.round()} kph';
    final String humidity = '${weather.averageHumidity}%';
    final String sunrise = weather.sunrise;
    final String sunset = weather.sunset;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          if (isPortrait)
            Align(
              alignment: Alignment.topCenter,
              child: IconButton(
                onPressed: isFirstPage ? null : previousPage,
                icon: const Icon(
                  Icons.keyboard_arrow_up,
                  size: 30,
                ),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  if (!isPortrait)
                    IconButton(
                      onPressed: isFirstPage ? null : previousPage,
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          day,
                          style: textTheme(context).headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date,
                          style: textTheme(context).titleMedium,
                        ),
                      ],
                    ),
                  ),
                  if (!isPortrait)
                    IconButton(
                      onPressed: isLastPage ? null : nextPage,
                      icon: const Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ),
                ],
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
                  if (!isPortrait) ...[
                    _otherDetailWidget(
                      title: 'Sunrise',
                      value: sunrise,
                      ctx: context,
                    ),
                    _otherDetailWidget(
                      title: 'Sunset',
                      value: sunset,
                      ctx: context,
                    ),
                  ]
                ],
              ),
              if (isPortrait)
                Row(
                  children: <Widget>[
                    _otherDetailWidget(
                      title: 'Sunrise',
                      value: sunrise,
                      ctx: context,
                    ),
                    _otherDetailWidget(
                      title: 'Sunset',
                      value: sunset,
                      ctx: context,
                    ),
                  ],
                ),
            ],
          ),
          if (isPortrait)
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                onPressed: isLastPage ? null : nextPage,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                ),
              ),
            ),
        ],
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
