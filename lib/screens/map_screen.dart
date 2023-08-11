import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_change/widgets/login/sign_out_button.dart';
import 'package:ocean_change/widgets/map/admin_button.dart';

import 'create_report_screen.dart';

import '../models/user_report.dart';

import '../widgets/map/base_map.dart';
import '../widgets/map/bottom_sheet/bottom_list_sheet.dart';
import '../widgets/map/csv_export_button.dart';
import '../widgets/map/report_marker_icon.dart';
import '../widgets/map/report_marker.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = 'MapScreen';

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Stream userReportsStream = FirebaseFirestore.instance
      .collection('reports')
      .orderBy('date', descending: true)
      .snapshots();
  late Query userReportQuery;
  Map activeQuery = {};
  // variable to track if user is an admin. Passed throughout the app
  bool adminStatus = false;

  @override
  void initState() {
    super.initState();
    // Check if logged in user is an admin and update status if so
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final usersData = FirebaseFirestore.instance.collection("users");
    usersData
        .where("email", isEqualTo: currentUser!.email)
        .get()
        .then((querySnapshot) {
      final currentUserData = querySnapshot.docs[0].data();
      if (currentUserData['admin'] == true) {
        setState(() => adminStatus = true);
      }
    });
    setOneWeekQuery();
  }

  void setOneWeekQuery() {
    DateTime now = DateTime.now();
    DateTime initStart = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 7));
    DateTime initEnd =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 1));

    userReportQuery = FirebaseFirestore.instance
        .collection('reports')
        .where("date", isGreaterThanOrEqualTo: initStart)
        .where('date', isLessThanOrEqualTo: initEnd);

    setState(() {
      userReportsStream =
          userReportQuery.orderBy('date', descending: true).snapshots();
    });

    activeQuery['date'] = {'start': initStart, 'end': initEnd};
  }

  void setStreamQuery(Map? query) {
    // Clear Filter
    if (query == null) {
      activeQuery = {};
      userReportQuery = FirebaseFirestore.instance.collection('reports');
      userReportsStream =
          userReportQuery.orderBy('date', descending: true).snapshots();
      setState(() {});
      return;
    }

    // Date
    if (query['date'] != null) {
      if (activeQuery.containsKey('date')) {
        userReportQuery = FirebaseFirestore.instance.collection('reports');

        if (activeQuery.containsKey('observation')) {
          userReportQuery.where('observation',
              whereIn: activeQuery['observation']);
        }
      }

      DateTime start = query['date'].start;
      DateTime end = query['date'].end;

      if (query['date'].start == query['date'].end) {
        end = query['date'].end.add(const Duration(days: 1));
      }

      activeQuery['date'] = {'start': start, 'end': end};

      userReportQuery = userReportQuery
          .where("date", isGreaterThanOrEqualTo: start)
          .where('date', isLessThanOrEqualTo: end);
    }

    // Observation
    if (query['observation'] != null) {
      if (activeQuery.containsKey('observation')) {
        userReportQuery = FirebaseFirestore.instance.collection('reports');

        if (activeQuery.containsKey('date')) {
          userReportQuery
              .where('date',
                  isGreaterThanOrEqualTo: activeQuery['date']['start'])
              .where('date', isLessThanOrEqualTo: activeQuery['date']['end']);
        }
      }

      activeQuery['observation'] = query['observation'];

      userReportQuery =
          userReportQuery.where('observation', whereIn: query['observation']);
    }

    userReportsStream =
        userReportQuery.orderBy('date', descending: true).snapshots();

    setState(() {});
  }

  List<Widget> getAppBarButtons(bool adminStatus) {
    if (adminStatus == true) {
      return const [CSVExportButton(), AdminButton(), SignOutButton()];
    } else {
      return const [CSVExportButton(), SignOutButton()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ocean Change'),
        actions: getAppBarButtons(adminStatus),
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
                    final report = UserReport.fromFirestore(
                        docSnapshot.data(), docSnapshot.id);
                    reportMarkers.add(ReportMarker(
                        userReport: report,
                        builder: (context) =>
                            ReportMarkerIcon(observation: report.observation)));
                  }
                  return BaseMap(
                      reportMarkers: reportMarkers, adminStatus: adminStatus);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          BottomListSheet(
            userReportStream: userReportsStream,
            setStreamQuery: setStreamQuery,
            adminStatus: adminStatus,
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
