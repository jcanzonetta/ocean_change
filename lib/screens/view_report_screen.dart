import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';

class ViewReportScreen extends StatelessWidget {
  static const String routeName = 'ViewReportScreen';

  const ViewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userReport = ModalRoute.of(context)!.settings.arguments as UserReport;

    return Scaffold(
      appBar: AppBar(
          title: Text(userReport.observation ?? '',
              style: const TextStyle(fontSize: 16))),
      body: Column(children: [
        Center(child: Text('Date and Time: ${userReport.date}')),
        Center(child: Text('Observation: ${userReport.observation}')),
        Center(child: Text('Number Observed: ${userReport.observationNumber}')),
        Center(child: Text('Water Temperature: ${userReport.waterTemp}')),
        Center(child: Text('Location: ${userReport.geopoint?.latitude}, ${userReport.geopoint?.longitude}'))
      ]),
    );
  }
}
