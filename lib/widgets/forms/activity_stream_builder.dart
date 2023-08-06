import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_report.dart';
import '../../models/activity.dart';

import 'activity_form_field.dart';

class ActivityStreamBuilder extends StatelessWidget {
  const ActivityStreamBuilder({super.key, required this.userReport});

  final UserReport userReport;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('activities')
            .orderBy('name')
            .snapshots(),
        builder: (context, snapshot) {
          List<Activity> activityList = [];

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            for (final docSnapshot in snapshot.data!.docs) {
              Activity activity = Activity.fromFirestore(docSnapshot.data());
              activityList.add(activity);
            }

            return (ActivityFormField(
                userReport: userReport, activityList: activityList));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Text('Error: Missing form data.');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
