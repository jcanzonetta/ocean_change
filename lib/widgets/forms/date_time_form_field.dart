import 'package:flutter/material.dart';

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
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: OutlinedButton(
        child: Text('When was this observed?'),
        onPressed: _pickDateTime,
      ),
    );
  }

  void _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.userReport.date!,
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (pickedDate == null) {
      return;
    } else {
      setState(() {
        widget.userReport.date = pickedDate;
      });
    }
  }
}
