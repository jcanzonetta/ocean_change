import 'package:flutter/material.dart';

import '../../models/activity.dart';
import '../../models/user_report.dart';

class ActivityFormField extends StatefulWidget {
  const ActivityFormField(
      {super.key, required this.userReport, required this.activityList});

  final UserReport userReport;
  final List<Activity> activityList;

  @override
  State<StatefulWidget> createState() => _ActivtiyFormFieldState();
}

class _ActivtiyFormFieldState extends State<ActivityFormField> {
  late Activity chosenActivity;

  @override
  void initState() {
    super.initState();
    chosenActivity = widget.activityList.first;
    widget.userReport.activity =
        widget.activityList.firstWhere((element) => element.isDefault!).name;
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Row(
        children: [
          const Text('What were you doing today?'),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DropdownButton(
              value: widget.userReport.activity,
              icon: const Icon(Icons.arrow_downward),
              onChanged: (value) {
                setState(() {
                  widget.userReport.activity = value!;

                  chosenActivity = widget.activityList.firstWhere(
                      (element) => element.name == widget.userReport.activity);
                });
              },
              items: widget.activityList
                  .map<DropdownMenuItem<String>>((Activity activity) =>
                      DropdownMenuItem(
                          value: activity.name, child: Text(activity.name)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
