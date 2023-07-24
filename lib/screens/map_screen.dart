import 'package:flutter/material.dart';

import '../widgets/map/base_map.dart';
import '../widgets/map/csv_export_button.dart';
import 'create_report_screen.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late bool markersReady;

  @override
  void initState() {
    super.initState();
    markersReady = false;
  }

  void toggleMarkersReady() {
    markersReady = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ocean Change'),
        actions: const [
          CSVExportButton(),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ignore: prefer_const_constructors
          BaseMap(), //Ignore 'const' tip from IDE, it prevents marker refresh
          Positioned(
              top: 20,
              left: 20,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() => markersReady = false);
                  },
                  child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.refresh))))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, CreateReportScreen.routeName);
          }),
    );
  }
}
