import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_change/models/user_report.dart';
import 'package:ocean_change/widgets/map/bottom_sheet/bottom_sheet_card.dart';

import '../../../screens/view_report_screen.dart';
import 'bottom_sheet_bar.dart';
import 'filter_bar.dart';

class BottomListSheet extends StatelessWidget {
  final Stream userReportStream;
  final Function setDate;

  const BottomListSheet(
      {super.key, required this.userReportStream, required this.setDate});

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
              setDate: setDate,
            ),
          );
        });
  }
}

class UserReportStreamBuilder extends StatefulWidget {
  final ScrollController scrollController;
  final Stream userReportsStream;
  final Function setDate;

  const UserReportStreamBuilder(
      {super.key,
      required this.scrollController,
      required this.userReportsStream,
      required this.setDate});

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
                BottomSheetAppBar(widget: widget),
                SliverList.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserReport report = UserReport.fromFirestore(
                        snapshot.data!.docs[index].data());

                    return BottomSheetCard(report: report);
                  },
                ),
              ]);
        } else {
          return const Icon(Icons.drag_handle);
        }
      },
    );
  }
}
