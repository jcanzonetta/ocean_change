import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_change/widgets/login/sign_out_button.dart';
import 'package:ocean_change/widgets/view_report/view_report_data.dart';
import 'package:ocean_change/widgets/view_report/view_screen_args.dart';

class ViewReportScreen extends StatelessWidget {
  static const String routeName = 'ViewReportScreen';

  const ViewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ViewScreenArgs;

    return Scaffold(
      appBar: AppBar(
          title: Text('${args.userReport.observation} Report',
              style: const TextStyle(fontSize: 22)),
              actions: const [SignOutButton()],),
      body: ViewReportData(viewScreenArgs: args)
    );
  }

}
