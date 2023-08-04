import 'package:flutter/material.dart';
import 'package:ocean_change/models/observation.dart';

import '../../models/user_report.dart';

class SpeciesFormField extends StatefulWidget {
  const SpeciesFormField(
      {super.key, required this.userReport, required this.chosenObservation});

  final UserReport userReport;
  final Observation chosenObservation;

  @override
  State<SpeciesFormField> createState() => _SpeciesFormFieldState();
}

class _SpeciesFormFieldState extends State<SpeciesFormField> {
  @override
  void initState() {
    super.initState();

    if (widget.chosenObservation.species != null &&
        widget.chosenObservation.species!.isNotEmpty) {
      widget.userReport.species =
          widget.chosenObservation.species!.first['name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chosenObservation.species != null &&
        widget.chosenObservation.species!.isNotEmpty) {
      if (!widget.chosenObservation.species!
          .map((element) => element['name'])
          .contains(widget.userReport.species)) {
        widget.userReport.species =
            widget.chosenObservation.species!.first['name'];
      }
    } else {
      widget.userReport.species = null;
    }
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          disabledHint: const Text('None'),
          value: widget.userReport.species,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? value) {
            setState(() {
              widget.userReport.species = value!;
            });
          },
          items: widget.chosenObservation.species!
              .map<DropdownMenuItem<String>>((Map singleSpecies) {
            return DropdownMenuItem<String>(
              value: singleSpecies['name'],
              child: Text(singleSpecies['name']),
            );
          }).toList(),
        ));
  }
}
