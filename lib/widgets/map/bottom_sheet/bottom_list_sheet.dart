import 'package:flutter/material.dart';
import 'package:ocean_change/models/user_report.dart';
import 'package:ocean_change/widgets/map/bottom_sheet/bottom_sheet_card.dart';

import 'bottom_sheet_app_bar.dart';

class BottomListSheet extends StatelessWidget {
  final Stream userReportStream;
  final Function setStreamQuery;
  final bool adminStatus;

  const BottomListSheet(
      {super.key,
      required this.userReportStream,
      required this.setStreamQuery,
      required this.adminStatus});

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
              userReportsStream: userReportStream,
              setStreamQuery: setStreamQuery,
              adminStatus: adminStatus,
            ),
          );
        });
  }
}

class UserReportStreamBuilder extends StatefulWidget {
  final ScrollController scrollController;
  final Stream userReportsStream;
  final Function setStreamQuery;
  final bool adminStatus;

  const UserReportStreamBuilder(
      {super.key,
      required this.scrollController,
      required this.userReportsStream,
      required this.setStreamQuery,
      required this.adminStatus});

  @override
  State<UserReportStreamBuilder> createState() =>
      _UserReportStreamBuilderState();
}

class _UserReportStreamBuilderState extends State<UserReportStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.userReportsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                BottomSheetAppBar(setStreamQuery: widget.setStreamQuery),
                SliverList.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserReport report = UserReport.fromFirestore(
                        snapshot.data!.docs[index].data(),
                        snapshot.data!.docs[index].id);

                    return BottomSheetCard(
                      report: report,
                      adminStatus: widget.adminStatus,
                    );
                  },
                ),
              ]);
        } else {
          return CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              BottomSheetAppBar(setStreamQuery: widget.setStreamQuery),
              const SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Center(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('No matching reports were found.'),
                  ))
                ]),
              )
            ],
          );
        }
      },
    );
  }
}
