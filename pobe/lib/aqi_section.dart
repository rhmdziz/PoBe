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
  final String baseUrl = 'https://api.waqi.info/feed/A416785/';
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

class AqiSection extends StatefulWidget {
  const AqiSection({super.key});

  @override
  State<AqiSection> createState() => _AqiSectionState();
}

class _AqiSectionState extends State<AqiSection> {
  late Future<int> futureAQI;

  @override
  void initState() {
    super.initState();
    futureAQI = ApiService().fetchAQI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 99, 99, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: 150,
              height: 150,
              color: const Color.fromARGB(15, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/aqi/mask.png'),
                  const Text(
                    'Unhealthy',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: 170,
              decoration: const BoxDecoration(
                color: Color.fromARGB(120, 255, 155, 155),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<int>(
                    future: futureAQI,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 32,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      } else {
                        return const Text('No data');
                      }
                    },
                  ),
                  const Text(
                    'AQI',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
