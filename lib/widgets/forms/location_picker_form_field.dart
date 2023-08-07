import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

import '../../screens/location_picker_screen.dart';

import '../../models/user_report.dart';

class LocationPickerFormField extends StatefulWidget {
  final UserReport userReport;

  const LocationPickerFormField({super.key, required this.userReport});

  @override
  State<LocationPickerFormField> createState() =>
      _LocationPickerFormFieldState();
}

class _LocationPickerFormFieldState extends State<LocationPickerFormField> {
  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() async {
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

    var locationData = await Geolocator.getCurrentPosition();
    debugPrint('${locationData.latitude}, ${locationData.longitude}');
    setState(() {
      widget.userReport.geopoint =
          GeoPoint(locationData.latitude, locationData.longitude);
    });
  }

  Widget _showGeopoint() {
    if (widget.userReport.geopoint != null) {
      return Text(
          '( ${double.parse(widget.userReport.geopoint!.latitude.toStringAsFixed(2))}, ${double.parse(widget.userReport.geopoint!.longitude.toStringAsFixed(4))})');
    } else {
      return const Text('No location selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            OutlinedButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, LocationPickerScreen.routeName,
                    arguments: widget.userReport);
                setState(() {});
              },
              child: const Icon(Icons.location_on_outlined),
            ),
            const SizedBox(
              width: 8.0,
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    widget.userReport.geopoint = null;
                  });
                },
                child: const Icon(Icons.clear)),
          ],
        ),
        _showGeopoint(),
      ],
    );
  }
}
