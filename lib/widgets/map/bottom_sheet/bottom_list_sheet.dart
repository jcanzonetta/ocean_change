import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            itemCount: snapshot.data!.docs.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Icon(Icons.drag_handle);
              }

              UserReport report = UserReport.fromFirestore(
                  snapshot.data!.docs[index - 1].data());

              return ListTile(
                title: Text(report.observation!),
                subtitle: _populateSubtitle(report),
                trailing:
                    Text(DateFormat('MM-dd-yyyy hh:mm a').format(report.date!)),
              );
            },
          );
        } else {
          return const Center(
            child: Center(child: Text("There are no reports.")),
          );
        }
      },
    );
  }

  Widget? _populateSubtitle(UserReport report) {
    if (report.species != null) {
      return Text(report.species!);
    } else {
      return null;
    }
  }
}
