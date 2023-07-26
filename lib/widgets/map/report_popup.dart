import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ocean_change/models/user_report.dart';
import '../../screens/view_report_screen.dart';

class ReportPopUp extends StatefulWidget {
  final Marker marker;
  final UserReport userReport;

  const ReportPopUp(this.marker, this.userReport, {super.key});

  @override
  State<ReportPopUp> createState() => _ReportPopUpState();
}

class _ReportPopUpState extends State<ReportPopUp> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ViewReportScreen.routeName,
            arguments: widget.userReport),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 50, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${widget.userReport.observation}',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
            Text(
              '${widget.userReport.date!.month}/${widget.userReport.date!.day}/${widget.userReport.date!.year}',
              style: const TextStyle(fontSize: 12.0),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            const Text(
              'Tap for more info',
              style: TextStyle(fontSize: 11.0, ),
            )
          ],
        ),
      ),
    );
  }
}
