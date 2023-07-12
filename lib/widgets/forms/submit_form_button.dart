import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';

class SubmitFormButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UserReport userReport;

  const SubmitFormButton(
      {super.key, required this.formKey, required this.userReport});

  @override
  State<SubmitFormButton> createState() => _SubmitFormButton();
}

class _SubmitFormButton extends State<SubmitFormButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (widget.formKey.currentState?.validate() ?? true) {
            widget.formKey.currentState!.save();

            FirebaseFirestore.instance.collection('reports').add({
              'observation': widget.userReport.observation,
              'observation_number': widget.userReport.observationNumber,
              'water_temp': widget.userReport.waterTemp,
              'date': widget.userReport.date
            });

            Navigator.of(context).pop();
          }
        },
        icon: const Icon(Icons.cloud_circle),
        label: const Text('Submit'),
      ),
    );
  }
}
