import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/map/base_map.dart';
import '../widgets/map/bottom_sheet/bottom_list_sheet.dart';
import '../widgets/map/csv_export_button.dart';
import 'create_report_screen.dart';
import 'package:ocean_change/widgets/map/report_marker_icon.dart';
import 'package:ocean_change/widgets/map/report_marker.dart';
import 'package:ocean_change/models/user_report.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Stream userReportsStream = FirebaseFirestore.instance
      .collection('reports')
      .snapshots()
      .asBroadcastStream();

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
          StreamBuilder(
              stream: userReportsStream,
              builder: (content, snapshot) {
                List<ReportMarker> reportMarkers = [];
                if (snapshot.hasData) {
                  for (final docSnapshot in snapshot.data!.docs) {
                    final report = UserReport.fromFirestore(docSnapshot.data());
                    reportMarkers.add(ReportMarker(
                        userReport: report,
                        builder: (context) =>
                            ReportMarkerIcon(observation: report.observation)));
                  }
                  return BaseMap(reportMarkers: reportMarkers);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          BottomListSheet(userReportStream: userReportsStream),
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
