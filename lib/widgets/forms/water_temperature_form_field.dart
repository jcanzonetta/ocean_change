import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_change/models/user_report.dart';

class WaterTemperatureFormField extends StatelessWidget {
  const WaterTemperatureFormField({
    super.key,
    required this.userReport,
  });

  final UserReport userReport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48.0, 8.0, 48.0, 8.0),
      child: TextFormField(
          decoration:
              const InputDecoration(labelText: 'Water Temperature (°F)'),
          keyboardType: const TextInputType.numberWithOptions(signed: false),
          maxLength: 5,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}'))
          ],
          onSaved: (newValue) {
            if (newValue?.isEmpty ?? true) {
              userReport.waterTemp = null;
            } else {
              userReport.waterTemp = int.parse(newValue!);
            }
          }),
    );
  }
}
