import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Google_Map extends StatelessWidget {
  double lat;
  double long;
  Google_Map({required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;

    final LatLng _center = LatLng(lat, long);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        elevation: 2,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
