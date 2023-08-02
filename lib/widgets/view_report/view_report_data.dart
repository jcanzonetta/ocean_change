import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';
import 'package:ocean_change/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewReportData extends StatelessWidget {
  final UserReport userReport;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  ViewReportData({super.key, required this.userReport});

  @override
  Widget build(BuildContext context) {
    print(currentUser?.email);
    print(userReport.user);
    if (currentUser?.email == userReport.user) {
      return Column(children: [
        Center(child: loadImage(userReport.photoURL)),
        Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              children: [
                const Text('Observation:',
                    style: Styles.viewScreenObservationLabels),
                Text(
                  ' ${userReport.observation}',
                  style: Styles.viewScreenObservationData,
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Number Observed:',
                  style: Styles.viewScreenMediumLabels),
              Text(' ${userReport.observationNumber}',
                  style: Styles.viewScreenMediumData),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Date: ', style: Styles.viewScreenMediumLabels),
              Text(
                  '${userReport.date!.month}/${userReport.date!.day}/${userReport.date!.year}',
                  style: Styles.viewScreenMediumData),
              const Expanded(
                  child: Text(' Time:',
                      style: Styles.viewScreenMediumLabels,
                      textAlign: TextAlign.right)),
              Text(' ${userReport.date.toString().substring(11, 19)}',
                  style: Styles.viewScreenMediumData,
                  textAlign: TextAlign.right)
            ],
          ),
        ),
        loadWaterTemp(userReport.waterTemp),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Location:', style: Styles.viewScreenSmallLabels),
              Text(
                ' ${userReport.geopoint?.latitude.toString().substring(0, 8)}° N, ${userReport.geopoint?.longitude.toString().substring(0, 10)}° W',
                style: Styles.viewScreenSmallData,
              ),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () => deleteReport(context, userReport),
            child: const Text("Delete"))
      ]);
    } else {
      return Column(children: [
        Center(child: loadImage(userReport.photoURL)),
        Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              children: [
                const Text('Observation:',
                    style: Styles.viewScreenObservationLabels),
                Text(
                  ' ${userReport.observation}',
                  style: Styles.viewScreenObservationData,
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Number Observed:',
                  style: Styles.viewScreenMediumLabels),
              Text(' ${userReport.observationNumber}',
                  style: Styles.viewScreenMediumData),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Date: ', style: Styles.viewScreenMediumLabels),
              Text(
                  '${userReport.date!.month}/${userReport.date!.day}/${userReport.date!.year}',
                  style: Styles.viewScreenMediumData),
              const Expanded(
                  child: Text(' Time:',
                      style: Styles.viewScreenMediumLabels,
                      textAlign: TextAlign.right)),
              Text(' ${userReport.date.toString().substring(11, 19)}',
                  style: Styles.viewScreenMediumData,
                  textAlign: TextAlign.right)
            ],
          ),
        ),
        loadWaterTemp(userReport.waterTemp),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Location:', style: Styles.viewScreenSmallLabels),
              Text(
                ' ${userReport.geopoint?.latitude.toString().substring(0, 8)}° N, ${userReport.geopoint?.longitude.toString().substring(0, 10)}° W',
                style: Styles.viewScreenSmallData,
              ),
            ],
          ),
        ),
      ]);
    }
  }

  Widget loadImage(imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container();
    } else {
      return Image.network(imageUrl);
    }
  }

  Widget loadWaterTemp(waterTempReported) {
    if (waterTempReported == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        child: Row(
          children: [
            const Text('Water Temperature:',
                style: Styles.viewScreenSmallLabels),
            Text(' $waterTempReported°F', style: Styles.viewScreenSmallData),
          ],
        ),
      );
    }
  }

  void deleteReport(BuildContext context, UserReport userReport) {
    FirebaseFirestore.instance.collection("reports").doc(userReport.id).delete();
    Navigator.pop(context);
  }
}
