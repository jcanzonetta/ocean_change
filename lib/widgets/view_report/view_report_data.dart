import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';
import 'package:ocean_change/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_change/widgets/view_report/view_screen_args.dart';

class ViewReportData extends StatelessWidget {
  final ViewScreenArgs viewScreenArgs;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  ViewReportData({super.key, required this.viewScreenArgs});

  @override
  Widget build(BuildContext context) {
      return Column(children: [
        Center(child: loadImage(viewScreenArgs.userReport.photoURL)),
        Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              children: [
                const Text('Observation:',
                    style: Styles.viewScreenObservationLabels),
                Text(
                  ' ${viewScreenArgs.userReport.observation}',
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
              Text(' ${viewScreenArgs.userReport.observationNumber}',
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
                  '${viewScreenArgs.userReport.date!.month}/${viewScreenArgs.userReport.date!.day}/${viewScreenArgs.userReport.date!.year}',
                  style: Styles.viewScreenMediumData),
              const Expanded(
                  child: Text(' Time:',
                      style: Styles.viewScreenMediumLabels,
                      textAlign: TextAlign.right)),
              Text(' ${viewScreenArgs.userReport.date.toString().substring(11, 19)}',
                  style: Styles.viewScreenMediumData,
                  textAlign: TextAlign.right)
            ],
          ),
        ),
        loadWaterTemp(viewScreenArgs.userReport.waterTemp),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Row(
            children: [
              const Text('Location:', style: Styles.viewScreenSmallLabels),
              Text(
                ' ${viewScreenArgs.userReport.geopoint?.latitude.toString().substring(0, 8)}° N, ${viewScreenArgs.userReport.geopoint?.longitude.toString().substring(0, 10)}° W',
                style: Styles.viewScreenSmallData,
              ),
            ],
          ),
        ),
        deleteReportButton(context, currentUser, viewScreenArgs.userReport, viewScreenArgs.adminStatus)
    ]);
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

  Widget deleteReportButton(
      BuildContext context, User? currentUser, 
      UserReport userReport, bool adminStatus) {
    if (currentUser?.email == userReport.user || adminStatus == true) {
      return ElevatedButton(
          onPressed: () => deleteReport(context, userReport),
          child: const Text("Delete"));
    } else {
      return Container();
    }
  }

  void deleteReport(BuildContext context, UserReport userReport) {
    FirebaseFirestore.instance
        .collection("reports")
        .doc(userReport.id)
        .delete();
    Navigator.pop(context);
  }
}
