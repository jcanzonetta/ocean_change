import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../components/get_current_location.dart';

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
    Position locationData = await getCurrentLocation();

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

  Widget _locationTextField(FormFieldState formFieldState) {
    if (formFieldState.hasError) {
      return Text(
        formFieldState.errorText!,
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return _showGeopoint();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return 'Please select a coordinate.';
        } else {
          return null;
        }
      },
      builder: (formFieldState) {
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
                    formFieldState.didChange(widget.userReport.geopoint);
                  },
                  child: const Icon(Icons.location_on_outlined),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                OutlinedButton(
                    onPressed: () {
                      formFieldState.didChange(null);

                      widget.userReport.geopoint = null;
                    },
                    child: const Icon(Icons.clear)),
              ],
            ),
            _locationTextField(formFieldState),
          ],
        );
      },
    );
  }
}
