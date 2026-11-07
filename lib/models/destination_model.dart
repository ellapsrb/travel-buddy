class Destination {
  final String id;
  final String name;
  final String region;
  final String capital;
  final String flagUrl;
  final String mapsUrl;
  final int population;

  Destination({
    required this.id,
    required this.name,
    required this.region,
    required this.capital,
    required this.flagUrl,
    required this.mapsUrl,
    required this.population,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'];
    final flagsData = json['flags'];
    final mapsData = json['maps'];
    final capitalData = json['capital'];

    String countryName = 'Unknown';

    if (nameData is String) {
      countryName = nameData;
    } else if (nameData is Map) {
      countryName = nameData['common']?.toString() ?? 'Unknown';
    }

    String capitalName = 'Tidak diketahui';

    if (capitalData is String) {
      capitalName = capitalData;
    } else if (capitalData is List && capitalData.isNotEmpty) {
      capitalName = capitalData.first.toString();
    }

    String flag = '';

    if (flagsData is Map) {
      flag = flagsData['png']?.toString() ?? flagsData['svg']?.toString() ?? '';
    }

    String mapLink = '';

    if (mapsData is Map) {
      mapLink = mapsData['googleMaps']?.toString() ?? '';
    }

    return Destination(
      id: json['alpha3Code']?.toString() ?? json['cca3']?.toString() ?? '',
      name: countryName,
      region: json['region']?.toString() ?? 'Unknown',
      capital: capitalName,
      flagUrl: flag,
      mapsUrl: mapLink,
      population: (json['population'] as num?)?.toInt() ?? 0,
    );
  }
}
