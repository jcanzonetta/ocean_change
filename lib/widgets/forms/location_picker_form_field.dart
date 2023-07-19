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

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, LocationPickerScreen.routeName);
      },
      child: const Icon(Icons.location_on_outlined),
    );
  }
}
