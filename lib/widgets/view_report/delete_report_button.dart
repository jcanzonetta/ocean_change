import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_report.dart';

class DeleteReportButton extends StatefulWidget {
  final User? currentUser;
  final UserReport userReport;
  final bool adminStatus;
  const DeleteReportButton(
      {super.key, required this.currentUser, required this.userReport, required this.adminStatus});

  @override
  State<DeleteReportButton> createState() => _DeleteReportButtonState();
}

class _DeleteReportButtonState extends State<DeleteReportButton> {
  @override
  Widget build(BuildContext context) {
    return _deleteReportButtonCheck(
        context, widget.currentUser, widget.userReport, widget.adminStatus);
  }

  Widget _deleteReportButtonCheck(BuildContext context, User? currentUser,
      UserReport userReport, bool adminStatus) {
    if (currentUser?.email == userReport.user || adminStatus == true) {
      return ElevatedButton(
          onPressed: () => deleteReport(context, userReport),
          child: const Text("Delete Report"));
    } else {
      return Container();
    }
  }

  void deleteReport(BuildContext context, UserReport userReport) async {
    FirebaseFirestore.instance
        .collection("reports")
        .doc(userReport.id)
        .delete();

    if (userReport.photoURL != null) {
      final imageRef =
          FirebaseStorage.instance.refFromURL(userReport.photoURL.toString());
      await imageRef.delete();
    }
    setState(() {
      Navigator.pop(context);
    });
  }
}
