import 'package:flutter/material.dart';
import '../screens/view_report_screen.dart';

class ReportIcon extends StatelessWidget {
  const ReportIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, ViewReportScreen.routeName), 
            child: const Text("Mock Report"));
  }
}