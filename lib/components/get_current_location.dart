import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permissionGranted;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // Check if service is enabled.
  if (!serviceEnabled) {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
  }

  // Check if presmission is granted.
  permissionGranted = await Geolocator.checkPermission();
  if (permissionGranted == LocationPermission.denied) {
    permissionGranted = await Geolocator.requestPermission();
    if (permissionGranted == LocationPermission.denied) {
      return Future.error('Location permissions are denied.');
    }
  }

  Position locationData = await Geolocator.getCurrentPosition();
  return locationData;
}

StatelessWidget addCurrentLocationMarker(currentLocation) {
  if (currentLocation != null) {
    return MarkerLayer(
      markers: [
        Marker(
            point:
                LatLng(currentLocation!.latitude, currentLocation!.longitude),
            builder: (_) => const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ))
      ],
    );
  } else {
    return (Container());
  }
}
