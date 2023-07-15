import 'package:flutter/material.dart';
import '../widgets/map/base_map.dart';

import 'create_report_screen.dart';

class MapScreen extends StatelessWidget {
  static const String routeName = '/';

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ocean Change')),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          BaseMap(),
        ],),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, CreateReportScreen.routeName);
          }),
    );
  }
}
