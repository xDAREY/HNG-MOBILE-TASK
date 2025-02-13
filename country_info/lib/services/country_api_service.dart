import 'dart:convert';
import 'package:country_info/models/country_model.dart';
import 'package:http/http.dart' as http;

class CountryService {
  static const String apiUrl = "https://restcountries.com/v3.1/all";
  
  Future<List<CountryModel>> fetchCountries({int page = 1, int limit = 20}) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      int startIndex = (page - 1) * limit;
      int endIndex = startIndex + limit;
      
      List<dynamic> paginatedData = data.sublist(
        startIndex,
        endIndex > data.length ? data.length : endIndex,
      );

      return paginatedData.map((json) => CountryModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load countries");
    }
  }
}
