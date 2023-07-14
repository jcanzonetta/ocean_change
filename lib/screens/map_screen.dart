import 'package:flutter/material.dart';
import '../widgets/report_icon.dart';

import 'create_report_screen.dart';

class MapScreen extends StatelessWidget {
  static const String routeName = '/';

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ocean Change')),
      // container in body is map placeholder
      body: Container(
              color: const Color.fromARGB(255, 163, 213, 236),
              alignment: Alignment.center,
              child: const ReportIcon()),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, CreateReportScreen.routeName);
          }),
    );
  }
}
