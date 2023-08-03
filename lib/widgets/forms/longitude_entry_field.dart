import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/user_report.dart';

class LongitudeEntryField extends StatelessWidget {
  const LongitudeEntryField({
    super.key,
    required TextEditingController longController,
    required this.userReport,
    required this.updatePositionTarget,
  }) : _longController = longController;

  final TextEditingController _longController;
  final UserReport userReport;
  final Function updatePositionTarget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _longController,
          decoration: const InputDecoration(
              labelText: 'Longitude:', border: OutlineInputBorder()),
          keyboardType: const TextInputType.numberWithOptions(
              decimal: true, signed: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[-]\d+\.?\d*'))
          ],
          onChanged: (newValue) {
            if (newValue.isEmpty ||
                !(num.parse(newValue) >= -180 && num.parse(newValue) <= 180)) {
              _longController.text = userReport.geopoint!.longitude.toString();
              return;
            }

            userReport.geopoint = GeoPoint(userReport.geopoint!.latitude,
                double.parse(_longController.text));

            updatePositionTarget();
          },
        ),
      ),
    );
  }
}
