import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';
import 'package:ocean_change/styles.dart';

class ViewReportScreen extends StatelessWidget {
  static const String routeName = 'ViewReportScreen';

  const ViewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userReport = ModalRoute.of(context)!.settings.arguments as UserReport;

    return Scaffold(
      appBar: AppBar(
          title: Text('${userReport.observation} Report',
              style: const TextStyle(fontSize: 22))),
      body: Column(children: [
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
        )
      ]),
    );
  }

  Widget loadImage(imageUrl) {
    if (imageUrl == null) {
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
              const Text('Water Temperature:', style: Styles.viewScreenSmallLabels),
              Text(' $waterTempReported°F', style: Styles.viewScreenSmallData),
            ],
          ),
        );
    }
  }
}
