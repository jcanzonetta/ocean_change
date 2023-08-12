import 'package:geolocator/geolocator.dart';

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
