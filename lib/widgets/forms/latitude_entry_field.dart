import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/user_report.dart';

class LatitudeEntryField extends StatelessWidget {
  const LatitudeEntryField({
    super.key,
    required TextEditingController latController,
    required this.userReport,
    required this.updatePositionTarget,
  }) : _latController = latController;

  final TextEditingController _latController;
  final UserReport userReport;
  final Function updatePositionTarget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _latController,
          decoration: const InputDecoration(
              labelText: 'Latitude:', border: OutlineInputBorder()),
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: false),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
          ],
          onChanged: (newValue) {
            if (newValue.isEmpty ||
                !(num.parse(newValue) >= -90 && num.parse(newValue) <= 90)) {
              _latController.text = userReport.geopoint!.latitude.toString();
              return;
            }

            userReport.geopoint = GeoPoint(double.parse(_latController.text),
                userReport.geopoint!.longitude);

            updatePositionTarget();
          },
        ),
      ),
    );
  }
}
