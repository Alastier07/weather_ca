import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/util.dart';
import '../providers/country_provider.dart';
import '../widgets/local_search/country_search_widget.dart';
import '../widgets/local_search/local_search_widget.dart';
import 'error.dart';

class LocalSearchScreen extends StatefulWidget {
  const LocalSearchScreen({super.key});

  @override
  State<LocalSearchScreen> createState() => _LocalSearchScreenState();
}

class _LocalSearchScreenState extends State<LocalSearchScreen> with Util {
  final PageController _pageController = PageController();
  String _pickedCountry = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final countryReadProvider = context.read<CountryProvider>();
    final countryWatchProvider = context.watch<CountryProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(countryWatchProvider.city),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              if (countryWatchProvider.countries != null) ...[
                CountrySearchWidget(
                  countries: countryWatchProvider.countries,
                  pageController: _pageController,
                  pickedCountry: (value) => setState(
                    () {
                      _pickedCountry = value;
                    },
                  ),
                ),
                LocalSearchWidget(
                  pageController: _pageController,
                  pickedCountry: _pickedCountry,
                ),
              ] else
                ErrorScreen(
                  btnMessage: 'Reload',
                  refreshFunction: () async {
                    showLoading(context);
                    await countryReadProvider.fetchCountries().then(
                          (_) => Navigator.of(context).pop(),
                        );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
