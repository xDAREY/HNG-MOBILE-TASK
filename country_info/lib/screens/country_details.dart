import 'package:flutter/material.dart';
import 'package:country_info/models/country_model.dart';
import 'package:country_info/widgets/formatter.dart'; 

class CountryDetailsScreen extends StatefulWidget {
  final CountryModel country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentIndex < widget.country.images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.country.images.isNotEmpty) ...[
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: widget.country.images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.country.images[index],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        Positioned(
                          left: 10,
                          top: 75,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios, size: 20),
                              color: Colors.white,
                              onPressed: _previousImage,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 75,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, size: 20),
                              color: Colors.white,
                              onPressed: _nextImage,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.country.images.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentIndex == index ? 10 : 8,
                                height: _currentIndex == index ? 10 : 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentIndex == index
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                _buildInfoRow("Population: ", Formatter.formatNumber(widget.country.population)),
                _buildInfoRow("Region: ", widget.country.region),
                _buildInfoRow("Capital: ", widget.country.capital),
                _buildInfoRow("Motto: ", widget.country.motto),
                const SizedBox(height: 20),
                _buildInfoRow("Official Language: ", widget.country.officialLanguage),
                _buildInfoRow("Ethnic Group: ", widget.country.ethnicGroup),
                _buildInfoRow("Religion: ", widget.country.religion),
                _buildInfoRow("Government: ", widget.country.government),
                const SizedBox(height: 20),
                _buildInfoRow("Independence: ", widget.country.isIndependent ? "Yes" : "No"),
                _buildInfoRow("Area: ", "${Formatter.formatNumber(widget.country.area)} km²"),
                _buildInfoRow("Currency: ", widget.country.currency),
                _buildInfoRow("GDP: ", Formatter.formatNumber(widget.country.gdp)),
                const SizedBox(height: 20),
                _buildInfoRow("Time Zone: ", widget.country.timeZone),
                _buildInfoRow("Date Format: ", widget.country.dateFormat),
                _buildInfoRow("Dialing Code: ", widget.country.dialCode),
                _buildInfoRow("Driving Side: ", widget.country.drivingSide),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}