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
    return TextFormField(
        decoration:
            const InputDecoration(label: Text('Water Temperature (°F)')),
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
        });
  }
}
