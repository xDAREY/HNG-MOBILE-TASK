import 'package:country_info/models/country_model.dart';

class FilteringService {
  static List<CountryModel> filterCountries(
      List<CountryModel> countries, String query) {
    query = query.trim().toLowerCase();
    return countries
        .where((country) => country.name.toLowerCase().contains(query))
        .toList();
  }

  static List<CountryModel> filterCountriesBySelection(
      List<CountryModel> countries,
      List<String> selectedContinents,
      List<String> selectedTimeZones) {
    return countries.where((country) {
      bool matchesContinent =
          selectedContinents.isEmpty || selectedContinents.contains(country.region);
      bool matchesTimeZone =
          selectedTimeZones.isEmpty || selectedTimeZones.contains(country.timeZone);
      return matchesContinent && matchesTimeZone;
    }).toList();
  }

  static Map<String, List<CountryModel>> groupCountriesByLetter(
      List<CountryModel> filteredCountries) {
    Map<String, List<CountryModel>> grouped = {};
    for (var country in filteredCountries) {
      String letter = country.name[0].toUpperCase();
      grouped.putIfAbsent(letter, () => []).add(country);
    }
    return grouped;
  }
}
