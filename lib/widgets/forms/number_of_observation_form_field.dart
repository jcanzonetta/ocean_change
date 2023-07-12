import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_change/models/user_report.dart';

class NumberOfObservationFormField extends StatefulWidget {
  const NumberOfObservationFormField({super.key, required this.userReport});

  final UserReport userReport;

  @override
  State<NumberOfObservationFormField> createState() =>
      _NumberOfObservationFormFieldState();
}

class _NumberOfObservationFormFieldState
    extends State<NumberOfObservationFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(48.0, 8.0, 48.0, 8.0),
      child: TextFormField(
          decoration:
              const InputDecoration(label: Text('How many did you see?')),
          keyboardType: const TextInputType.numberWithOptions(signed: false),
          maxLength: 1000,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter a non-zero number';
            } else if (int.parse(value!) <= 0) {
              return 'Please enter a positive number';
            } else {
              return null;
            }
          },
          onSaved: (newValue) {
            if (newValue?.isEmpty ?? true) {
              widget.userReport.observationNumber = null;
            } else {
              widget.userReport.observationNumber = int.parse(newValue!);
            }
          }),
    );
  }
}
