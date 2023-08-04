import 'package:flutter/material.dart';
import 'package:ocean_change/models/observation.dart';
import 'package:ocean_change/widgets/forms/species_form_field.dart';

import '../../models/user_report.dart';

class ObservationFormField extends StatefulWidget {
  const ObservationFormField(
      {super.key, required this.userReport, required this.observationList});

  final UserReport userReport;
  final List<Observation> observationList;

  @override
  State<ObservationFormField> createState() => _ObservationFormFieldState();
}

class _ObservationFormFieldState extends State<ObservationFormField> {
  late Observation chosenObservation;

  @override
  void initState() {
    super.initState();
    chosenObservation = widget.observationList.first;
    widget.userReport.observation = widget.observationList.first.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('What did you see?'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: widget.userReport.observation,
                icon: const Icon(Icons.arrow_downward),
                onChanged: (String? value) {
                  setState(() {
                    widget.userReport.observation = value!;

                    chosenObservation = widget.observationList.firstWhere(
                        (element) =>
                            element.name == widget.userReport.observation);
                  });
                },
                items: widget.observationList
                    .map<DropdownMenuItem<String>>((Observation observation) {
                  return DropdownMenuItem<String>(
                    value: observation.name,
                    child: Text(observation.name),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Details: '),
            SpeciesFormField(
                userReport: widget.userReport,
                chosenObservation: chosenObservation),
          ],
        )
      ],
    );
  }
}
