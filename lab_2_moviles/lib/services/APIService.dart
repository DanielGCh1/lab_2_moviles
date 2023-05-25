import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static const String apiKey = 'JkyeRyS_33Ay_uowyzJqLjsi7M9NGnuykzB6eC8APmk';
  static const String baseUrl = 'https://api.unsplash.com';
  static const String path = '/search/photos';
  static const int perPage = 20;

  static Future<List<String>> fetchImages(
      String selectedCategory, int page) async {
    final String query = selectedCategory.toLowerCase();
    final String url =
        '$baseUrl$path?page=$page&per_page=$perPage&query=$query&client_id=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];
        return results
            .map<String>((item) => item['urls']['regular'] as String)
            .toList();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }
}
