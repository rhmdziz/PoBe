// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.10.162.101:8000/';
  final Map<String, String> endpoints = {
    'Food': 'foods/',
    'Entertain': 'entertains/',
    'Sport': 'sports/',
    'Hospital': 'hospitals/',
    'Mall': 'malls/',
    'Shopping': 'shoppings/',
  };

  Future<List<dynamic>> fetchCategoryData(String category) async {
    final endpoint = endpoints[category];
    if (endpoint == null) {
      throw Exception('Invalid category');
    }

    final url = '$baseUrl$endpoint';
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
