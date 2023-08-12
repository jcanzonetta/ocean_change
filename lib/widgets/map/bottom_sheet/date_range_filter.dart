import 'package:flutter/material.dart';

class DateRangeFilter extends StatelessWidget {
  const DateRangeFilter({
    super.key,
    required this.setStreamQuery,
  });

  final Function setStreamQuery;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
        child: IconButton(
            onPressed: () async {
              final DateTimeRange? pickedRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2023, 1, 1),
                  lastDate: DateTime.now());

              if (pickedRange != null) {
                final DateTimeRange range = DateTimeRange(
                    start: pickedRange.start,
                    end: pickedRange.end.add(const Duration(days: 1)));

                setStreamQuery({'date': range});
              }
            },
            icon: const Icon(
              Icons.date_range_outlined,
              color: Colors.white,
            )));
  }
}
