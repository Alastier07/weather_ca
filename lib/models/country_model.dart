class Country {
  final String countryName;
  final String countryIso;
  final List citiesName;

  Country({
    required this.countryName,
    required this.countryIso,
    required this.citiesName,
  });

  factory Country.fromJson(Map<String, dynamic> country) {
    return Country(
      countryName: country['country'],
      countryIso: country['iso2'],
      citiesName: country['cities'] as List,
    );
  }
}
