import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/destination_model.dart';

class DestinationApiService {
  static const String baseUrl = 'https://countries.dev';

  Future<List<Destination>> fetchDestinations() async {
    final url = Uri.parse(
      '$baseUrl/countries?fields=name,alpha3Code,region,capital,flags,maps,population',
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            jsonDecode(response.body) as List<dynamic>;

        return jsonData
            .map((item) => Destination.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Gagal mengambil data. Kode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
