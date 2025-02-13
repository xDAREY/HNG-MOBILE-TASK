class CountryModel {
  final String name;
  final List<String> images;
  final String population;
  final String capital;
  final String region;
  final String motto;
  final String officialLanguage;
  final String ethnicGroup;
  final String religion;
  final String government;
  final bool isIndependent;
  final String area;
  final String currency;
  final String gdp;
  final String timeZone;
  final String dateFormat;
  final String dialCode;
  final String drivingSide;

  CountryModel({
    required this.name,
    required this.images,
    required this.population,
    required this.capital,
    required this.region,
    required this.motto,
    required this.officialLanguage,
    required this.ethnicGroup,
    required this.religion,
    required this.government,
    required this.isIndependent,
    required this.area,
    required this.currency,
    required this.gdp,
    required this.timeZone,
    required this.dateFormat,
    required this.dialCode,
    required this.drivingSide,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'] ?? 'Unknown',
      images: [
        if (json['flags'] != null && json['flags']['png'] != null) json['flags']['png'],
        if (json['coatOfArms'] != null && json['coatOfArms']['png'] != null) json['coatOfArms']['png'],
      ],
      population: json['population']?.toString() ?? 'N/A',
      capital: (json['capital'] != null && json['capital'].isNotEmpty) ? json['capital'][0] : 'N/A',
      region: json['region'] ?? 'N/A',
      motto: json['motto'] ?? 'N/A',
      officialLanguage: json['languages'] != null ? json['languages'].values.first : 'N/A',
      ethnicGroup: json['ethnicGroup'] ?? 'N/A',
      religion: json['religion'] ?? 'N/A',
      government: json['government'] ?? 'N/A',
      isIndependent: (json['independent'] is bool) ? json['independent'] as bool : false,
      area: json['area']?.toString() ?? 'N/A',
      currency: json['currencies'] != null ? json['currencies'].values.first['name'] : 'N/A',
      gdp: json['gdp'] ?? 'N/A',
      timeZone: json['timezones'] != null ? json['timezones'][0] : 'N/A',
      dateFormat: json['dateFormat'] ?? 'dd/mm/yyyy',
      dialCode: json['idd'] != null ? json['idd']['root'] ?? '' : '',
      drivingSide: json['car'] != null ? json['car']['side'] ?? 'Right' : 'Right',
    );
  }

}