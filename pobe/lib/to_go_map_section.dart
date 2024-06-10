// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pobe/location_service.dart';

class ToGoMaps extends StatefulWidget {
  final String apiUrl;
  const ToGoMaps({super.key, required this.apiUrl});

  @override
  State<ToGoMaps> createState() => _ToGoMapsState();
}

class _ToGoMapsState extends State<ToGoMaps> {
  late GoogleMapController mapController;
  LatLng _center = const LatLng(-6.300136, 106.639061);
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getCurrentLocation();
    _fetchLocations();
  }

  Position? _currentPosition;
  String _currentCity = 'Loading...';

  Future<void> _getCurrentLocation() async {
    try {
      LocationService locationService = LocationService();
      String city = await locationService.getCurrentCity();
      setState(() {
        _currentCity = city;
      });

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = position;
        _center = LatLng(position.latitude, position.longitude);
      });

      mapController.animateCamera(CameraUpdate.newLatLng(_center));
      print('Current center: $_center');
      print('Current position: $_currentPosition');
      print('Current city: $_currentCity');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _fetchLocations() async {
    try {
      final response = await http.get(Uri.parse(widget.apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> locations = json.decode(response.body);
        Set<Marker> markers = locations.map((location) {
          return Marker(
            markerId: MarkerId(location['name'].toString()),
            position: LatLng(location['latitude'], location['longitude']),
            infoWindow: InfoWindow(
              title: location['name'],
              snippet: location['description'],
            ),
          );
        }).toSet();

        setState(() {
          _markers = markers;
        });
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        myLocationEnabled: true,
        markers: _markers,
      ),
    );
  }
}
