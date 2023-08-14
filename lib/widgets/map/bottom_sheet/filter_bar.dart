import 'package:flutter/material.dart';

import 'clear_filter_widget.dart';
import 'date_range_filter.dart';
import 'observation_filter.dart';

class FilterBar extends StatelessWidget {
  final Function setStreamQuery;

  const FilterBar({super.key, required this.setStreamQuery});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Filter:'),
        DateRangeFilter(setStreamQuery: setStreamQuery),
        ObservationFilter(setStreamQuery: setStreamQuery),
        ClearFilterWidget(setStreamQuery: setStreamQuery),
      ],
    );
  }
}
