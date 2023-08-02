import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';
import 'package:ocean_change/styles.dart';
import 'package:ocean_change/widgets/login/sign_out_button.dart';
import 'package:ocean_change/widgets/view_report/view_report_data.dart';

class ViewReportScreen extends StatelessWidget {
  static const String routeName = 'ViewReportScreen';

  const ViewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userReport = ModalRoute.of(context)!.settings.arguments as UserReport;

    return Scaffold(
      appBar: AppBar(
          title: Text('${userReport.observation} Report',
              style: const TextStyle(fontSize: 22)),
              actions: const [SignOutButton()],),
      body: ViewReportData(userReport: userReport)
    );
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
              const Text('Water Temperature:', style: Styles.viewScreenSmallLabels),
              Text(' $waterTempReported°F', style: Styles.viewScreenSmallData),
            ],
          ),
        );
    }
  }
}
