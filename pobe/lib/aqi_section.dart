// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AQIResponse {
  final String status;
  final int aqi;
  final String time;

  AQIResponse({
    required this.status,
    required this.aqi,
    required this.time,
  });

  factory AQIResponse.fromJson(Map<String, dynamic> json) {
    return AQIResponse(
      status: json['status'],
      aqi: json['data']['aqi'],
      time: json['data']['time']['s'],
    );
  }
}

class ApiService {
  // final String baseUrl = 'https://api.waqi.info/feed/here/';
  final String baseUrl = 'https://api.waqi.info/feed/A416785/';
  final String token = '9f59127ff5cd375ecfd300353d1e7e5bbf73ce2f';

  Future<AQIResponse> fetchAQI() async {
    final response = await http.get(Uri.parse('$baseUrl?token=$token'));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final aqiResponse = AQIResponse.fromJson(jsonResponse);
      return aqiResponse;
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
  late Future<AQIResponse> futureAQI;

  @override
  void initState() {
    super.initState();
    futureAQI = ApiService().fetchAQI();
  }

  Color _getColorForAQI(int aqi) {
    if (aqi <= 50) {
      return Colors.green;
    } else if (aqi <= 100) {
      return Colors.yellow;
    } else if (aqi <= 150) {
      return Colors.orange;
    } else if (aqi <= 200) {
      return const Color.fromRGBO(255, 99, 99, 1);
    } else if (aqi <= 300) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }

  String _getStatusForAQI(int aqi) {
    if (aqi <= 50) {
      return 'Good';
    } else if (aqi <= 100) {
      return 'Moderate';
    } else if (aqi <= 150) {
      return 'Unhealthy for Sensitive Groups';
    } else if (aqi <= 200) {
      return 'Unhealthy';
    } else if (aqi <= 300) {
      return 'Very Unhealthy';
    } else {
      return 'Hazardous';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AQIResponse>(
      future: futureAQI,
      builder: (context, snapshot) {
        Color containerColor = Colors.grey;
        String status = 'Loading...';
        String time = '';
        int? aqi;

        if (snapshot.hasData) {
          containerColor = _getColorForAQI(snapshot.data!.aqi);
          status = _getStatusForAQI(snapshot.data!.aqi);
          time = snapshot.data!.time;
          aqi = snapshot.data!.aqi;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          Text(
                            status,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            const CircularProgressIndicator()
                          else if (snapshot.hasError)
                            Text('Error: ${snapshot.error}')
                          else if (snapshot.hasData)
                            Text(
                              '$aqi',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 46,
                                // fontFamily: 'Lexend',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          else
                            const Text('No data'),
                          const Text(
                            'AQI',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              // fontFamily: 'Lexend',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Last update: $time',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      },
    );
  }
}
