import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DirectionsPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  const DirectionsPage(
      {super.key, required this.latitude, required this.longitude});

  @override
  _DirectionsPageState createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _center = const LatLng(-6.300136, 106.639061);
  Set<Polyline> _polylines = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directions'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _getDirections();
        },
        myLocationEnabled: true,
        polylines: _polylines,
        markers: {
          Marker(
            markerId: const MarkerId('destination'),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: const InfoWindow(title: 'Destination'),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 15,
          )));
        },
        label: const Text('Navigate'),
        icon: const Icon(Icons.navigation),
      ),
    );
  }

  Future<void> _getDirections() async {
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_center.latitude},${_center.longitude}&destination=${widget.latitude},${widget.longitude}&key=AIzaSyBPCsnaVHxCg8M4qCCq1s1fCzVNzEDaRNk';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List<LatLng> polylineCoordinates = [];
      final List<dynamic> routes = decoded['routes'];
      routes.forEach((route) {
        final List<String> points =
            route['overview_polyline']['points'].toString().split(',');
        final decodedPoints = decodePoly(points);
        decodedPoints.forEach((point) {
          polylineCoordinates.add(LatLng(point[0], point[1]));
        });
      });

      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route1'),
          color: Colors.blue,
          width: 4,
          points: polylineCoordinates,
        ));
      });
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List decodePoly(List<String> encoded) {
    List poly = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded[index++].codeUnitAt(0) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded[index++].codeUnitAt(0) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1E5;
      double longitude = lng / 1E5;
      poly.add([latitude, longitude]);
    }
    return poly;
  }
}
