import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/util.dart';
import '../../models/country_model.dart';
import '../../providers/country_provider.dart';
import '../../providers/weather_provider.dart';

class LocalSearchWidget extends StatefulWidget {
  const LocalSearchWidget({
    super.key,
    required this.pageController,
    required this.pickedCountry,
  });

  final PageController pageController;
  final String pickedCountry;

  @override
  State<LocalSearchWidget> createState() => _LocalSearchWidgetState();
}

class _LocalSearchWidgetState extends State<LocalSearchWidget> with Util {
  final TextEditingController _cityController = TextEditingController();
  List? _cities;

  Future<void> _updateLocal(String city) async {
    final countryReadProvider = context.read<CountryProvider>();
    final weatherReadProvider = context.read<WeatherProvider>();

    FocusManager.instance.primaryFocus?.unfocus();
    showLoading(context);
    countryReadProvider.setLocation(city);
    await weatherReadProvider
        .fetchForecast(
          city: countryReadProvider.city,
        )
        .then(
          (_) => Navigator.of(context).popUntil(
            ModalRoute.withName('/'),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final countryReadProvider = context.read<CountryProvider>();

    if (widget.pickedCountry.isNotEmpty) {
      Country result = countryReadProvider.countries
          ?.where((element) => element.countryName == widget.pickedCountry)
          .first as Country;
      _cities = result.citiesName;
      _cities = _cities?.where(
        (element) {
          String city = element;
          if (city.contains(_cityController.text)) {
            return true;
          } else {
            return false;
          }
        },
      ).toList();
      _cities?.sort((a, b) => a.compareTo(b));
    }

    return Column(
      children: [
        ListTile(
          minLeadingWidth: 0,
          leading: GestureDetector(
            onTap: () {
              widget.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },
            child: const Icon(Icons.keyboard_arrow_left_rounded),
          ),
          title: Text(widget.pickedCountry),
        ),
        TextField(
          controller: _cityController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_pin),
            labelText: 'Location',
            helperText:
                'Sorry to announce that Locals/Cities data are limited, but you can manually save your desire pin-point location.',
            helperMaxLines: 3,
            suffixIcon: GestureDetector(
              child: const Icon(Icons.save),
              onTap: () => _updateLocal(_cityController.text),
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
        Expanded(
          child: ListView.builder(
              itemCount: _cities?.length,
              itemBuilder: (ctx, city) {
                return ListTile(
                  title: Text(_cities![city]),
                  trailing: const Icon(Icons.save),
                  onTap: () => _updateLocal(_cities![city]),
                );
              }),
        ),
      ],
    );
  }
}
