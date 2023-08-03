import 'package:flutter/material.dart';

import '../../../models/user_report.dart';
import 'latitude_entry_field.dart';
import 'longitude_entry_field.dart';

class LatLongBox extends StatelessWidget {
  const LatLongBox({
    super.key,
    required TextEditingController latController,
    required this.userReport,
    required TextEditingController longController,
    required this.updatePositionTarget,
  })  : _latController = latController,
        _longController = longController;

  final TextEditingController _latController;
  final UserReport userReport;
  final TextEditingController _longController;
  final Function updatePositionTarget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 1 / 24,
      left: MediaQuery.of(context).size.width * 1 / 8,
      width: MediaQuery.of(context).size.width * 3 / 4,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                LatitudeEntryField(
                    latController: _latController,
                    userReport: userReport,
                    updatePositionTarget: updatePositionTarget),
                LongitudeEntryField(
                    longController: _longController,
                    userReport: userReport,
                    updatePositionTarget: updatePositionTarget),
              ],
            ),
          )),
    );
  }
}
