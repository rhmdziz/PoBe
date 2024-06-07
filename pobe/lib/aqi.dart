import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AQIResponse {
  final String status;
  final int aqi;

  AQIResponse({
    required this.status,
    required this.aqi,
  });

  factory AQIResponse.fromJson(Map<String, dynamic> json) {
    return AQIResponse(
      status: json['status'],
      aqi: json['data']['aqi'],
    );
  }
}

class ApiService {
  final String baseUrl = 'https://api.waqi.info/feed/tangerang/';
  final String token = '9f59127ff5cd375ecfd300353d1e7e5bbf73ce2f';

  Future<int> fetchAQI() async {
    final response = await http.get(Uri.parse('$baseUrl?token=$token'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final aqiResponse = AQIResponse.fromJson(jsonResponse);
      return aqiResponse.aqi;
    } else {
      throw Exception('Failed to load AQI data');
    }
  }
}

class ApiSection extends StatefulWidget {
  const ApiSection({super.key});

  @override
  State<ApiSection> createState() => _ApiSectionState();
}

class _ApiSectionState extends State<ApiSection> {
  late Future<int> futureAQI;

  @override
  void initState() {
    super.initState();
    futureAQI = ApiService().fetchAQI();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<int>(
        future: futureAQI,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 99, 99, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    color: Colors.black12,
                  ),
                  Container(
                    color: Colors.black26,
                    width: 200,
                    height: 100,
                    child: Text('AQI: ${snapshot.data}'),
                  ),
                ],
              ),
            );
          } else {
            return Text('No data');
          }
        },
      ),
    );
  }
}
