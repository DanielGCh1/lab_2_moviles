import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static Future<List<String>> fetchImages(
      String selectedCategory, int page) async {
    final String apiKey = 'JkyeRyS_33Ay_uowyzJqLjsi7M9NGnuykzB6eC8APmk';
    final String baseUrl = 'https://api.unsplash.com';
    final String path = '/search/photos';
    final int perPage = 20;
    final String query = selectedCategory.toLowerCase();
    final String url =
        '$baseUrl$path?page=$page&per_page=$perPage&query=$query&client_id=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];
        List<String> newImages = [];
        for (var item in results) {
          newImages.add(item['urls']['regular']);
        }
        return newImages;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }
}
