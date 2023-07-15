import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('What did you see?'),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('possible-observations')
                .orderBy('name')
                .snapshots(),
            builder: (context, snapshot) {
              List<String> observationList = [];

              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                for (final docSnapshot in snapshot.data!.docs) {
                  Observation observation =
                      Observation.fromFirestore(docSnapshot.data());
                  observationList.add(observation.name);
                }
                return ObservationFormField(
                    userReport: userReport, observationList: observationList);
              } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                return const Text('Error: Missing form data.');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
