import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final Function setStreamQuery;

  const FilterBar({super.key, required this.setStreamQuery});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Filter:'),
        Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
            child: IconButton(
                onPressed: () async {
                  final DateTimeRange? range = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2023, 1, 1),
                      lastDate: DateTime.now());
                  setStreamQuery({'date': range});
                },
                icon: const Icon(
                  Icons.date_range_outlined,
                  color: Colors.white,
                ))),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
          child: IconButton(
            onPressed: () {
              setStreamQuery(null);
            },
            icon: const Icon(Icons.clear, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
