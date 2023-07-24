import 'package:flutter/material.dart';

import '../../components/csv_exporter.dart';

class CSVExportButton extends StatelessWidget {
  const CSVExportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        exportCSV();
      },
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: const Text('CSV'),
    );
  }
}
