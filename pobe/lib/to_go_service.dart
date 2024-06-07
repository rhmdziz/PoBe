
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final Map<String, String> categoryUrls = {
    'Food': 'http://10.10.161.232:8000/foods/',
    'Entertain': 'http://10.10.161.232:8000/entertains/',
    'Sport': 'http://10.10.161.232:8000/sports/',
    'Hospital': 'http://10.10.161.232:8000/hospitals/',
    'Mall': 'http://10.10.161.232:8000/malls/',
    'Shopping': 'http://10.10.161.232:8000/shoppings/',
  };

  Future<List<dynamic>> fetchCategoryData(String category) async {
    final url = categoryUrls[category];
    if (url == null) {
      throw Exception('Invalid category');
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
