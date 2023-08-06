import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_change/widgets/view_report/view_screen_args.dart';

import '../../../models/user_report.dart';
import '../../../screens/view_report_screen.dart';

class BottomSheetCard extends StatelessWidget {
  final UserReport report;
  final bool adminStatus;
  const BottomSheetCard(
      {super.key, required this.report, required this.adminStatus});

  Widget? _populateSubtitle(UserReport report) {
    if (report.species != null) {
      return Text(report.species!);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        ViewReportScreen.routeName,
        arguments: ViewScreenArgs(report, adminStatus),
      ),
      title: Text(report.observation!),
      subtitle: _populateSubtitle(report),
      trailing: Text(DateFormat('MM-dd-yyyy | hh:mm a').format(report.date!)),
    ));
  }
}
