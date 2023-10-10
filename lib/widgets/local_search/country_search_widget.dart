import 'package:flutter/material.dart';

import '../../models/country_model.dart';

class CountrySearchWidget extends StatefulWidget {
  const CountrySearchWidget({
    super.key,
    required this.countries,
    required this.pageController,
    required this.pickedCountry,
  });

  final List<Country>? countries;
  final PageController pageController;
  final ValueChanged<String> pickedCountry;

  @override
  State<CountrySearchWidget> createState() => _CountrySearchWidgetState();
}

class _CountrySearchWidgetState extends State<CountrySearchWidget> {
  final TextEditingController _nationController = TextEditingController();
  final FocusNode _nationNode = FocusNode();
  List<Country>? _countries;

  @override
  void initState() {
    super.initState();
    _countries = widget.countries;
  }

  @override
  void dispose() {
    super.dispose();
    _nationController.dispose();
    _nationNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _countries = widget.countries
        ?.where(
          (element) => element.countryName
              .toLowerCase()
              .contains(_nationController.text.toLowerCase()),
        )
        .toList();

    _countries?.sort((a, b) => a.countryName.compareTo(b.countryName));

    return WillPopScope(
      onWillPop: () async {
        if (_nationNode.hasFocus) {
          _nationNode.unfocus();
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        children: <Widget>[
          TextField(
            controller: _nationController,
            focusNode: _nationNode,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.public),
              labelText: 'Search',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _countries?.length,
                itemBuilder: (ctx, country) {
                  return ListTile(
                    title: Text(_countries![country].countryName),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      widget.pickedCountry(_countries![country].countryName);
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
