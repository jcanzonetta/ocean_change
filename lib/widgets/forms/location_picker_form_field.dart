import 'package:flutter/material.dart';

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
  }

  Widget _showGeopoint() {
    if (widget.userReport.geopoint != null) {
      return Text(
          '( ${double.parse(widget.userReport.geopoint!.latitude.toStringAsFixed(2))}, ${double.parse(widget.userReport.geopoint!.longitude.toStringAsFixed(2))})');
    } else {
      return const Text('No location selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, LocationPickerScreen.routeName,
                arguments: widget.userReport);
            setState(() {});
          },
          child: const Icon(Icons.location_on_outlined),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _showGeopoint(),
        ),
        OutlinedButton(
            onPressed: () {
              setState(() {
                widget.userReport.geopoint = null;
              });
            },
            child: const Icon(Icons.clear)),
      ],
    );
  }
}
