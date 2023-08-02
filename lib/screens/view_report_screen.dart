import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';
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

}
