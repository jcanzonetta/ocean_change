import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/user_report.dart';

String convertToCSVString(List<List<dynamic>> listOfLists) {
  return const ListToCsvConverter().convert(listOfLists);
}

List<List<dynamic>> convertQuerySnapshotToList(
    QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  List<List<dynamic>> csvList = [UserReport().csvHeaderList()];

  for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
      in querySnapshot.docs) {
    final report = UserReport.fromFirestore(docSnapshot.data());

    csvList.add(report.toCSVList());
  }

  return csvList;
}

Future<XFile> generateCSV(String csvString) async {
  final Directory tempDir = await getTemporaryDirectory();

  File csvFile = File('${tempDir.path}/ocean_change_export.csv');

  await csvFile.writeAsString(csvString);

  return XFile(csvFile.path);
}

void exportCSV() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('reports').get();

  List<List<dynamic>> csvList = convertQuerySnapshotToList(querySnapshot);

  String csvString = convertToCSVString(csvList);

  XFile csvXFile = await generateCSV(csvString);

  Share.shareXFiles([csvXFile]);
}
