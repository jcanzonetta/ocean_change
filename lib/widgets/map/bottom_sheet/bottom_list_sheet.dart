import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';

class BottomListSheet extends StatelessWidget {
  const BottomListSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.05,
        maxChildSize: 0.85,
        snap: true,
        builder: (context, scrollController) {
          return Container(
            color: Colors.white,
            child: UserReportStreamBuilder(
              scrollController: scrollController,
            ),
          );
        });
  }
}

class UserReportStreamBuilder extends StatelessWidget {
  final ScrollController scrollController;

  const UserReportStreamBuilder({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('reports')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            controller: scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              UserReport report =
                  UserReport.fromFirestore(snapshot.data!.docs[index].data());

              return ListTile(
                title: Text(report.observation!),
              );
            },
          );
        } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Center(child: Text("There are no reports.")),
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
