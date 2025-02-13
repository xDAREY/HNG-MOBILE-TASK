import 'package:country_info/screens/country_details.dart';
import 'package:country_info/services/country_api_service.dart';
import 'package:country_info/models/country_model.dart';
import 'package:country_info/widgets/filter_modal.dart';
import 'package:country_info/widgets/language_modal.dart';
import 'package:country_info/widgets/searchbar.dart';
import 'package:country_info/services/filtering_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CountryModel> countries = [];
  List<CountryModel> filteredCountries = [];
  bool isLoading = false;
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCountries();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_filterCountries);
  }

  Future<void> _fetchCountries() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      List<CountryModel> newCountries = await CountryService().fetchCountries(page: page);
      if (mounted) {
        setState(() {
          countries.addAll(newCountries);
          countries.sort((a, b) => a.name.compareTo(b.name));
          filteredCountries = List.from(countries);
          page++;
        });
      }
    } catch (e) {
      debugPrint("Error loading countries: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _filterCountries() {
    setState(() {
      filteredCountries = FilteringService.filterCountries(countries, _searchController.text);
    });
  }

  void _filterCountriesBySelection(List<String> selectedContinents, List<String> selectedTimeZones) {
    setState(() {
      filteredCountries = FilteringService.filterCountriesBySelection(countries, selectedContinents, selectedTimeZones);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !isLoading) {
      _fetchCountries();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _searchController.removeListener(_filterCountries);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Image.asset(
          isDarkMode ? 'assets/images/logo.png' : 'assets/images/ex_logo.png',
          height: 40, 
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: isDarkMode ? Colors.yellow : Colors.grey,
            ),
            onPressed: () {
              widget.onThemeToggle(!isDarkMode);
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SearchBarWidget(
                    controller: _searchController,
                    onSearch: (query) => _filterCountries(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => showLanguageModal(context),
                        child: _buildFilterButton(Icons.language, "EN", isDarkMode),
                      ),
                      GestureDetector(
                        onTap: () => showFilterModal(context, _filterCountriesBySelection),
                        child: _buildFilterButton(Icons.filter_list, "Filter", isDarkMode),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    countries.clear();
                    filteredCountries.clear();
                    page = 1;
                  });
                  await _fetchCountries();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: FilteringService.groupCountriesByLetter(filteredCountries).length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    var grouped = FilteringService.groupCountriesByLetter(filteredCountries);
                    if (index < grouped.keys.length) {
                      String letter = grouped.keys.elementAt(index);
                      List<CountryModel> sectionCountries = grouped[letter]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Text(
                              letter,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          ...sectionCountries.map((country) => ListTile(
                                leading: country.images.isNotEmpty
                                    ? Image.network(
                                        country.images[0],
                                        width: 40,
                                        height: 30,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.image_not_supported),
                                      )
                                    : const Icon(Icons.image_not_supported),
                                title: Text(
                                  country.name,
                                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                                ),
                                subtitle: Text(
                                  country.capital,
                                  style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetailsScreen(country: country),
                                    ),
                                  );
                                },
                              )),
                        ],
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(IconData icon, String label, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black54 : Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        ],
      ),
    );
  }

}
