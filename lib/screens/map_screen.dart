import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create_report_screen.dart';
import '../widgets/map/base_map.dart';
import '../widgets/map/bottom_sheet/bottom_list_sheet.dart';
import '../widgets/map/csv_export_button.dart';
import '../widgets/map/report_marker_icon.dart';
import '../widgets/map/report_marker.dart';
import '../models/user_report.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Stream userReportsStream =
      FirebaseFirestore.instance.collection('reports').snapshots();

  void setDate() {
    userReportsStream = FirebaseFirestore.instance
        .collection('reports')
        .where("date", isGreaterThan: DateTime(2023, 7, 22))
        .snapshots();
    setState(() {});
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
          BottomListSheet(
            userReportStream: userReportsStream,
            setDate: setDate,
          ),
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
