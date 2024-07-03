// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pobe/login.dart';

class ApiService {
  final String baseUrl = 'https://rhmdziz.pythonanywhere.com/';
  // final String baseUrl = 'http://192.168.50.64:8000/';
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

    TokenStorage tokenStorage = TokenStorage();
    String? accessToken = await tokenStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
