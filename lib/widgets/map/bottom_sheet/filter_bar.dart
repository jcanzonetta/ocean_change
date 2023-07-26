import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final Function setDate;

  const FilterBar({super.key, required this.setDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Filter:'),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
          child: TextButton(
              onPressed: () {
                setDate();
              },
              child: const Icon(
                Icons.date_range_outlined,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
