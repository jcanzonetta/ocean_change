import 'package:flutter/material.dart';

import '../../models/user_report.dart';

class TemperatureBreakFormField extends StatefulWidget {
  const TemperatureBreakFormField({super.key, required this.userReport});

  final UserReport userReport;

  @override
  State<TemperatureBreakFormField> createState() =>
      _TemperatureBreakFormFieldState();
}

class _TemperatureBreakFormFieldState extends State<TemperatureBreakFormField> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Were you on a temperature/transition break?'),
        Checkbox(
            value: _isSelected,
            onChanged: (bool? value) {
              setState(() {
                _isSelected = value!;
              });
              widget.userReport.temperatureBreak = _isSelected;
            }),
      ],
    );
  }
}
