import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ocean_change/models/user_report.dart';

class DateTimeFormField extends StatefulWidget {
  const DateTimeFormField({super.key, required this.userReport});

  final UserReport userReport;

  @override
  State<DateTimeFormField> createState() => _DateTimeFormFieldState();
}

class _DateTimeFormFieldState extends State<DateTimeFormField> {
  @override
  void initState() {
    super.initState();
    widget.userReport.date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: OutlinedButton(
                onPressed: _pickDate,
                child: const Icon(Icons.calendar_month_outlined),
              ),
            ),
            Text(DateFormat('MM-dd-yyyy').format(widget.userReport.date!)),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OutlinedButton(
                onPressed: _pickTime,
                child: const Icon(Icons.schedule_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child:
                  Text(DateFormat('hh:mm a').format(widget.userReport.date!)),
            )
          ],
        ),
      ],
    );
  }

  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: widget.userReport.date!.hour,
            minute: widget.userReport.date!.minute));
    if (pickedTime == null) {
      return;
    } else {
      setState(() {
        DateTime tempDate = widget.userReport.date!;
        widget.userReport.date = DateTime(tempDate.year, tempDate.month,
            tempDate.day, pickedTime.hour, pickedTime.minute);
      });
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.userReport.date!,
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate == null) {
      return;
    } else {
      setState(() {
        TimeOfDay tempTime = TimeOfDay(
            hour: widget.userReport.date!.hour,
            minute: widget.userReport.date!.minute);
        widget.userReport.date = DateTime(pickedDate.year, pickedDate.month,
            pickedDate.day, tempTime.hour, tempTime.minute);
      });
    }
  }
}
