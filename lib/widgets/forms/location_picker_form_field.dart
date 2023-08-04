import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

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
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();

    // Check if service is enabled.
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    // Check if presmission is granted.
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    var locationData = await location.getLocation();
    widget.userReport.geopoint =
        GeoPoint(locationData.latitude!, locationData.longitude!);

    setState(() {});
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
