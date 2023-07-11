import 'package:flutter/material.dart';

import '../../models/user_report.dart';

class ObservationFormField extends StatefulWidget {
  const ObservationFormField({super.key, required this.userReport});

  final UserReport userReport;
  static const List<String> observationList = <String>[
    'Jellyfish',
    'Humbolt Squid',
    'Whale'
  ];

  @override
  State<ObservationFormField> createState() => _ObservationFormFieldState();
}

class _ObservationFormFieldState extends State<ObservationFormField> {
  @override
  void initState() {
    super.initState();
    widget.userReport.observation = ObservationFormField.observationList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          value: widget.userReport.observation,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? value) {
            setState(() {
              widget.userReport.observation = value!;
            });
          },
          items: ObservationFormField.observationList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
