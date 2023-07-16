import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_change/widgets/forms/species_form_field.dart';

import '../../models/observation.dart';
import '../../models/user_report.dart';
import 'observation_form_field.dart';

class ObservationStreamBuilder extends StatelessWidget {
  const ObservationStreamBuilder({
    super.key,
    required this.userReport,
  });

  final UserReport userReport;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('possible-observations')
            .orderBy('name')
            .snapshots(),
        builder: (context, snapshot) {
          List<Observation> observationList = [];

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            for (final docSnapshot in snapshot.data!.docs) {
              Observation observation =
                  Observation.fromFirestore(docSnapshot.data());
              observationList.add(observation);
            }
            return ObservationFormField(
                userReport: userReport, observationList: observationList);
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Text('Error: Missing form data.');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
