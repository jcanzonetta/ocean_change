import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Filter:'),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
          child: TextButton(
              onPressed: () {},
              child: const Icon(
                Icons.date_range_outlined,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
