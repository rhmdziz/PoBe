// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final Map<String, String> categoryUrls = {
    'Food': 'http://192.168.50.61:8000/foods/',
    'Entertain': 'http://192.168.50.61:8000/entertains/',
    'Sport': 'http://192.168.50.61:8000/sports/',
    'Hospital': 'http://192.168.50.61:8000/hospitals/',
    'Mall': 'http://192.168.50.61:8000/malls/',
    'Shopping': 'http://192.168.50.61:8000/shoppings/',
  };

  Future<List<dynamic>> fetchCategoryData(String category) async {
    final url = categoryUrls[category];
    if (url == null) {
      throw Exception('Invalid category');
    }

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
