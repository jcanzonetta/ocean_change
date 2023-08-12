import 'package:flutter/material.dart';

class ClearFilterWidget extends StatelessWidget {
  const ClearFilterWidget({
    super.key,
    required this.setStreamQuery,
  });

  final Function setStreamQuery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
      child: IconButton(
        onPressed: () {
          setStreamQuery(null);
        },
        icon: const Icon(Icons.clear, color: Colors.white),
      ),
    );
  }
}
