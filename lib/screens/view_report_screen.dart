import 'package:flutter/material.dart';

class ViewReportScreen extends StatelessWidget {
  static const String routeName = 'ViewReportScreen';

  const ViewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Observation - Date & Time (From firestore)', 
            style: TextStyle(fontSize: 16))),
      body: const Placeholder(),
    );
  }
}
