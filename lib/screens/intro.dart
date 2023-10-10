import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';
import '../screens/home.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to $title',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Powered by',
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                'WeatherAPI',
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  initialValue: 'Manila',
                  onChanged: (value) => context
                      .read<CountryProvider>()
                      .setLocation(value == '' ? 'Manila' : value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Location',
                    hintText: 'Municipality or City',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName,
                  (route) => false,
                ),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
